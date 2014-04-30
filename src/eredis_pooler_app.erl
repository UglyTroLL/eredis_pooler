-module(eredis_pooler_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
  {ok, PoolConfigs} = application:get_env(eredis_pooler, pools),
  Result = eredis_pooler_sup:start_link(),
  [pooler:new_pool(PoolConfig) || PoolConfig <- PoolConfigs],
  Result.

stop(_State) ->
    ok.
