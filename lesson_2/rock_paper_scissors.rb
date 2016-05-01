VALID_CHOICES = %w(rock paper scissors lizard spock)

def prompt(message)
  puts("=> #{message}")
end

def modify_choice(str)
  if str == 'r' || str == 'sp'
    str << 'ock'
  elsif str == 'p'
    str << 'aper'
  elsif str == 'sc'
    str << 'issors'
  elsif str == 'l'
    str << 'izard'
  end
end

def win?(first, second)
  (first == 'rock' && (second == 'scissors' || second == 'lizard')) ||
    (first == 'paper' && (second == 'rock' || second == 'spock')) ||
    (first == 'scissors' && (second == 'paper' || second == 'lizard')) ||
    (first == 'lizard' && (second == 'spock' || second == 'paper')) ||
    (first == 'spock' && (second == 'rock' || second == 'scissors'))
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("You lost.")
  else
    prompt("It is a tie!")
  end
end

def update_score(player, computer, player_points, computer_points)
  if win?(player, computer)
    player_points << player_points.last.succ
  elsif win?(computer, player)
    computer_points << computer_points.last.succ
  end
end

prompt("Welcome to RPSLS! We'll play one match of five games.")
loop do
  choice = ''
  comp_points = [0]
  person_points = [0]

  loop do
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')} or type 'r' 'p' 'sc' 'l' or 'sp'")
      choice = gets.chomp

      modify_choice(choice)

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample
    puts "You chose: #{choice}; Computer chose: #{computer_choice}."

    display_results(choice, computer_choice)

    update_score(choice, computer_choice, person_points, comp_points)
    prompt("You have #{person_points.last} points and the computer has #{comp_points.last}")

    if person_points.last == 5
      prompt("You have won the match!")
      break
    elsif comp_points.last == 5
      prompt("The computer has won the match.")
      break
    end
  end

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")
