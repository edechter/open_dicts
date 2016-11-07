
:- prolog_load_context(directory, Dir),
   format(string(S), '~w/prolog', [Dir]), 
   asserta(user:file_search_path(library, S)).

:- use_module(library(open_dicts)).



