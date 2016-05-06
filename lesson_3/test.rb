sentence = "Humpty Dumpty sat on a wall."


words = sentence.split(/\W/)
words.reverse!
backwards_sentence = words.join(' ') + '.'

puts backwards_sentence