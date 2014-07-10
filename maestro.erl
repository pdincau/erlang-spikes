-module(maestro).
-export([start/0, stop/0, loop/1]).
-export([add/1, monitor/1]).

start() ->
    Procs = [],
    register(?MODULE, spawn(?MODULE, loop, [Procs])).

stop() ->
    ?MODULE ! stop.

add({Name, Params}) ->
    Pid = spawn(slave, loop, [Params]),
    ?MODULE ! {add, {Name, Pid}},
    ok.

monitor(Name) ->
    ?MODULE ! {monitor, Name},
    ok.

loop(Procs) ->
    receive
        stop -> ok;
        {add, {Name, Pid}} ->
            io:format("Added process with name ~p and pid: ~p~n", [Name, Pid]),
            loop([{Name, Pid}|Procs]);
        {monitor, Name} ->
            io:format("Procs are: ~p~n", [Procs]),
            Pid = proplists:get_value(Name, Procs),
            io:format("Here you must contact process with name ~p and pid: ~p~n", [Name, Pid]),
            Pid ! {status, self()},
            loop(Procs);
        {status, Status} ->
            io:format("reply for status request:~p~n", [Status]),
            loop(Procs);
        _ ->
            io:format("Unrecognized command.~n", []),
            loop(Procs)
    end.
