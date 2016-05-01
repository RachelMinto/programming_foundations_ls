require 'yaml'

MESSAGES = YAML.load_file('mortgage_messages.yml')
def prompt(messages)
  puts "=> #{messages}"
end

prompt(MESSAGES['welcome'])

total_loan = ''
years = ''
yir = ''

loop do
  loop do
    prompt(MESSAGES['loan'])
    total_loan = gets.chomp
    total_loan.delete!(",$")
    break unless total_loan.to_i.to_s != total_loan
    puts MESSAGES['invalid_loan']
  end

  loop do
    prompt(MESSAGES['years_duration'])
    years = gets.chomp
    break unless years.to_f.to_s != years && years.to_i.to_s != years
    puts MESSAGES['invalid_years']
  end

  loop do
    prompt(MESSAGES['interest_rate'])
    yir = gets.chomp
    break unless yir.to_f.to_s != yir && yir.to_i.to_s != yir
    puts MESSAGES['invalid_ir']
  end

  prompt("Your loan is for $#{total_loan} over the course of #{years} years with a yearly interest rate of #{yir}%. Is this correct? (Y/N).")
  validation = gets.chomp
  break unless validation.downcase.start_with?("n")
  puts 'Let\'s try again.'
end
mir = yir.to_f / 100 / 12 # convert yearly interest rate to a percentage and then to a monthly rate.
months = years.to_f * 12
monthly_payments = total_loan.to_f * (mir * (1 + mir)**months) / ((1 + mir)**months - 1)

puts "Your monthly payment is $#{monthly_payments.round(2)}."
