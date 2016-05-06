
puts "Q. 1 I expect it to say variable undefined. Note: when you initialize a local variable within an if block, even if that if block doesn’t get executed, the local variable is initialized to nil."

puts "Q. 2 'hi there'. I expect that modifying informal_greeting changed greeting because variables don't point to other variables, but they can point to the same object."

puts "Q. 3 One, two three because they were reassigned, not mutated in the method. B is the same. Two, three, one because gsub mutates the caller."

puts "Q. 4 require 'securerandom'
  def uuid_creator
  random_string = SecureRandom.hex
  random_string.slice(0..7) + "-" + random_string.slice(8..11) + "-" + random_string.slice(12..15) + "-" + random_string.slice(16..19) + "-" + random_string.slice(20, 31)
end"

puts "Q. 5 def dot_separated_ip_address?(input_string)
  return false if input_string.count('.') != 3
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false if !is_a_number?(word)
  end
  true
end
"