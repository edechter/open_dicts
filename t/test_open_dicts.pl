
:- use_module(library(open_dicts)).

:- use_module(library(tap)).

'open and close' :-
    D = d{a:1},
    open_dict(D, X),
    close_dict(X, D1),
    D1 == D.

'unify open dicts 01' :-
    open_dict(d{a:1}, O1),
    open_dict(d{b:1}, O2),
    O1 = O2,
    close_dict(O1, D),
    D == d{a:1, b:1}.

'unify open dicts 02' :-
    open_dict(d{a:2, b:1}, O1),
    open_dict(d{a:1}, O2),
    O1 \= O2.

'unify open dict with close dict 01' :-
    open_dict(d{a:2}, D),
    D = d{a:2}.

'unify open dict with close dict 02' :-
    open_dict(d{a:2}, D),
    D = d{a:2, b:2}.

'unify open dict with close dict 03'(fail) :-
    open_dict(d{a:1}, D),
    D = d{a:2, b:2}.

'close open dict 01' :-
    open_dict(d{a:1}, D),
    close_dict(D, D),
    D == d{a:1}.

'contains/3 01' :-
    open_dict(a{}, O),
    contains(O, _{b:2}),
    close_dict(O, a{b:2}).

'contains/3 02' :-
    open_dict(a{b:_}, O),
    contains(O, _{b:2}),
    close_dict(O, a{b:2}).

'contains/3 03' :-
    open_dict(a{b:1}, O),
    \+ contains(O, _{b:2}).

'contains/3 04' :-
    open_dict(a{b:1}, O),
    contains(O, a{}).

'contains/3 05' :-
    open_dict(a{b:1}, O),
    \+ contains(O, b{}).

'contains/3 06' :-
    open_dict(a{b:1, c:2, d:5}, O),
    contains(O, _{c:2, e:6}),
    close_dict(O, a{b:1, c:2, d:5, e:6}).

'contains/3 07' :-
    open_dict(a{b:1, c:2, d:5}, O),
    contains(O, _{c:X}),
    X == 2.

'chain of contains/3' :-
    open_dict(O),
    contains(O, _{a:1}),
    contains(O, _{b:2}),
    contains(O, a{c:3}),
    close_dict(O, a{a:1, b:2, c:3}).


'syntactic sugar 01' :-
    A = _{a:2, ... : ...},
    A = _{b:3, ... : ...},
    A = _{a:2, b:3}.

'syntactic sugar 02' :-
    _{b:3, c:X, ... : ...} = _{c: foo, a:2, ... : ...},
    X == foo.

'syntactic sugar 03' :-
    D = _{a:1, b:2, ... : ...}, 
    A = D.^a,
    A == 1.

'syntactic sugar 04' :-
    A = _{a: _{b:1, ... : ...}, ... : ...},
    B = A.^a.^b,
    B == 1.
