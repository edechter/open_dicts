
:- module(open_dicts, [
              open_dict/1,
              open_dict/2,
              close_dict/2,
              contains/2
          ]).

/** <module> Brief

Description

@author:Eyal Dechter <eyaldechter@gmail.com>

*/

:- multifile error:has_type/2.
error:has_type(open_dict, O) :-
    var(O), 
    get_attr(O, open_dicts, _).


%!    open_dict(?Dict, ?Open) 
%
open_dict(Dict, Open) :-
    must_be(dict, Dict),
    put_attr(X, open_dicts, Dict),
    Open = X.

%!    open_dict(?Open) 
%
open_dict(Open) :-
    open_dict(_{}, Open).


%!    close_dict(+Open, ?Dict) is det
%
close_dict(Open, Closed) :-
    must_be(open_dict, Open),
    get_attr(Open, open_dicts, Closed).

%!    contains(+Open, Data) is nondet
%
contains(Open, Data) :-
    dict_create(D, _, Data),
    open_dict(D, Open1),
    Open = Open1.


%!    unify_open_dicts(+Open1, +Open2, ?Open) is det
%
unify_open_dicts(Open1, Open2, Unified) :-
    Open1 >:< Open2,    
    Unified = Open1.put(Open2). 


attr_unify_hook(Dict, Other) :-
    (get_attr(Other, open_dicts, Dict1) ->
         unify_open_dicts(Dict, Dict1, Unified),
         put_attr(Other, open_dicts, Unified)
    ;
    var(Other) ->
         put_attr(Other, open_dicts, Dict)
    ;
    domain_error(unwrapped_open_dict, Other)
    ).

attribute_goals(Open) -->
    {get_attr(Open, open_dicts, Dict)},
    [open_dict(Dict, Open)].
    




    
         
         









