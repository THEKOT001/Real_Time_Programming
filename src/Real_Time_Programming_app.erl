%%%-------------------------------------------------------------------
%% @doc Real_Time_Programming public API
%% @end
%%%-------------------------------------------------------------------

-module(Real_Time_Programming_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Real_Time_Programming_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
