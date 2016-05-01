#Mortage Calculator
#3 inputs: loan amount, APR**Actually meant annual interest rate, loan duration
#2 outputs: monthly interest rate, loan duration in months
#FThe following formula is used to calculate the fixed monthly payment (P) required to fully amortize a loan of L dollars over a term of n months 
#at a monthly interest rate of c. [If the quoted rate is 6%, for example, c is .06/12 or .005]. 
#P = L[c(1 + c)n]/[(1 + c)n - 1], 
#where L is loan of dollars, n is months, c is monthly interest rate (* remember to divide my 12)
=begin
    Figure out what format your inputs need to be in. For example, should the interest rate be expressed as 5 or .05, if you mean 5% interest?
    If you're working with Annual Percentage Rate (APR), you'll need to convert that to a monthly interest rate.
    Be careful about the loan duration -- are you working with months or years? Choose variable names carefully to assist in remembering.
=end
=begin
GET Loan Amount, interest rate, Loan duration
Check validity of inputs
SET loan duration to months
SET interest rate to months
SET Loan Duration to months
Calculate monthly payments with P = L[c(1 + c)n]/[(1 + c)n - 1]
Puts monthly interest rate over how many months.
=end
require 'yaml'

MESSAGES = YAML.load_file('mortgage_messages.yml')

def prompt(messages)
  puts "=> #{messages}"
end

prompt(MESSAGES['welcome'])

total_loan = ''

loop do 
  prompt(MESSAGES['loan'])
  total_loan = gets.chomp
  total_loan.delete!(",$")
  if total_loan.to_i.to_s == total_loan
    break
  else
    puts MESSAGES['invalid_loan']
  end
end

loop do
  prompt(MESSAGES['years_duration'])
  years = gets.chomp
  if years.to_i.to_s == years
    break
  else
    puts MESSAGES['invalid_years']
  end
end

loop do
  prompt(MESSAGES['interest_rate'])
  yir = gets.chomp
  if yir.to_i.to_s == yir
    break
  else
    puts MESSAGES['invalid_ir']
  end
end

prompt(MESSAGES['check_input']) 
validation = gets.chomp

if validation.downcase.start_with?("n")
  puts 'Let\'s try again.'

#monthly_payments = total_loan[mir(1 + mir)years*12] / [(1 + mir)years*12 - 1]

end


