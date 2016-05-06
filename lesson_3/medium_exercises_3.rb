
puts 'Q. 1 First they all print 42 but have different IDs. I do not think that the ID would change if a block is applied that just reassigns to a new variable, but I might be wrong.'
puts "Going inside the block won't affect the ID."
puts "Assigning new variables will change the ID."
puts "It will need to be rescued when it tries to use variables initiated inside the block but called after the block."

puts "Q. 2 You need to have all methods defined above method calls, but this may not be a problem since the first method call isn't until after the second method is defined."
puts "However, since the meethods in the second method do not mutate the caller, the first method will be unaffected by the changes made to the variables. Note: See answer for why this really fails."

puts "Q.3 My string remains unchanged but my array is modified because << mutates the caller while += just reassigns."

puts "Q.4 In the second case, the string is modified because gsub! is destructive, while the array is reassigned within the method and doesn't get modified."

puts "def color_valid(color)
  true if color == 'blue' || color == 'green'
  false
end"

