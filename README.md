Open Dicts for SWI Prolog
=========================

Synopsis
--------

```prolog

?- use_module(library(open_dicts)).

?- open_dict(foo{bar:1}, D1), open_dict(foo{baz:2}, D2), D1 = D2, close_dict(D1, D3).
D1 = D2,
D3 = foo{bar:1, baz:2},
open_dict(foo{bar:1, baz:2}, D2).

?- open_dict(D), contains(D, _{a:1}), contains(D, [b=1, c = 3]).
open_dict(_7822{a:1, b:1, c:3}, D).

```
