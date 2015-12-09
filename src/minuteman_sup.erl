-module(minuteman_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    {ok, { {rest_for_one, 5, 10}, [?CHILD(minuteman_ipsets, worker),
        ?CHILD(minuteman_vip_server, worker),
        ?CHILD(minuteman_mesos_poller, worker),
        ?CHILD(minuteman_network_sup, supervisor)
    ]} }.
