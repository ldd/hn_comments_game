# https://stackoverflow.com/a/32097971/968420
defmodule HnCommentsGame.Scheduler do
  use GenServer
  @hour 60 * 60 * 1000

  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def init(_) do
    :timer.send_interval(@hour, :update)
    {:ok, 1}
  end

  def handle_info(:update, count) do
    HnCommentsGame.Scrapper.update()
    {:noreply, count + 1}
  end

  def handle_info({:ssl_closed, _msg}, state) do
    {:noreply, state}
  end
end
