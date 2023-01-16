VALID_MOVES = { 'r' => :rock, 'rock' => :rock,
                'p' => :paper, 'paper' => :paper,
                'sc' => :scissors, 'scissors' => :scissors,
                'sp' => :spock, 'spock' => :spock,
                'l' => :lizard, 'lizard' => :lizard }

COMPUTER_MOVES = %w(rock paper scissors spock lizard)

WIN_CONDITIONS = {
    rock:     ['lizard', 'scissors'],
    paper:    ['rock', 'spock'],
    scissors: ['paper', 'lizard'],
    spock:    ['rock', 'paper'],
    lizard:   ['paper', 'spock']
}

WINNING_SCORE = 3

def valid_choice?(choice)
  VALID_MOVES.has_value?(choice)
end

def round_winner(player_move, computer_move)
  if player_move == computer_move
    'tie'
  elsif WIN_CONDITIONS[player_move].include?(computer_move.to_s)
    'player_win'
  else
    'computer_win'
  end
end

def display_round_result(player_move, computer_move)
  case round_winner(player_move, computer_move)
  when 'tie'
    prompt("It's a tie!")
  when 'player_win'
    prompt("You won this round!")
  else
    prompt("Computer won this round!")
  end
end

def display_current_score(player, computer)
  prompt("You: #{player} Computer: #{computer}")
end

def prompt(message)
  puts "=> #{message}"
end

def play_again?
  prompt("Do you want to play another match?")
  answer = gets.chomp.downcase
  answer.start_with?('y')
end

loop do
  player_score = 0
  computer_score = 0

  until player_score == WINNING_SCORE || computer_score == WINNING_SCORE
    player_move = ""
    computer_move = COMPUTER_MOVES.sample.to_sym
    loop do
      prompt("Choose one:")
      player_move = gets.chomp.downcase
      player_move = VALID_MOVES[player_move]

      if valid_choice?(player_move)
        break
      else
        prompt("That is not a valid choice.")
      end
    end

    prompt("You chose: #{player_move.to_s}; Computer chose: #{computer_move.to_s}.")

    display_round_result(player_move, computer_move)

    case round_winner(player_move, computer_move)
    when 'player_win'
      player_score += 1
    when 'computer_win'
      computer_score += 1
    end

    display_current_score(player_score, computer_score)
  end
  break unless play_again?
end