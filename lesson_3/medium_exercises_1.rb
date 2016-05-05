
puts 'Q 1 10.times { |i| puts ""*i + "The Flintstones Rock!" } '

puts 'Q. 2 

statement = "The Flintstones Rock"

hash = {}

statement.each_char do |character|
  if hash.include?(character)
    hash[character] += 1
  else
    hash[character] = 1
  end
end

puts hash'

puts 'Q. 3 The error results from trying to combine integers with a string. Only two strings can be concatenated. Two possible ways of fixing it is to a) put your integers in a bracket and then call .to_s or b) put your integers in a variable and then interpolate using #{}'

puts 'Q. 4. You can unexpected results when you modify an array while iterating over it. For example, if you try to delete while iterating over an array, you may end up with some things left undeleted. 
The first code block prints 1, 3 and returns [3, 4]. The second code prints 1, 2 and returns [1, 2]'

puts 'Q. 5 Use "while dividend > 0" and remove "until dividend == 0" Bonus 1: It is used to check if it is divded with no remainder (modulo). Bonus 2: it is to get an implicit return of the divisors array.'

puts 'Q. 6. Yes, in the first you need to update the input_array after the method, whereas the first automatically has a new buffer because << mutates the caller.'

puts 'Q. 7 variables need to be passed into methods to be used, otherwise it is outside of the method\'s scope. To fix it, I would pass in limit as an argument.'

puts 'Q. 8 statement = "this is defnitely one of the longest titles i can currently think of that uses a bunch of smallish words but isn\'t ridiculous!"
statement_2 = statement.split

statement_2.map do |words|
  if !%w(a an the at by for in of on to up and as but or nor).include? words
    words.capitalize! 
  else
    words
  end
end

statement = statement_2.join(" ")
puts statement'

puts 'Q. 9 munsters.each do |member|
  case member[1]["age"]
  when 0..17 then member[1]["age_group"] = "kid"
  when 18..64 then member[1]["age_group"] = "adult"
  when 65..200 then member[1]["age_group"]= "senior"
  end
  munsters
end
puts munsters'
