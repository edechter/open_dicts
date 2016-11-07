
:- use_module(library(open_dicts)).

s(S) --> np(NP), vp(VP), {
    S.^head = VP.^head,
    S.^head.^subject = NP.^head
}.

np(NP) --> [we], {
    NP.^head.^agreement.^number = plural,
    NP.^head.^agreement.^person = first
}.

np(NP) --> [uther], {
    NP.^head.^agreement.^number = singular,
    NP.^head.^agreement.^person = third
}.

vp(VP) --> v(V), {
    VP.^head = V.^head
}.

v(V) --> [sleeps], {
    V.^head.^form = finite,
    V.^head.^subject.^agreement.^number = singular,
    V.^head.^subject.^agreement.^person = third
         }.

v(V) --> [sleep], {
    V.^head.^form = finite,
    V.^head.^subject.^agreement.^number = plural
}.


:- set_prolog_flag(write_attributes, portray).


go :-
    forall(phrase(s(S), X, []),
           (user:portray(S), nl)
           ).
