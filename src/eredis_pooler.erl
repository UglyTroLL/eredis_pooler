%%%-------------------------------------------------------------------
%%% @author uglytroll
%%% @doc
%%%
%%% @end
%%% Created : 29. Apr 2014 11:25 PM
%%%-------------------------------------------------------------------
-module(eredis_pooler).
-author("uglytroll").

-define(REDIS_TIMEOUT, 4000).

%% API
-export([start/0, stop/0]).

-export([q/2, q/3]).

start() ->
  application:ensure_all_started(eredis_pooler).

stop() ->
  application:stop(eredis_pooler).

%%--------------------------------------------------------------------
%% @doc
%% Executes the given command in the specified connection. The
%% command must be a valid Redis command and may contain arbitrary
%% data which will be converted to binaries. The returned values will
%% always be binaries.
%% @end
%%--------------------------------------------------------------------
-spec q(PoolName::atom(), Command::iolist()) ->
  {ok, binary() | [binary()]} | {error, Reason::binary()}.

q(PoolName, Command) ->
  q(PoolName, Command, ?REDIS_TIMEOUT).

-spec q(PoolName::atom(), Command::iolist(), Timeout::integer()) ->
  {ok, binary() | [binary()]} | {error, Reason::binary()}.

q(PoolName, Command, Timeout) ->
  RedisConn = pooler:take_member(PoolName),
  Result = eredis:q(RedisConn, Command, Timeout),
  pooler:return_member(PoolName, RedisConn, ok),
  Result.