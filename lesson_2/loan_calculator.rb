
def integer?(input)
  /^-?\d+$/.match(input)
end

def float?(input)
  /\d/.match(input) && /^-?\d*\.?\d*$/.match(input)
end

def valid_number?(num)
  integer?(num) || float?(num)
end

def years_to_months(years)
  years.to_f * 12
end

def monthly_payment(loan_amount, apr, duration_in_months)
  loan_amount * (apr / (1 - (1 + apr)**(-duration_in_months)))
end

puts "Let's check out your loan!"

loan_amount = nil
loop do
  puts "What is the total loan amount?"
  loan_amount = gets.chomp
  
  if valid_number?(loan_amount)
    loan_amount = loan_amount.to_f
    break
  else 
    puts "Must enter a valid load amount."
  end
end

apr = nil
monthly_interest = nil
loop do
  puts "What is the Annual Percentage Rate (APR)?"
  apr = gets.chomp
  
  if valid_number?(apr)
    monthly_interest = ((apr.to_f / 100) / 12)
    break
  else
    puts "Must enter valid APR."
  end
end

duration_in_years = nil
duration_in_months = nil
loop do
  puts "What is the duration of the loan? (in years)"
  duration_in_years = gets.chomp
  
  if valid_number?(duration_in_years)
    duration_in_months = years_to_months(duration_in_years)
    break
  else
    puts "Must enter valid duration in years"
  end
end

puts "Your monthly payment is $#{monthly_payment(loan_amount, monthly_interest, duration_in_months).round(2)}"
puts "Your monthly interest rate is #{(monthly_interest * 100).round(2)}%"
puts "The duration of your loan is #{duration_in_months.to_i} months."