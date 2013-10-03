:net_kernel.start([:fn_definer])

Node.connect(:'fn_runner@MAC-WG9059.local')
:timer.sleep(500)

defmodule NodeInspector do
  def node_name do
    IO.inspect(Node.self)
  end
end


spawn(NodeInspector, :node_name, [])

Node.spawn(:'fn_runner@MAC-WG9059.local',
  NodeInspector, :node_name, [])