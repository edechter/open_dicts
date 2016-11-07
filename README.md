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


Tests
-----

Tests can be run using [```library(tap)```](https://github.com/mndrix/tap) and any TAP harness (in the example below: [prove](http://search.cpan.org/dist/Test-Harness/bin/prove)). E.g:

```sh
$ prove -v --ext=pl -j4 -r -e 'swipl -q -f dev.pl -t main -s' t/

ok 1 - open and close
ok 2 - unify open dicts 01
ok 3 - unify open dicts 02
ok 4 - contains/3 01
ok 5 - contains/3 02
ok 6 - contains/3 03
ok 7 - contains/3 04
ok 8 - contains/3 05
ok 9 - contains/3 06
ok 10 - contains/3 07
ok 11 - chain of contains/3
ok
All tests successful.
Files=1, Tests=11,  0 wallclock secs ( 0.04 usr  0.00 sys +  0.03 cusr  0.00 csys =  0.07 CPU)
Result: PASS


```
