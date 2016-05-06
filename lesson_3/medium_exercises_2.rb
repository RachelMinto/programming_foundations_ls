"Q. 1 
total_age = 0
munsters.each  do |name, values| 
  total_age += (values['age']) if values['gender'] == 'male' 
end "

"Q. 2 munsters.each do |member, values|
  name = member
  age = values['age']
  sex = values['gender']
  puts '#{member} is a #{values['age']} year old #{values['gender']}.'
end
"

"Q. 3 This method is simple enough that I would probably just remove it from the method and put it in a block so that it is able to access the outer scope."

"Q. 4 puts sentence.split(" ").reverse.join(" ")"

"Q. 5 34."

"Q. 6. Just a local copy, because .each is for iteration, not transformation. Note: I was wrong! .each will modify the hash, and the ID of the hash was passed as a parameter."

"Q. 7. paper."

"Q. 8 no."