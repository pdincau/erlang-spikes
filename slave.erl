-module(slave).
-export([loop/1]).

loop(_Params) ->
    receive
        {status, Pid} ->
            Pid ! {status, "i am ok"},
            loop(_Params)
    end.
