# Method definitions
def integer?(input)
  /^-?\d+$/.match(input)
end

def float?(input)
  /\d/.match(input) && /^-?\d*\.?\d*$/.match(input)
end

def valid_number?(num)
  (integer?(num) || float?(num)) && num.to_f > 0
end

def years_to_months(years)
  years.to_f * 12
end

def monthly_payment(loan_amount, apr, duration_in_months)
  loan_amount * (apr / (1 - (1 + apr)**(-duration_in_months)))
end

def prompt(message)
  puts ">> #{message}"
end

# Begin program
prompt("Let's check out your loan!")

loop do # Main loop
  loan_amount = nil
  loop do
    prompt("What is the total loan amount?")
    loan_amount = gets.chomp

    if valid_number?(loan_amount)
      loan_amount = loan_amount.to_f
      break
    else
      prompt("Loan amount must be positive number.")
    end
  end

  apr = nil
  monthly_interest = nil
  loop do
    prompt("What is the Annual Percentage Rate (APR)?")
    apr = gets.chomp

    if valid_number?(apr)
      monthly_interest = ((apr.to_f / 100) / 12)
      break
    else
      prompt("Must enter valid APR.")
    end
  end

  duration_in_years = nil
  duration_in_months = nil
  loop do
    prompt("What is the duration of the loan (in years)?")
    duration_in_years = gets.chomp

    if valid_number?(duration_in_years)
      duration_in_months = years_to_months(duration_in_years)
      break
    else
      prompt("Must enter valid duration in years")
    end
  end

  prompt("Your monthly payment is $#{monthly_payment(loan_amount, monthly_interest, duration_in_months).round(2)}")
  prompt("Your monthly interest rate is #{(monthly_interest * 100).round(2)}%")
  prompt("The duration of your loan is #{duration_in_months.to_i} months.")

  prompt("Would you like to check another loan? (Y/N)")
  again = gets.chomp.downcase

  break prompt("Thanks for using our loan calculator!") if again != "y"
end
