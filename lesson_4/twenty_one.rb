require 'pry'

DECK = [['Hearts', 'Diamonds', 'Spades', 'Clubs'], ['2', '3', '4', '5', '6', \
'7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']].freeze

INSTRUCTIONS = <<-msg 
Both you and the Dealer will begin with two cards.
You will see both of your cards and will see one of the Dealer's.
You will be able to request cards until either you call 'stay' or you 'bust' by 
going above 21 points.
If you call 'stay', the Dealer will have an opportunity to try to beat you.
The Dealer must have at least 17 points before they can call 'stay'.
msg

def prompt(str)
  puts "=> #{str}"
end

def validate_answer
  loop do
    ans = gets.chomp
    return ans if ans.downcase.start_with?('y', 'n')
    prompt "Please respond with either Y or N."
  end
end

def validate_h_or_s
  loop do
    ans = gets.chomp
    return ans if ans.downcase.start_with?('h', 's')
    prompt <<-MSG 
    Please respond with either H (hit) or S (stay). If you need to see 
    the instructions again, please type I.
    MSG
    puts INSTRUCTIONS if ans.downcase.start_with?('i')
    prompt "Would you like to hit (H) or stay (S)?" 
  end
end

def deal_card(dealt_cards)
  card_coordinates = []
  card = ''
  loop do
    card = card_coordinates.push(rand(4), rand(13))
    break unless dealt_cards.include?(card)
  end
  dealt_cards.push(card)
  card
end

def joinor(array, seperator=', ', conjunction='and the')
  all_but_last = ""
  array[0..(array.length - 2)].each { |item| all_but_last << item + seperator }
  all_but_last + conjunction + " " + array.last
end

def card_desc(card)
  suit = DECK[0][card.first]
  value = DECK[1][card.last]
  "#{value} of #{suit}"
end

def display_cards(player_hand, other_hand, whose_turn)
  cards = []
  other_cards = []
  player_hand.each { |card| cards.push(card_desc(card)) }
  other_hand.each { |card| other_cards.push(card_desc(card)) }
  if cards.length == 2 
    puts "You, the #{whose_turn}, are dealt the following cards: " + cards.first + " and the " + cards.last 
  else
    puts "You, the #{whose_turn}, now have the " + joinor(cards) 
  end
  if whose_turn == 'Player'
    puts "The Dealer has two cards, one of which is the " + card_desc(other_hand.first)
  else
    puts "The Player stayed with the following cards: " + joinor(other_cards)
  end
end

def total_cards(hand)
  values = hand.map { |suit, value| DECK[1][value] }
  sum = 0
  values.each do |value|
    sum += if value == "Ace"  
             11
           elsif value.to_i == 0
             10
           else
             value.to_i
           end
    sum
  end

  def take_turn(player)
  end
  
  values.select { |value| value == "Ace" }.count.times do 
    sum -= 10 if sum > 21
  end

  sum
end

def bust?(hand)
  !!(total_cards(hand) > 21)
end

prompt "Thank you for playing Twenty-One."

puts INSTRUCTIONS

loop do
  prompt "Please press S when you are ready to start."
  start_answer = gets.chomp
  break if start_answer.downcase.start_with?('s')
end

loop do
  dealt_cards = []
  player_hand = []
  dealer_hand = []

  player_hand.push(deal_card(dealt_cards), deal_card(dealt_cards))
  dealer_hand.push(deal_card(dealt_cards), deal_card(dealt_cards))

  loop do
    system('clear') || system('cls')
    display_cards(player_hand, dealer_hand, 'Player')
    total_cards(player_hand)
    prompt "Would you like to hit or stay? (Please type H or S)"  
    ans = validate_h_or_s
    break if ans.start_with?('s')
    player_hand.push(deal_card(dealt_cards))
    if bust?(player_hand)
      system('clear') || system('cls')
      display_cards(player_hand, dealer_hand, 'Player')
      break
    end
  end

  if bust?(player_hand)
    prompt "Too bad! You've busted."
  else
    prompt "You've chosen to stay. Now it's the Dealer's turn."
    loop do
      next_move_ans = ''
      break if bust?(dealer_hand)
      system('clear') || system('cls')
      display_cards(dealer_hand, player_hand, 'Dealer')
      total_cards(dealer_hand)
      prompt "Would you like to hit or stay? (Please type H or S)"  
      next_move_ans = validate_h_or_s
      break if next_move_ans.downcase.start_with?('s')
      dealer_hand.push(deal_card(dealt_cards))
    end
  end
  
  prompt "Would you like to play again? (Please enter Y or N)"
  play_again_ans = validate_answer
  break if play_again_ans.downcase.start_with?("n")

end

prompt "Thank you for playing Twenty-One!"