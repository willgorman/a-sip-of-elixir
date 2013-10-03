


# default values
defrecord Human, name: "Finn", home: "Ooo"

human = Human.new

Human.new(name: "Fionna")


#Access
human.name # => "Finn"

Human[name: n, home: h] = human
n # => "Finn"
h # => "Ooo"