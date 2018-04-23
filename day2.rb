numbers = (1..16).to_a

# print the contents of an array of sixteen numbers, four numbers at a time just using each
stack = []
numbers.each do |n|
  stack.push n

  if stack.length == 4
    p stack
    stack = []
  end
end

# print the contents of an array of sixteen numbers, four numbers at a time just using each
numbers.each_slice(4) do |a|
  p a
end
