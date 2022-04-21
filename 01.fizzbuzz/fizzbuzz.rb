fizzbuzz = 0
while fizzbuzz < 20
  fizzbuzz += 1
  if fizzbuzz % (3*5) == 0
    puts 'FizzBuzz'
  elsif fizzbuzz % 3 == 0
    puts "Fizz"
  elsif fizzbuzz % 5 == 0
    puts "Buzz"
  else
    puts fizzbuzz
  end
end
