
:- module(open_dicts, [
              open_dict/1,
              open_dict/2,
              close_dict/1,
              close_dict/2,
              contains/2,
              op(210, yfx, '.^'),
              op(200, yf, '+')
          ]).

/** <module> Open Dicts for SWI Prolog

@author:Eyal Dechter <eyaldechter@gmail.com>

*/


%% Library Imports
%% ===============
:- use_module(library(function_expansion)).


:- op(210, yfx, '.^').
:- op(200, yf, '+').


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

%!    close_dict(+Open)
close_dict(O) :-
    close_dict(O, O). 

%!    contains(+Open, Data) is nondet
%
contains(Open, Data) :-
    dict_create(D, _, Data),
    open_dict(D, Open1),
    Open = Open1.

%!    open_dict_get(KeyPath, Open, Value)
%
open_dict_get(KeyPath, Open, Value) :-
    must_be(open_dict, Open),
    must_be(ground, KeyPath),
    
    (KeyPath = (K.^KeyPath1) ->
         open_dict_get(K, Open, Open1),
         open_dict_get(KeyPath1, Open1, Value)
    ; % otherwise -> 
      Key = KeyPath, 
      dict_create(Dict, _, [Key-Value]),
      open_dict(Dict, Open1),
      Open = Open1
    ).
    






%!    unify_dicts(+Open1, +Open2, ?Open) is det
%
unify_dicts(Open1, Open2, Unified) :-
    Open1 >:< Open2,    
    Unified = Open1.put(Open2). 


attr_unify_hook(Dict, Other) :-
    (get_attr(Other, open_dicts, Dict1) ->
         unify_dicts(Dict, Dict1, Unified),
         put_attr(Other, open_dicts, Unified)
    ;
    var(Other) ->
         put_attr(Other, open_dicts, Dict)
    ;
    is_dict(Other) ->
         unify_dicts(Dict, Other, Other)
    ;
    domain_error(unwrapped_open_dict, Other)
    ).

attribute_goals(Open) -->
    {get_attr(Open, open_dicts, Dict)},    
    [open_dict(Dict, Open)].


:- multifile user:portray/1.
user:portray(V) :-
    get_attr(V, open_dicts, D),
    format('~p', [open_dict(D, V)]).
    
user:portray(V) :-
    nonvar(V),
    V = open_dict(Dict, Open),
    format('~@ = ~p+', [write_term(Open, [attributes(ignore), numbervars(true)]), Dict]).
    
    
    
    


/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     Syntactic sugar
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

:- multifile user:function_expansion/2.

user:function_expansion(In, Out, Guard) :-
    nonvar(In),
    In = D + , 
    Guard = open_dict(D, Out).

user:function_expansion(In, Out, Guard) :-
    nonvar(In),
    In = Open .^ KeyPath,    
    Guard = (open_dict(Open), open_dicts:open_dict_get(KeyPath, Open, Out)).

    
    
    
    
    
    
    
            
    
         
         









