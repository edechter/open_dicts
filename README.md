Open Dicts for SWI Prolog
=========================

Synopsis
--------

```prolog

?- use_module(library(open_dicts)).

?- A = _{a: 1, ... : ...}, B = _{b : 1, ... : ...}, A = B.
A = B,
open_dict(_104{a:1, b:1}, B).

?- A = _{a: X, ... : ...}, contains(A, [a-1, b-2]).
X = 1,
open_dict(_3520{a:1, b:2}, A).

?- A = _{a:Val, b:2, ... : ...}, B = _{a:1, c:3, ... : ...}, A = B.
A = B,
Val = 1,
open_dict(_4266{a:1, b:2, c:3}, B).

?- A = _{a:Val, b:2, ... : ...}, B = _{a:1, c:3, ... : ...}, A = B, close_dict(B).
A = B, B = _50{a:1, b:2, c:3},
Val = 1.

?- A = _{a: _{b:1, ... : ...}, ... : ...}, B = A.^a.^b.
B = 1,
open_dict(_1430{a:_1434}, A),
open_dict(_1450{b:1}, _1434).

?- A = _{a: _{b:X, ... : ...}, ... : ...}, A.^a.^b = 1.
X = 1,
open_dict(_5378{a:_5382}, A),
open_dict(_5398{b:1}, _5382).

```


Dependencies
------------
* SWI Prolog pack [```library(function_expansion)```](https://github.com/mndrix/function_expansion).


Tests
-----

Tests can be run using [```library(tap)```](https://github.com/mndrix/tap) and any TAP harness (in the example below: [prove](http://search.cpan.org/dist/Test-Harness/bin/prove)). E.g:

```sh
$ prove -v --ext=pl -j4 -r -e 'swipl -q -f dev.pl -t main -s' t/
```
