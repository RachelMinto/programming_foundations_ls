
puts "Q. 1: I expect the code will print out 1, 2, 2, 3"

puts "Q. 2: In Ruby, '!' means either 'not' or that you should pay particular attention."
puts "'!=' means 'not equal to', and is used in conditional statements."
puts "When ! is used before something like !user_name, it means not that user."
puts  "When after a method like .uniq, it means that you should pay particular attention, oftentimes because it's a destructive operation."
puts "When ? comes before something, it's being used as a conditional to ask if the following is true."
puts "When ? comes after something, it's oftentimes used to denote that there is logic surrounding the answer to the thing it followed. I.e, there is a true or false response."
puts "When !! comes before user_name, it means the same as user_name."
puts "I was wrong about ? because it's the ternary operator for if ... else, and !! turns something into their boolean equivalent."
=begin

    != means "not equals"
    ? : is the ternary operator for if...else
    !!<some object> is used to turn any object into their boolean equivalent. (Try it in irb)
    !<some object> is used to turn any object into the opposite of their boolean equivalent, just like the above, but opposite.

=end

puts "Q. 3: advice = 'Few things in life are as important as house training your pet dinosaur.'"
puts "advice.sub('important', 'urgent')"

puts "Q. 4. The first deletes at the specified index, in this case held by '2', while the second deletes that number if found, currently at index 0."

puts "Q. 5. (10..100).include?(42)" #or (10..100).cover?(42)

puts "Q. 6. famous_words = 'Four score and ' << famous words; OR famous_words = 'Four score and' + famous_words."

puts "Q. 7. Because methods have their own scope that is outside of the regular execution flow, and because add_eight doesn't return anything or mutate the caller, how_deep will remain 2."
puts "I was wrong. I believe it's because when you do a recursive call, you keep the returned value and then use that for each consecutive call."

puts "Q. 8. flintstones.flatten!"

puts "Q.9. array = ['Barney', flintstones['Barney']]."  #flintstones.assoc("Barney")

puts "Q. 10. hash = {}
flintstones.each_with_index do |name, index|
    hash[name]= index
    end"