class Dog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def bark
    puts 'woof'
  end
end

bingo = Dog.new('Bingo')
bingo.bark

def bingo.say
  puts "#{self.name}: yoyoyo"
end

bingo.say



