require 'yaml'
MESSAGES = YAML.load_file('loan_calc_messages.yml')

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

loan_amount = get_loan

p loan_amount