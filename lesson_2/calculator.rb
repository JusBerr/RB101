require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  num.to_f.to_s == num || num.to_i.to_s == num
end

def operation_to_message(op)
  case op
    when "1"
      "Adding"
    when "2"
      "Subtracting"
    when "3"
      "multiplying"
    when "4"
      "dividing"
  end
end

prompt(MESSAGES["welcome"]) 

name = nil
loop do
  name = gets.chomp
  
  if name.empty?
    prompt(MESSAGES["valid_name"])
  else
    break
  end
end

prompt("Hi, #{name}!")

loop do # main loop
  number1 = nil
  loop do 
    prompt(MESSAGES["num1"]) 
    number1 = gets.chomp
    
    if valid_number?(number1)
      break
    else
      prompt(MESSAGES["num_not_valid"])
    end
  end
  
  number2 = nil
  loop do
    prompt(MESSAGES["num2"]) 
    number2 = gets.chomp
    
    if valid_number?(number2)
      break
    else
      prompt(MESSAGES["num_not_valid"])
    end
  end
  
  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
  
  prompt(operator_prompt) 
  
  operator = nil
  loop do
    operator = gets.chomp
    
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3, or 4.")
    end
  end
  
  prompt("#{operation_to_message(operator)} the two numbers...")
  
  result = case operator
           when '1'
              number1.to_f + number2.to_f
           when '2'
              number1.to_f - number2.to_f
           when '3'
              number1.to_f * number2.to_f
           when '4'
              number1.to_f / number2.to_f
  end
  
  prompt("The result is #{result}")
  
  prompt(MESSAGES["try_again"])
  answer = gets.chomp.downcase
  break unless answer.start_with?("y") 
  
end

prompt(MESSAGES["thanks"])