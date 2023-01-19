require 'yaml'
MESSAGES = YAML.load_file('rpsls_messages.yml')

VALID_MOVES = { 'r' => :rock,      'rock' => :rock,
                'p' => :paper,     'paper' => :paper,
                'sc' => :scissors, 'scissors' => :scissors,
                'sp' => :spock,    'spock' => :spock,
                'l' => :lizard,    'lizard' => :lizard }

COMPUTER_MOVES = %w(rock paper scissors spock lizard)

WIN_CONDITIONS = {
  rock: ['lizard', 'scissors'],
  paper: ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  spock: ['rock', 'scissors'],
  lizard: ['paper', 'spock']
}

WINNING_SCORE = 3

def get_user_name
  loop do
    prompt(MESSAGES["get_name"])
    user_name = gets.chomp
    if user_name =~ /\w/
      return user_name
    else
      prompt(MESSAGES["invalid_name"])
    end
  end
end

def display_rules?
  prompt(MESSAGES["display_rules?"])
  answer = gets.chomp.downcase
  if answer.start_with?("y")
    prompt(MESSAGES["rules"])
    gets
  end
end

def valid_choice?(choice)
  if VALID_MOVES.value?(choice)
    true
  else
    prompt(MESSAGES["invalid_move"])
  end
end

def add_suspense
  sleep(0.5)
  prompt(MESSAGES["suspense"])
end

def round_winner(player_move, computer_move)
  if player_move == computer_move
    :tie
  elsif WIN_CONDITIONS[player_move].include?(computer_move.to_s)
    :player_win
  else
    :computer_win
  end
end

def display_round_result(player_move, computer_move)
  case round_winner(player_move, computer_move)
  when :tie
    prompt(MESSAGES["draw"])
  when :player_win
    prompt(MESSAGES["player_win"])
  else
    prompt(MESSAGES["computer_win"])
  end
end

def display_current_score(player, computer)
  prompt("SCORE:\t#{player} - #{@user_name} |VS| Computer - #{computer}\n\n")
end

def prompt(message)
  puts "=> #{message}"
end

def display_grand_winner(player_score, computer_score)
  if player_score == 3
    prompt("We have a winner...")
    sleep(1)
    prompt("\n\t***Congratulations, #{@user_name}"\
           "... you have defeated Computer!***\n\n")
  elsif computer_score == 3
    prompt("You chose poorly...")
    sleep(1)
    prompt("\n\t***COMPUTER REIGNS SUPREME***\n\n")
  end
end

def play_again?
  prompt(MESSAGES["play_again?"])
  answer = gets.chomp.downcase
  answer.start_with?('y')
end

# Thanks Brandi!

def get_player_move(computer_score)
  loop do
    prompt(MESSAGES["player_move"])
    add_suspense if computer_score == (WINNING_SCORE - 1)
    player_move = gets.chomp.downcase
    player_move = VALID_MOVES[player_move]
    return player_move if valid_choice?(player_move)
  end
end

def random_move
  COMPUTER_MOVES.sample.to_sym
end

def display_selected_moves(player_move, computer_move)
  prompt("\t#{@user_name}'s #{player_move} VS"\
         " Computer's #{computer_move}...")
end

def begin_match_message
  prompt("Alright, #{@user_name}... let the games begin!")
end

def update_player_score(player_move, computer_move, player_score)
  if round_winner(player_move, computer_move) == :player_win
    player_score + 1
  else
    player_score
  end
end

def update_computer_score(player_move, computer_move, computer_score)
  if round_winner(player_move, computer_move) == :computer_win
    computer_score + 1
  else
    computer_score
  end
end

def winning_score_reached?(player_score, computer_score)
  player_score == WINNING_SCORE || computer_score == WINNING_SCORE
end

# Begin program
prompt(MESSAGES["welcome"])
sleep(1)

@user_name = get_user_name

system("clear")

display_rules?

begin_match_message

sleep(1)
loop do
  player_score = 0
  computer_score = 0
  display_current_score(player_score, computer_score)

  until winning_score_reached?(player_score, computer_score)

    computer_move = random_move

    # computer_score is passed in to determine if add_suspense
    player_move = get_player_move(computer_score)

    sleep(0.3)
    system("clear")

    display_selected_moves(player_move, computer_move)

    display_round_result(player_move, computer_move)

    player_score = update_player_score(player_move, computer_move,
                                       player_score)
    computer_score = update_computer_score(player_move, computer_move,
                                           computer_score)

    display_current_score(player_score, computer_score)
  end

  display_grand_winner(player_score, computer_score)

  break unless play_again?
  system("clear")
end

prompt(MESSAGES["goodbye"])
sleep(3)
