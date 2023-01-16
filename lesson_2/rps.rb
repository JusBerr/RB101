VALID_CHOICES = %w(rock paper scissors)

def win?(first, second)
  (first == "rock" && second == "scissors") ||
    (first == "scissors" && second == "paper") ||
    (first == "paper" && second == "rock")
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

def prompt(message)
  puts "=> #{message}"
end

loop do
  choice = ""
  computer_choice = VALID_CHOICES.sample
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That is not a valid choice.")
    end
  end

  prompt("You chose: #{choice}; Computer chose: #{computer_choice}.")
  display_results(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = gets.chomp.downcase
  break unless answer.start_with?("y")
end
