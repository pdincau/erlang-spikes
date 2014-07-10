-module(slave).
-export([loop/1]).

loop(Params) ->
    receive
        {status, Pid} ->
            Pid ! {status, "i am ok"},
            loop(Params)
    end.
