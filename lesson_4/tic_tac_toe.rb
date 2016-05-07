
require 'pry'

INITIAL_MARKER = ' '.freeze
PLAYER_MARKER = 'X'.freeze
COMPUTER_MARKER = 'O'.freeze
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def immediate_threat?(brd, slot=false)
  compare_to_test = ['X', 'X', ' ']
  test = []
  WINNING_LINES.each do |trio|
    trio.each { |place_holder| test.unshift(brd[place_holder]) }
    if
      test.sort == compare_to_test.sort
      slot = trio.find_index(' ')
      binding.pry
      break
    end
  end
  slot
end
  #if 2 of 3 winning lines arrays are x and the third is empty, return third slot.


def prompt(string)
  puts "=>" + string
end

# rubocop.disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, player_score, computer_score)
  system('clear') || system('cls')
  puts "You're an #{PLAYER_MARKER}. The Computer is a #{COMPUTER_MARKER}."
  puts "You have won #{player_score.last} games and the Computer has won #{computer_score.last}"
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
# rubocop.enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
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
  if !!immediate_threat?(brd)
    puts "true"
    square = immediate_threat?(brd)
  else
    square = empty_squares(brd).sample
  end
  brd[square] = COMPUTER_MARKER
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
  array[0..(array.length-2)].each { |num| all_but_last << num.to_s + seperator }
  all_but_last + conjunction + " " + array.last.to_s
end

loop do
  player_score = [0]
  computer_score = [0]
  loop do
    board = initialize_board

    loop do
      display_board(board, player_score, computer_score)

      player_places_piece!(board)
      break if someone_won?(board) || board_full?(board)

      computer_places_piece!(board)
      break if someone_won?(board) || board_full?(board)
    end

    if someone_won?(board)
      update_score(board, player_score, computer_score)
      prompt "#{detect_winner(board)} won!"
    else
      prompt "It's a tie!"
    end

    break if player_score.last == 5 || computer_score.last == 5
    display_board(board, player_score, computer_score)
  end
  
  if player_score.last == 5
    prompt "Congratulations! You have won 5 matches against the computer. Would you like to play another match? (y or n)"
    break unless gets.chomp.downcase.start_with?('y')
  elsif computer_score.last == 5
    prompt "Too bad! The computer has won this match. Would you like to play again? (y or n)."
    break unless gets.chomp.downcase.start_with?('y')
  end
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
