# variables
VALID_CHOICES = %w(rock paper scissors lizard spock)
choice = ''
player_score = 0
computer_score = 0
tie_score = 0
winner = ''

# methods
def prompt(message)
  Kernel.puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'spock' && second == 'scissors') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'spock' && second == 'rock')
end

def convert_input(input)
  case input.downcase()
  when 'r'
    return "rock"
  when 'p'
    return "paper"
  when 'l'
    return "lizard"
  when 's'
    loop do
      puts "Type 'c' for scissors or 'p' spock "
      convert_answer = Kernel.gets().chomp()
      if convert_answer == "c"
        return "scissors"
        break
      elsif convert_answer == "p"
        return "spock"
        break
      else
        puts "Invalid entry."
      end
    end
  end
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

def tally_score(player, computer)
  if win?(player, computer)
    return "player"
  elsif win?(computer, player)
    return "computer"
  else
    return "tie"
  end
end

def check_winner(score_player, score_computer)
  if score_player == 5
    return "player"
  elsif score_computer == 5
    return "computer"
  else
    return "continue"
  end
end

# main program
loop do # main loop
  loop do # round loop
    loop do # user choice loop
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = Kernel.gets().chomp()
      choice = convert_input(choice)

      if VALID_CHOICES.include?(choice)
        break
      else
        prompt("That's not a valid choice.")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    display_results(choice, computer_choice)

    scoring = tally_score(choice, computer_choice)
    if scoring == "player"
      player_score += 1
    elsif scoring == "computer"
      computer_score += 1
    else
      tie_score += 1
    end

    prompt("Your score is: #{player_score}; The computer's score: #{computer_score};
            Tie score is: #{tie_score}")

    winner = check_winner(player_score, computer_score)
    if winner == "player"
      prompt("Congratulations, you won the game!")
      break
    elsif winner == "computer"
      prompt("The Computer won the game!")
      break
    else
      # continue game
      next
    end
  end

  prompt("Do you want to play again?")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
  # reset score variables to zero
  player_score = 0
  computer_score = 0
  tie_score = 0
end

prompt("Thank you for playing!")
