-module(repeatedly_ffi).

% Public API
-export([call/2, stop/1, replace/2]).

% Gen server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).

-record(state, { function, delay_ms, index }).

call(DelayMs, Function) ->
    State = #state{function = Function, delay_ms = DelayMs, index = 0},
    {ok, Pid} = gen_server:start_link(?MODULE, State, []),
    Pid.

replace(Pid, Function) ->
    erlang:send(Pid, {replace, Function}).

stop(Pid) ->
    erlang:send(Pid, stop).

init(State) ->
    schedule_next(State),
    {ok, State}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(tick, State = #state{function = F, index = I}) ->
    F(I),
    schedule_next(State),
    {noreply, State#state{index = I + 1}};

handle_info({replace, F}, State) ->
    {noreply, State#state{function = F}};

handle_info(stop, _) ->
    {stop, normal, ok};

handle_info(_Info, State) ->
    {noreply, State}.

schedule_next(#state{ delay_ms = DelayMs }) ->
    erlang:send_after(DelayMs, self(), tick).
