=begin
  1. ask for loan amount
  2. ask for APR
  3. ask for Loan duration
  4. output monthly interest
  5. output loan duration in months

  use this formula:
    m = p * (j / (1 - (1 + j)**-n))
      m = monthly payment
      p = loan amount
      j = monthly interest rate
      n = loan duration in months

  Hints:
    1. Figure out what format your inputs need to be in. For example, should the
    interest rate be expressed as 5 or .05, if you mean 5% interest?
    2. If you're working with Annual Percentage Rate (APR), you'll need to
    convert that to a monthly interest rate.
    3. Be careful about the loan duration -- are you working with months or
    years? Choose variable names carefully to assist in remembering.
=end

# requires
require 'yaml'
require 'pry'

# variables
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')
language = ''
name = ''
annual_interest = ''
loan_term = ''
main_monthly_interest = ''
main_monthly_payment = ''
loan_amount = ''
continue_answer = ''

# modules
def messages(message, lang = 'en')
  MESSAGES[lang][message]
end

def prompt(input)
  Kernel.puts("=> #{input}")
end

def monthly_interest(apr)
  apr = (apr / 100)
  monthly_rate = (apr / 12)
  monthly_rate
end

def monthly_payment(loan, interest, term)
  payment = (loan * (interest / (1 - (1 + interest)**-term)))
  payment.round(2)
end

def which_language(answer)
  if answer == '2'
    return 'es'
  elsif answer == '1'
    return 'en'
  else
    prompt(messages('warning_language'))
    answer = Kernel.gets().chomp()
    which_language(answer)
  end
end

def not_numeric?(num)
    false if Float(num)
  rescue ArgumentError
    true
end

# main program
prompt(messages('language_preference')) # language preference
answer = Kernel.gets().chomp()
language = which_language(answer)

# welcome and ask for name
loop do
  prompt(messages('welcome', language))
  name = Kernel.gets().chomp()
  break unless name.empty?()
  prompt(messages('Invalid_name', language))
end

#  greet with name
prompt(messages('greeting', language) + name.capitalize)

loop do # main loop
  # ask for loan amount
  loop do
    prompt(messages('loan_amount_message', language))
    loan_amount = Kernel.gets().chomp()

    if loan_amount.empty?()
      prompt(messages('empty_message', language))
    elsif not_numeric?(loan_amount)
      prompt(messages('Invalid_entry', language))
    else
      break
    end
  end

  # ask for APR
  loop do
    prompt(messages('interest_message', language))
    annual_interest = Kernel.gets().chomp()

    if annual_interest.empty?()
      prompt(messages('empty_message', language))
    elsif not_numeric?(annual_interest)
      prompt(messages('Invalid_entry', language))
    else
      break
    end
  end
  main_monthly_interest = monthly_interest(annual_interest.to_f())

  # ask for loan term
  loop do
    prompt(messages('loan_term_message', language))
    loan_term = Kernel.gets().chomp()

    if loan_term.empty?()
      prompt(messages('empty_message', language))
    elsif not_numeric?(loan_term)
      prompt(messages('Invalid_entry', language))
    else
      break
    end
  end

  # make calculations
  main_monthly_payment = monthly_payment(loan_amount.to_f(),
                                         main_monthly_interest.to_f(),
                                         loan_term.to_f())

  # return result to user
  prompt(messages('result', language) + "$" + main_monthly_payment.to_s)
  prompt(messages('continue', language))
  continue_answer = Kernel.gets().chomp()
  if language == 'en'
    break unless continue_answer.downcase().start_with?('y')
  else
    break unless continue_answer.downcase().start_with?('s')
  end
end

prompt(messages('goodbye', language))
