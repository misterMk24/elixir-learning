defmodule EchoServerTest do
  use ExUnit.Case, async: true

  describe "when using one Node" do
    test "success" do
      {:ok, pid} = EchoServer.start
      IO.puts inspect(node())

      assert EchoServer.ping(pid) == {:pong, node()}
    end
  end

  describe "when using two Nodes" do
    test "success" do
      {:ok, _, pid_peer} = :peer.start_link()

      # add lib path to the :peer node
      :erpc.call(pid_peer, :code, :add_paths, [:code.get_path()])

      # start EchoServer
      {:ok, pid_peer_gen_server} = :erpc.call(pid_peer, EchoServer, :start, [])

      # call ping on behalf :peer node
      result = :erpc.call(pid_peer, EchoServer, :ping, [pid_peer_gen_server])

      assert result == {:pong, pid_peer}
    end
  end
end
