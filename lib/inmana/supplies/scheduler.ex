defmodule Inmana.Supplies.Scheduler do
  use GenServer

  alias Inmana.Supplies.ExpirationNotification

  # CLIENT logics

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  # SERVER logics -----

  # @impl true is an annotation for behavior implementation
  @impl true
  def init(state \\ %{}) do
    schedule_notification()
    {:ok, state}
  end

  # async
  # def handle_cast({:put, key, value}, state) do
  #   # as it is async, it wont reply instantly, so it returns the :noreply
  #   # Map.put creates a new entry in the map assigned as the 1st argument (state)
  #   {:noreply, Map.put(state, key, value)}
  # end

  # def handle_call({:get, key}, _from, state) do
  #   # as it is sync, it must reply instantly, so it returns the :reply
  #   # Map.get returns the value of a given key in a map
  #   # the 3rd arg parameter below is the new state, in this case, unchanged
  #   {:reply, Map.get(state, key), state}
  # end

  # handle_info handles any kind of message
  @impl true
  def handle_info(:generate, state) do
    ExpirationNotification.send()
    schedule_notification()
    {:noreply, state}
  end

  # send_after/4 creates a process that sends message to the GenServer's pid,
  # identified by self() of kind :generate after 10s. Kinda a cronjob
  defp schedule_notification do
    Process.send_after(self(), :generate, 1000 * 10)
  end
end
