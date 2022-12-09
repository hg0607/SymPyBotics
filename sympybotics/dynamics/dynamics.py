import sympy
import numpy
from sympy import zeros
from copy import deepcopy
from .rne import rne, gravityterm, coriolisterm, coriolismatrix,\
    frictionterm, inertiamatrix
from .regressor import regressor
from .dyn_parm_dep import find_dyn_parm_deps
# reference: Sousa, Crist¨®v?o D. and Rui Pedro Duarte Cortes?o. ¡°Physical feasibility of robot base inertial parameter identification: A linear matrix inequality approach.¡± The International Journal of Robotics Research 33 (2014): 931 - 944.

class Dynamics(object):

    def __init__(self, rbtdef, geom):

        self.rbtdef = rbtdef
        self.geom = geom
        self.dof = rbtdef.dof

        self.dynparms = sympy.Matrix(rbtdef.dynparms())
        self.n_dynparms = len(self.dynparms)

    def gen_invdyn(self, ifunc=None):
        self.invdyn = rne(self.rbtdef, self.geom, ifunc)

    def gen_statics(self, ifunc=None):  
        self.statics = gravityterm(self.rbtdef, self.geom, ifunc) + frictionterm(self.rbtdef, ifunc)

    def gen_gravityterm(self, ifunc=None):
        self.g = gravityterm(self.rbtdef, self.geom, ifunc)

    def gen_coriolisterm(self, ifunc=None):
        self.c = coriolisterm(
            self.rbtdef, self.geom, ifunc)

    def gen_nocoriolisterm(self, ifunc=None):
        rbtdeftmp1 = deepcopy(self.rbtdef)
        rbtdeftmp1.dq = zeros(rbtdeftmp1.dof, 1)
        rbtdeftmp1.frictionmodel = None     
        self.noc = rne(rbtdeftmp1, self.geom, ifunc) + frictionterm(self.rbtdef, ifunc)

    def gen_coriolismatrix(self, ifunc=None):
        self.C = coriolismatrix(
            self.rbtdef, self.geom, ifunc)

    def gen_frictionterm(self, ifunc=None):
        self.f = frictionterm(self.rbtdef, ifunc)

    def gen_inertiamatrix(self, ifunc=None):
        self.M = inertiamatrix(
            self.rbtdef, self.geom, ifunc)

    def gen_regressor(self, ifunc=None):
        self.H = regressor(self.rbtdef, self.geom, ifunc)

    def gen_all(self, ifunc=None):
        self.gen_invdyn(ifunc)
        self.gen_statics(ifunc)
        self.gen_gravityterm(ifunc)
        self.gen_coriolisterm(ifunc)
        self.gen_nocoriolisterm(ifunc)
        self.gen_inertiamatrix(ifunc)
        self.gen_regressor(ifunc)

    def calc_base_parms(self, regressor_func):

        Pb, Pd, Kd = find_dyn_parm_deps(
            self.dof, self.n_dynparms, regressor_func)

        self.Pb = sympy.Matrix(Pb).applyfunc(lambda x: x.nsimplify())
        self.Pd = sympy.Matrix(Pd).applyfunc(lambda x: x.nsimplify())
        self.Kd = sympy.Matrix(Kd).applyfunc(lambda x: x.nsimplify())

        self.base_idxs = \
            (numpy.matrix([[i for i in range(self.n_dynparms)]]) *
             numpy.matrix(Pb)).astype(float).astype(int).tolist()[0]

        self.baseparms = (self.Pb.T + self.Kd * self.Pd.T) * self.dynparms #EQ39
        self.n_base = len(self.baseparms)
