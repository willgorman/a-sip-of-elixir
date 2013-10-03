:net_kernel.start([:fn_definer])
Node.connect(:"fn_runner@MAC-WG9059.local")
:timer.sleep(500)

defmodule PrintNode do
  def node do
    IO.inspect Node.self
  end
end

Node.spawn(Node.self, PrintNode, :node, [])

Node.spawn(:"fn_runner@MAC-WG9059.local", PrintNode, :node, [])