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

def exit_program?
  prompt(MESSAGES["again"])
  answer = gets.chomp.downcase

  if answer.start_with?('y')
    false
  else
    true
  end
end

def get_loan
  loop do
    prompt(MESSAGES["get_loan"])
    answer = gets.chomp

    if valid_number?(answer)
      return answer.to_f
    else
      prompt(MESSAGES["invalid_loan"])
    end
  end
end

def get_interest
  loop do
    prompt(MESSAGES["get_apr"])
    apr = gets.chomp

    if valid_number?(apr) && apr.to_f.between?(0, 100)
      return ((apr.to_f / 100) / 12)
    else
      prompt(MESSAGES["invalid_apr"])
    end
  end
end

def get_duration_years
  loop do
    prompt(MESSAGES["get_duration"])
    duration_in_years = gets.chomp

    if valid_number?(duration_in_years)
      return years_to_months(duration_in_years)
    else
      prompt(MESSAGES["invalid_duration"])
    end
  end
end

# Begin program
prompt(MESSAGES["welcome"])

loop do
  loan_amount = get_loan
  monthly_interest = get_interest
  duration_in_months = get_duration_years

  display_monthly_payment = format('%.2f', monthly_payment(loan_amount,
                                                           monthly_interest,
                                                           duration_in_months))
  display_monthly_interest = format('%.2f', (monthly_interest * 100))
  display_months = duration_in_months.to_i

  prompt("\tYour monthly payment is $#{display_monthly_payment}")
  prompt("\tYour monthly interest rate is #{display_monthly_interest}%")
  prompt("\tThe duration of your loan is #{display_months} months.\n\n")

  break if exit_program?
  system("clear")
end

prompt(MESSAGES["goodbye"])
