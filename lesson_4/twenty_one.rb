
DECK = [['Hearts', 'Diamonds', 'Spades', 'Clubs'],
        ['2', '3', '4', '5', '6',
         '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']].freeze

MAX_ALLOWED_POINTS = 21
DEALER_MIN = 17
WINNING_SCORE = 5

INSTRUCTIONS = <<-MSG.freeze

Both the player and the dealer will begin with two cards.
The player will see both of their cards and will see one of the dealer's.
The player will be able to request cards until either they call 'stay' or they
'bust' by going above #{MAX_ALLOWED_POINTS} points.
If the player calls 'stay', the dealer will have an opportunity to try to beat
the player's ending total.
The dealer must have at least #{DEALER_MIN} points before they can call 'stay'.
You must win #{WINNING_SCORE} times to win this match.

MSG

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
    prompt "Please respond with either H (hit) or S (stay). If you need to see"\
    " the instructions again, please type I."

    puts INSTRUCTIONS if ans.downcase.start_with?('i')
    prompt "Would you like to hit (H) or stay (S)?"
  end
end

def validate_stay_request
  prompt "The dealer must have at least #{DEALER_MIN} points to stay."

  loop do
    prompt "Please press H when you are ready to hit."
    hit_ans = gets.chomp
    break if hit_ans.downcase.start_with?('h')
  end
end

def deal_card(dealt_cards)
  card = []

  loop do
    card = [rand(4), rand(13)]
    break unless dealt_cards.include?(card)
    card = []
  end

  dealt_cards.push(card)
  card
end

def joinor(array, seperator=', ', conjunction='and the')
  all_but_last = ""
  array[0..(array.length - 2)].each { |item| all_but_last << item + seperator }
  all_but_last + conjunction + " " + array.last
end

def hand_described_as_string(hand)
  cards = []
  hand.each do |card|
    suit = DECK[0][card.first]
    value = DECK[1][card.last]
    cards.push("#{value} of #{suit}")
  end
  cards
end

def display_cards(current_player_hand, other_hand, whose_turn)
  current_player_cards = hand_described_as_string(current_player_hand)
  other_cards = hand_described_as_string(other_hand)

  if current_player_cards.length == 2
    puts "You, the #{whose_turn}, are dealt the " + current_player_cards.first\
         + " and the " + current_player_cards.last + "."
  else
    puts "You, the #{whose_turn}, now have the " + joinor(current_player_cards)
  end

  if whose_turn == 'player'
    puts "The dealer has the " + other_cards.first + " and ?."
  else
    puts "The player stayed with the following cards: " + joinor(other_cards)
  end
end

def total_cards(hand)
  values = hand.map { |_suit, value| DECK[1][value] }
  sum = 0

  values.each do |value|
    sum += if value == "Ace"
             11
           elsif value.to_i == 0
             10
           else
             value.to_i
           end
  end

  values.select { |value| value == "Ace" }.count.times do
    sum -= 10 if sum > MAX_ALLOWED_POINTS
  end
  sum
end

def bust?(hand)
  total = total_cards(hand)
  total > MAX_ALLOWED_POINTS
end

def detect_result(player_hand, dealer_hand)
  player_total = total_cards(player_hand)
  dealer_total = total_cards(dealer_hand)

  case
  when player_total > 21
    :player_busted
  when dealer_total > 21
    :dealer_busted
  when dealer_total < player_total
    :player
  when dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_winner(player_hand, dealer_hand)
  result = detect_result(player_hand, dealer_hand)
  player_total = total_cards(player_hand)
  dealer_total = total_cards(dealer_hand)

  case result
  when :player_busted
    prompt "The player busted with #{player_total} points! Dealer wins."
  when :dealer_busted
    prompt "The dealer busted with #{dealer_total}! Player wins."
  when :player
    prompt "The player won this round with #{player_total} points."
  when :dealer
    prompt "The dealer won this round with #{dealer_total} points."
  when :tie
    prompt "It's a tie!"
  end
end

def update_scores(player_hand, dealer_hand, score)
  result = detect_result(player_hand, dealer_hand)

  case result
  when :player_busted, :dealer
    score[:dealer] += 1
  when :dealer_busted, :player
    score[:player] += 1
  end
end

system('clear') || system('cls')
prompt "Welcome to Twenty-One."

puts INSTRUCTIONS

loop do
  score = { player: 0, dealer: 0 }

  loop do
    prompt "Please press S when you are ready to start the round."
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
      display_cards(player_hand, dealer_hand, 'player')
      prompt "Would you like to hit or stay? (Please type H or S)"
      ans = validate_h_or_s
      break if ans.start_with?('s')
      player_hand.push(deal_card(dealt_cards))

      if bust?(player_hand)
        system('clear') || system('cls')
        display_cards(player_hand, dealer_hand, 'player')
        break
      end
    end

    unless bust?(player_hand)
      system('clear') || system('cls')
      prompt "The player has chosen to stay. Now it's the dealer's turn."
      puts "        ----------------------------------"

      loop do
        break if bust?(dealer_hand)
        display_cards(dealer_hand, player_hand, 'dealer')
        prompt "Would you like to hit or stay? (Please enter H or S)"
        next_move_ans = validate_h_or_s

        if next_move_ans.downcase.start_with?('s')
          total_cards(dealer_hand) >= DEALER_MIN ? break : validate_stay_request
        end

        dealer_hand.push(deal_card(dealt_cards))
      end

      if bust?(dealer_hand)
        display_cards(dealer_hand, player_hand, 'dealer')
      end
    end

    puts "        ----------------------------------"
    display_winner(player_hand, dealer_hand)

    update_scores(player_hand, dealer_hand, score)
    if score[:player] == WINNING_SCORE
      prompt "The player has won #{WINNING_SCORE} rounds and wins the match."
      break
    elsif score[:dealer] == WINNING_SCORE
      prompt "The dealer has won #{WINNING_SCORE} rounds and wins the match."
      break
    end

    prompt "The player has won #{score[:player]} rounds and the dealer has won"\
           " #{score[:dealer]} rounds."

    loop do
      prompt "Please press S when you are ready to start the next round."
      start_answer = gets.chomp
      break if start_answer.downcase.start_with?('s')
    end
  end

  prompt "Would you like to play again? (Please enter Y or N)"
  play_again_ans = validate_answer
  break if play_again_ans.downcase.start_with?("n")
end

prompt "Thank you for playing Twenty-One!"
