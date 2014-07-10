How to run:

    $ erlc *.erl
    $ erl
    1> maestro:start().
    true
    2> maestro:add({name1, params1}).
    Added process with name name1 and pid: <0.36.0>
    ok
    3> maestro:monitor(name1).
    Procs are: [{name1,<0.36.0>}]
    Here you must contact process with name name1 and pid: <0.36.0>
    ok
    reply for status request:"i am ok"
