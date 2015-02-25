%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% @doc Unit tests for clippy
%%%
%%% @copyright 2014 Håkan Nilsson
%%% @end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-module(clippy_tests).
-include_lib("eunit/include/eunit.hrl").

%%%_* Tests ============================================================
basic_get_put_test_() ->
  [ ?_assertEqual(hej, put_get(hej))
  , ?_assertEqual("Hej", put_get("Hej"))
  , ?_assertEqual({hej, "hej", 123}, put_get({hej, "hej", 123}))
  ].

put_get(Term) ->
  clippy:put(Term),
  clippy:get().


%%%_* Helpers ==========================================================

%%%_* Emacs ============================================================
%%% Local Variables:
%%% allout-layout: t
%%% erlang-indent-level: 2
%%% End:
