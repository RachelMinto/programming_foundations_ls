require 'yaml'

MESSAGES = YAML.load_file('mortgage_messages.yml')
def prompt(messages)
  puts "=> #{messages}"
end

def clear_screen
  system('clear') || system('cls')
end

def validate_loan(ans)
  if ans.to_i < 0 || ans == "0"
    puts "Please enter a loan amount greater than $0."
  elsif ans.to_i.to_s != ans
    puts MESSAGES['invalid_loan']
  end
end

def validate_duration(years)
  if years.to_i < 0 || years == '0'
    puts "Please enter a loan duration greater than 0 years."
  elsif years.to_i.to_s != years
    puts MESSAGES['invalid_years']
  end
end

prompt(MESSAGES['welcome'])

total_loan = ''
years = ''
yearly_interest_rate = ''

loop do
  loop do
    prompt(MESSAGES['loan'])
    total_loan = gets.chomp
    total_loan.delete!(",$")
    validate_loan(total_loan)
    break if total_loan.to_i.to_s == total_loan && total_loan.to_i > 0
  end

  clear_screen

  loop do
    prompt(MESSAGES['years_duration'])
    years = gets.chomp
    validate_duration(years)
    break if (years.to_f.to_s == years && years.to_i > 0) || (years.to_i.to_s == years && years != '0' && years.to_i > 0)
  end

  clear_screen

  loop do
    prompt(MESSAGES['interest_rate'])
    yearly_interest_rate = gets.chomp
    break if yearly_interest_rate.to_f.to_s == yearly_interest_rate || yearly_interest_rate.to_i.to_s == yearly_interest_rate
    puts MESSAGES['invalid_ir']
  end

  clear_screen
  puts format(MESSAGES['check_input'], total_loan, years, yearly_interest_rate)
  validation = gets.chomp
  break unless validation.downcase.start_with?("n")
  puts 'Let\'s try again.'
end

mo_interest_rate = yearly_interest_rate.to_f / 100 / 12 # convert yearly interest rate to a percentage and then to a monthly rate.
months = years.to_f * 12
monthly_payments = total_loan.to_f * (mo_interest_rate * (1 + mo_interest_rate)**months) / ((1 + mo_interest_rate)**months - 1)

puts "Your monthly payment is $#{monthly_payments.round(2)}."
