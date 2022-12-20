require 'yaml'
MESSAGES = YAML.load_file('loan_calc_messages.yml')

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
  puts "\n=> #{message}"
end

# Begin program
prompt(MESSAGES["welcome"])

loop do
  loan_amount = nil
  loop do
    prompt(MESSAGES["get_loan"])
    loan_amount = gets.chomp

    if valid_number?(loan_amount)
      loan_amount = loan_amount.to_f
      break
    else
      prompt(MESSAGES["invalid_loan"])
    end
  end

  apr = nil
  monthly_interest = nil
  loop do
    prompt(MESSAGES["get_apr"])
    apr = gets.chomp

    if valid_number?(apr) && apr.to_f.between?(0, 100)
      monthly_interest = ((apr.to_f / 100) / 12)
      break
    else
      prompt(MESSAGES["invalid_apr"])
    end
  end

  duration_in_years = nil
  duration_in_months = nil
  loop do
    prompt(MESSAGES["get_duration"])
    duration_in_years = gets.chomp

    if valid_number?(duration_in_years)
      duration_in_months = years_to_months(duration_in_years)
      break
    else
      prompt(MESSAGES["invalid_duration"])
    end
  end

  display_monthly_payment = monthly_payment(loan_amount, monthly_interest, duration_in_months).round(2)
  display_monthly_interest = (monthly_interest * 100).round(2)
  display_months = duration_in_months.to_i

  prompt("\tYour monthly payment is $#{display_monthly_payment}")
  prompt("\tYour monthly interest rate is #{display_monthly_interest}%")
  prompt("\tThe duration of your loan is #{display_months} months.\n\n")

  prompt(MESSAGES["again"])
  again = gets.chomp.downcase

  break prompt(MESSAGES["goodbye"]) if again != "y"
end
