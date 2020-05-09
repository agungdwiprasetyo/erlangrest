%%%-------------------------------------------------------------------
%% @doc erlangrest public API
%% @end
%%%-------------------------------------------------------------------

-module(erlangrest_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
                                      {'_', [ 
                                            {"/", index, []}
                                      ]}
                                   ]),
    {ok, _} = cowboy:start_clear(http, [{port, 4000}], #{
            env => #{dispatch => Dispatch}
    }),
    erlangrest_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
