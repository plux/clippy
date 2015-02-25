%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% @doc
%%%
%%% Small interface to xclip from Erlang.
%%%
%%% Example usage:
%%%
%%%   1> clippy:get().
%%%   "Content of clipboard"
%%%
%%%   2> clippy:put(hello).
%%%   ok
%%%
%%%   3> clippy:get().
%%%   hello
%%%
%%% @copyright 2014 Håkan Nilsson
%%% @end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-module(clippy).

-export([ put/1
        , get/0
        ]).

%%%_* API ==============================================================
-spec put(term()) -> ok.
put(Term) ->
  Str = lists:flatten(io_lib:format("~p", [Term])),
  Cmd = io_lib:format("echo -n \"~s\" | xclip", [escape(Str)]),
  os:cmd(Cmd),
  ok.

-spec get() -> term().
get() ->
  Str = os:cmd("xclip -o"),
  try string_to_term(Str)
  catch _:_ -> Str
  end.

%%%_* Helpers ==========================================================
escape(Str) ->
  lists:flatmap(fun($") -> "\\\"";
                   (C)  -> [C]
                end, Str).

string_to_term(Str0) ->
  Str                    = ensure_trailing_period(Str0),
  {ok, Tokens, _EndLine} = erl_scan:string(Str),
  {ok, AbsForm}          = erl_parse:parse_exprs(Tokens),
  {value, Value, _Bs}    = erl_eval:exprs(AbsForm, erl_eval:new_bindings()),
  Value.

ensure_trailing_period(Str) ->
  case lists:last(Str) of
    $. -> Str;
    _  -> Str ++ "."
  end.

%%%_* Emacs ============================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
