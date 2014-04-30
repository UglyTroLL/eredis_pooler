%%%-------------------------------------------------------------------
%%% @author uglytroll
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 30. Apr 2014 12:26 AM
%%%-------------------------------------------------------------------
-module(eredis_pooler_sup).
-author("uglytroll").
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
  PoolerSup = {pooler_sup, {pooler_sup, start_link, []},
    permanent, infinity, supervisor, [pooler_sup]},
  {ok, {{one_for_one, 5, 10}, [PoolerSup]}}.