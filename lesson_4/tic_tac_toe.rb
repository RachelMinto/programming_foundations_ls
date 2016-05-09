
require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]].freeze
WINNING_SCORE = 5

# With STARTER set to 'choose', user gets to decide who will take the first turn.
# Can also set STARTER = 'Player' or 'Computer' to make it a default selection.
STARTER = 'choose'.freeze

def prompt(string)
  puts "=>" + string
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, player_score, computer_score)
  system('clear') || system('cls')
  puts "You're an #{PLAYER_MARKER}. The Computer is a #{COMPUTER_MARKER}."
  puts "You have won #{player_score.last} games and\
  the Computer has won #{computer_score.last}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def immediate_threat?(brd, marker)
  WINNING_LINES.each do |line| 
    !!find_at_risk_square(line, brd, marker) 
  end
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

def find_odd_open_squares(brd)
  choices = []
  brd.each_with_index do |index, value| 
    choices.push(index[0]) if index[1] == INITIAL_MARKER && index[0].odd?
  end
  choices.sample
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square: #{joinor(empty_squares(brd))}."
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = if immediate_threat?(brd, COMPUTER_MARKER)
             WINNING_LINES.each { |line| find_at_risk_square(line, brd, COMPUTER_MARKER) }
           elsif immediate_threat?(brd, PLAYER_MARKER)
             WINNING_LINES.each { |line| find_at_risk_square(line, brd, PLAYER_MARKER) }
           elsif brd[5] == INITIAL_MARKER
             5
           elsif !!find_odd_open_squares(brd)
             find_odd_open_squares(brd)  
           else
             empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
end

def validate_answer(ans)
  loop do
    break if ans.downcase.start_with?('y', 'n')
    prompt "Please respond with either Y or N."
    ans = gets.chomp
  end
  ans
end

def get_starter(starter)
  if starter == 'choose'
    prompt "Would you like to start? (Y or N)."
    ans = gets.chomp
    final_ans = validate_answer(ans)
    return 'Player' if final_ans.downcase.start_with?('y')
    'Computer'
  else
    starter
  end
end

def alternate_player(current_player)
  current_player == 'Player' ? 'Computer' : 'Player'
end

def place_piece!(board, current_player)
  if current_player == 'Player'
    player_places_piece!(board)
  else
    computer_places_piece!(board)
  end
end

def take_turns(current_player, board, player_score, computer_score)
  loop do
    display_board(board, player_score, computer_score)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def update_score(brd, player_score, computer_score)
  if detect_winner(brd) == 'Player'
    player_score << player_score.last.succ
  elsif detect_winner(brd) == 'Computer'
    computer_score << computer_score.last.succ
  end
end

def joinor(array, seperator=', ', conjunction='and')
  return array if array.length == 1
  all_but_last = ""
  array[0..(array.length - 2)].each { |num| all_but_last << num.to_s + seperator }
  all_but_last + conjunction + " " + array.last.to_s
end

loop do
  player_score = [0]
  computer_score = [0]
  loop do
    board = initialize_board
    prompt "Welcome to Tic Tac Toe. Each match will be best out of #{WINNING_SCORE}."
    who_starts = get_starter(STARTER)

    take_turns(who_starts, board, player_score, computer_score)

    if someone_won?(board)
      update_score(board, player_score, computer_score)
      prompt "#{detect_winner(board)} won!"
      display_board(board, player_score, computer_score)
    else
      prompt "It's a tie!"
    end

    break if player_score.last == WINNING_SCORE || computer_score.last == WINNING_SCORE
    display_board(board, player_score, computer_score)
  end

  if player_score.last == WINNING_SCORE
    prompt "Congratulations! You have won #{WINNING_SCORE} matches against the computer."
    prompt "Would you like to play another match? (y or n)"
    ans = gets.chomp
    final_ans = validate_answer(ans)
    break if final_ans.downcase.start_with?('n')
  elsif computer_score.last == WINNING_SCORE
    prompt "Too bad. The computer has won this match.\
    Would you like to play again? (y or n)."
    ans = gets.chomp
    final_ans = validate_answer(ans)
    break if final_ans.downcase.start_with?('n')
  end
end

prompt "Thanks for playing Tic Tac Toe. Good bye!"
