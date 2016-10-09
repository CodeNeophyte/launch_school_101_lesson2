# ask the customer for two numbers
# ask user for an operation to be performed
# perform the operation
# output the file

# answer = Kernel.gets().chomp()
# Kernel.puts(answer)

require 'yaml'
require 'pry'
MESSAGES = YAML.load_file('calculator_messages.yml')

LANGUAGE = 'es'

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def integer?(input)
  Integer(input) rescue false
end

def float?(input)
  Float(input) rescue false
end

def number?(input)
  integer?(input) || float?(input)
end



def operation_to_message(op)
word =       case op
              when '1'
                messages('Adding', LANGUAGE)
              when '2'
                messages('Substracting', LANGUAGE)
              when '3'
                messages('Multiplying', LANGUAGE)
              when '4'
                messages('Dividing', LANGUAGE)
             end
  x = "Random line"

  word
end

prompt(messages('welcome', LANGUAGE))

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(messages('valid_name', LANGUAGE))
  else
    break
  end
end

prompt(messages('hello', LANGUAGE) + "#{name}")

loop do # main loop
  number1 = ''
  loop do
    prompt(messages('first_number', LANGUAGE))
    number1 = Kernel.gets().chomp()

    if number?(number1)
      break
    else
      prompt(messages('valid_number', LANGUAGE))
    end
  end

  number2 = ''

  loop do
    prompt(messages('second_number', LANGUAGE))
    number2 = Kernel.gets().chomp()

    if number?(number2)
      break
    else
      prompt(messages('valid_number', LANGUAGE))
    end
  end

  # operator_prompt = <<-MSG
  # What operation would you like to perform:
  #   1) add
  #   2) substract
  #   3) multiply
  #   4) divide
  # MSG

  prompt(messages('operator_prompt', LANGUAGE))

  operator = ''

  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('valid_operators', LANGUAGE))
    end
  end

  prompt("#{operation_to_message(operator)}" + messages('operator_message', LANGUAGE))

  result = case operator
           when "1"
             number1.to_f() + number2.to_f()
           when "2"
             number1.to_f() - number2.to_f()
           when "3"
             number1.to_f() * number2.to_f()
           when "4"
             number1.to_f() / number2.to_f()
           end

  prompt(messages('result_message', LANGUAGE) + "#{result}")

  prompt(messages('calculator_loop', LANGUAGE))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(messages('goodbye', LANGUAGE))
