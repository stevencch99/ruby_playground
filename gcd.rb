# Euclidean algorithm
#
# In mathematics, the Euclidean algorithm, or Euclid's algorithm,
# is an efficient method for computing the greatest common divisor (GCD) of two integers
# (numbers), the largest number that divides them both without a remainder.

def gcd(a, b)
  while b != 0 do
    t = a % b
    a = b
    b = t
  end

  return a
end

p 'Arguments:', ARGV

p gcd(ARGV[0].to_i, ARGV[1].to_i)
