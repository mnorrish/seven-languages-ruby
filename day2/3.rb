# Write a simple grep that will read a file and print lines and their numbers
# only for lines which contain a given phrase

puts "Enter a phrase to search:"
phrase = gets.chomp
puts ""

file_path = File.join(File.dirname(__FILE__), "./text.txt")

File.open(file_path, "r") do |file|
  file.each_line.with_index do |line, index|
    puts "[#{index + 1}] #{line}" if line.include? phrase
  end
end
