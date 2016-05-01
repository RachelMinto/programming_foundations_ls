mir = 6.0 / 100.0 / 12.0
puts mir
total_loan = 1000.0
months = 12.0
puts 1000* (mir * (1 + mir) * months) / ((1 + mir) * (months - 1))
monthly_payments = total_loan * (mir * (1 + mir) * months) / ((1 + mir) * (months - 1))

puts monthly_payments