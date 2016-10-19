a = [1, 2, 3]

def mutate(array)
  puts array.pop #.pop mutates, .last doesn't
end

p "before method: #{a}"
mutate(a)
p "after method: #{a}"
