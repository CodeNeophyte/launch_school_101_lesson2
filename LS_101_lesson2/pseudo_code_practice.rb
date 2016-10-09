=begin
a method that returns the sum of two integers
a method that takes an array of strings, and returns
 a string that is all those strings concatenated
 together
a method that takes an array of integers, and returns
 a new array with every other element
=end

1)
Ask user to input two numbers.
Set the method to take 2 numbers as arguments
then add them and return the sum

Formal pseudo
START
  GET user input for each number
  SET number1 = user's first number'
  SET number2 = user's second number'

  DEFINE method(number1, number2)
    SET sum = addition of both numbers
    PRINT sum

  call method with arguments
END

2)
Given an array of strings, pass them to a method
and concatenate them. Return the string to user

Formal pseudo
START
  GET array

  DEFINE method, takes 1 argument(array)
   SET joined_string = joining the array with join method
   PRINT joined_string

END

3)
Given an array of integers, print everyother number

Formal pseudo
START
  GET array

  DEFINE method, takes 1 argument(array)
    WHILE array = array.even?
      SET new_arr = array.even

    PRINT new_arr
END
