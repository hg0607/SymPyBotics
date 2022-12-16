""" Utilities """

from sympy import Matrix


identity = lambda x: x


def sym_skew(v):
    if len(v) == 3:
        return Matrix([[0,     -v[2],  v[1]],
                   [v[2],      0, -v[0]],
                   [-v[1],  v[0],     0]])
    elif len(v) == 1:
        return Matrix([[0,     0,  0],
                   [0,      0, -v[0]],
                   [0,  v[0],     0]])
    else:
        raise Exception('dimension of v error')
