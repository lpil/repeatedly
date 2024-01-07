-module(repeatedly_ffi).

% Public API
-export([call/3, stop/1, replace/2, set_state/2]).

% Gen server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).

-record(state, { state, function, delay_ms, index }).

call(DelayMs, State, Function) ->
    S = #state{
        function = Function,
        delay_ms = DelayMs,
        state = State,
        index = 0
    },
    {ok, Pid} = gen_server:start_link(?MODULE, S, []),
    Pid.

replace(Pid, Function) ->
    erlang:send(Pid, {replace, Function}).

set_state(Pid, State) ->
    erlang:send(Pid, {set_state, State}).

stop(Pid) ->
    erlang:send(Pid, stop).

init(State) ->
    schedule_next(State),
    {ok, State}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(tick, State = #state{function = F, index = I, state = S}) ->
    New = F(S, I),
    schedule_next(State),
    {noreply, State#state{state = New, index = I + 1}};

handle_info({replace, F}, State) ->
    {noreply, State#state{function = F}};

handle_info({set_state, S}, State) ->
    {noreply, State#state{state = S}};

handle_info(stop, _) ->
    {stop, normal, ok};

handle_info(_Info, State) ->
    {noreply, State}.

schedule_next(#state{delay_ms = DelayMs}) ->
    erlang:send_after(DelayMs, self(), tick).
