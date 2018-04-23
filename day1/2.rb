# Let a user guess a random integer between 1 and 10

x = rand(10) + 1
guess = nil

puts "Guess a number between 1 and 10"

until guess == x do
  guess = gets.chomp.to_i
  puts "Incorrect. Try again." unless guess == x 
end

puts "You guessed #{x} correctly!"
