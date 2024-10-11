defmodule EchoServer do
  use GenServer

  @spec start() :: :ignore | {:error, any()} | {:ok, pid()}
  def start() do
    GenServer.start(__MODULE__, :pong)
  end

  @spec ping(pid()) :: {:pong, node()}
  def ping(pid) do
    GenServer.call(pid, :ping)
  end

  @impl true
  def init(elements) do
    {:ok, elements}
  end

  @impl true
  def handle_call(:ping, _from, state) do
    new_state = :pong
    {:reply, {state, node()}, new_state}
  end
end
