require 'benchmark'
# To print out fibonacci sequence
# 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8  , 9  , 10 , 11 , 12 , 13  , 14  , 15
# 0 , 1 , 1 , 2 , 3 , 5 , 8 , 13 , 21 , 34 , 55 , 89 , 144 , 233, 377

def fibonacci(n)
  return unless n.is_a?(Integer)
  ar = [0, 1]
  if n > 1
    (0..(n-2)).each do |i|
      ar << ar[i] + ar[i + 1]
    end
  end
  ar[n]
end

def fibonacci2(n)
  return unless n.is_a?(Integer)
  return n if n < 2
  fibonacci2(n - 1) + fibonacci2(n - 2)
end

# puts Benchmark.measure { 0.upto(14) { |i|  puts "#{i + 1}: #{fibonacci(i)}" } }

# Measure the process runtime
nth = 25
Benchmark.bm do |x|
  x.report { 0.upto(nth) { |i| "#{i + 1}: #{fibonacci(i)}" } }
  x.report { 0.upto(nth) { |i| "#{i + 1}: #{fibonacci2(i)}" } }
end
