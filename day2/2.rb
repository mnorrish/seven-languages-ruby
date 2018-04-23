# Write a Tree class with a clean user interface which lets the initializer
# accept a nested structure with hashes and arrays.
# You should be able initialize with a nested hash like below.

nested = {
  "grandpa" => {
    "dad" => {
      "child 1" => {},
      "child 2" => {},
    },
    "uncle" => {
      "child 3" => {},
      "child 4" => {},
    },
  },
}

class Tree
  attr_accessor :children, :node_name

  def initialize(name, children = {})
    @node_name = name
    @children = children.map do |name, sub_children|
      Tree.new(name, sub_children)
    end
  end

  def visit_all(depth = 0, &block)
    visit(depth, &block)
    children.each { |child| child.visit_all(depth + 1, &block) }
  end

  def visit(depth = 0, &block)
    block.call(depth, self)
  end
end

family = Tree.new('great grandpa', nested)

# As an extra I've also allowed a depth argument to be used which lets us know
# how deeply nested a node of the tree is.
# The depth is passed to the block and is used below to indent the children.

puts "Visit the entire tree"
family.visit_all { |depth, node| puts "#{" " * depth}#{node.node_name}" }
