puts "Q. 1 ages.fetch('Spot'), or .assoc or .key. Note: I was assuming Spot could have had an empty hash, so checking for whether he was there and whether he had an age."

puts "Q. 2 count = 0 ages.each_value { |age| count += age } puts count."

puts "Q. 3 ages.select! { |name, value| value < 100 }"

puts "Q. 4 munsters_description.gsub('M', 'm'), munsters_description.swapcase, munsters_description.downcase, munsters_description.upcase "

puts "Q. 5 ages.merge!(additional_ages)"

puts "Q. 6 ages.values.min"

puts "Q. 7 advice.match("Dino")"

puts "Q. 8 flintstones.each_with_index { |name, index| puts index if name.start_with?("Be") }"

puts "Q. 9 flintstones.map! { |name| name[0, 3] }"

puts "Same as question 9."