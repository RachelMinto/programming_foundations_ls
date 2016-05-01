require 'yaml'

MESSAGES = YAML.load_file('mortgage_messages.yml')
def prompt(messages)
  puts "=> #{messages}"
end

def clear_screen
  system('clear') || system('cls')
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
    break unless total_loan.to_i.to_s != total_loan
    puts MESSAGES['invalid_loan']
  end

  clear_screen

  loop do
    prompt(MESSAGES['years_duration'])
    years = gets.chomp
    break unless years.to_f.to_s != years && years.to_i.to_s != years
    puts MESSAGES['invalid_years']
  end

  clear_screen

  loop do
    prompt(MESSAGES['interest_rate'])
    yearly_interest_rate = gets.chomp
    break unless yearly_interest_rate.to_f.to_s != yearly_interest_rate && yearly_interest_rate.to_i.to_s != yearly_interest_rate
    puts MESSAGES['invalid_ir']
  end

  clear_screen
  prompt("Your loan is for $#{total_loan} over the course of #{years} years with a yearly interest rate of #{yearly_interest_rate}%. Is this correct? (Y/N).")
  validation = gets.chomp
  break unless validation.downcase.start_with?("n")
  puts 'Let\'s try again.'
end

mo_interest_rate = yearly_interest_rate.to_f / 100 / 12 # convert yearly interest rate to a percentage and then to a monthly rate.
months = years.to_f * 12
monthly_payments = total_loan.to_f * (mo_interest_rate * (1 + mo_interest_rate)**months) / ((1 + mo_interest_rate)**months - 1)

puts "Your monthly payment is $#{monthly_payments.round(2)}."
