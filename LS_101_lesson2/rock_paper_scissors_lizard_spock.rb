# variables
DISPLAY_CHOICES = %w((R)ock (P)aper (S)cissors (L)izard Spoc(K))
VALID_CHOICES = %w(rock paper scissors lizard spock)
VALID_WINS = { rock: %w(scissors lizard),
               paper: %w(rock spock),
               scissors: %w(paper lizard),
               lizard: %w(spock paper),
               spock: %w(scissors rock) }
CONVERTED_INPUT = { r: "rock",
                    p: "paper",
                    s: "scissors",
                    l: "lizard",
                    k: "spock" }
user_choice = ''
player_score = 0
computer_score = 0
tie_score = 0
winner = ''

# methods
def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  VALID_WINS[first.to_sym].include?(second)
end

def convert_input(input)
  CONVERTED_INPUT.fetch(input.downcase().to_sym)
end

def user_input
  choice = ''
  loop do # user choice loop
    prompt("Choose one: #{DISPLAY_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp().downcase()
    break if CONVERTED_INPUT.key?(choice.to_sym)
    prompt("That's not a valid choice.")
  end
  choice
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won the round!")
  elsif win?(computer, player)
    prompt("Computer won the round!")
  else
    prompt("It's a tie!")
  end
end

def add_score(player, computer)
  if win?(player, computer)
    "player"
  elsif win?(computer, player)
    "computer"
  else
    "tie"
  end
end

def check_winner(score_player, score_computer)
  if score_player == 5
    "player"
  elsif score_computer == 5
    "computer"
  else
    "continue"
  end
end

def clear_screen
  system('clear') || system('cls')
end

def continue_playing?
  answer = ''
  loop do
    prompt("Do you want to play again? (Y) for yes/(N) for no")
    answer = Kernel.gets().chomp().downcase()
    break unless answer != 'y' && answer != 'n'
    prompt("That's an invalid input.")
  end
  clear_screen
  answer == 'y' ? true : false
end

# main program
loop do # main loop
  loop do # round loop
    user_choice = convert_input(user_input)

    computer_choice = VALID_CHOICES.sample

    clear_screen

    prompt("You chose: #{user_choice}; Computer chose: #{computer_choice}")

    display_results(user_choice, computer_choice)

    scoring = add_score(user_choice, computer_choice)
    if scoring == "player"
      player_score += 1
    elsif scoring == "computer"
      computer_score += 1
    else
      tie_score += 1
    end

    prompt("Your score is: #{player_score}
    The computer's score: #{computer_score}
    Tie score is: #{tie_score}")

    winner = check_winner(player_score, computer_score)
    if winner == "player"
      prompt("Congratulations, you won the game!")
      break
    elsif winner == "computer"
      prompt("The Computer won the game!")
      break
    end
  end

  break unless continue_playing?
  # reset score variables to zero
  player_score = 0
  computer_score = 0
  tie_score = 0
end

prompt("Thank you for playing!")
