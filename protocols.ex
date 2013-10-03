defprotocol Reversible do
  def reverse(r)
end

defimpl Reversible, for: List do
  def reverse(r) do
    Enum.reverse(r)
  end
end

defimpl Reversible, for: Human do
  def reverse(r) do
    Human.new(name: String.reverse(r.name))
  end
end

Reversible.reverse [1,2,3] # => [3,2,1]
Reversible.reverse(Human.new)
# => Human[name: "nniF"]