%%%-------------------------------------------------------------------
%%% @author Evstafiev Nicolae
%%% @copyright (C) 2022, FAF-191
%%% @doc Tweet-Analyzer main supervisor.
%%% @end
%%%-------------------------------------------------------------------

-module(rtp_sup).
-author("Evstafiev Nicolae").

-behaviour(supervisor).

-define(TWEET_1, "http://127.0.0.1:4000/tweets/1").
-define(TWEET_2, "http://127.0.0.1:4000/tweets/2").

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    io:format("[~p] Tweet-Analyzer' superviser's `init` is called.~n", [self()]),

    MaxRestarts = 100,
    MaxSecondsBetweenRestarts = 10,
    SupFlags = #{
        strategy => one_for_one,
        intensity => MaxRestarts,
        period => MaxSecondsBetweenRestarts
    },

    SSEHandlerSup = sse_handler_sup:get_specs([?TWEET_1, ?TWEET_2]),
    WorkerSup = worker_sup:get_specs(),
    WorkerManager = worker_manager:get_specs(),
    WorkerScaler = worker_scaler:get_specs(),

    ChildSpecs = [
        WorkerSup,
        WorkerManager,
        WorkerScaler,
        SSEHandlerSup
    ],

    {ok, {SupFlags, ChildSpecs}}.
