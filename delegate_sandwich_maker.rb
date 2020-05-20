class SandwichMaker
  def make_me_a_sandwich
    puts 'OKAY'
  end
end

# class LazyEmployee
  # def initialize(sandwich_maker)
    # @sandwich_maker = sandwich_maker
  # end

  # def make_me_a_sandwich
    # sandwich_maker.make_me_a_sandwich
  # end

  # private
  # attr_reader :sandwich_maker
# end

# require 'forwardable'

# class LazyEmployee
  # extend Forwardable
  
  # def initialize(sandwich_maker)
    # @sandwich_maker = sandwich_maker
  # end
  
  # def_delegators :@sandwich_maker, :make_me_a_sandwich
# end
#

require 'active_support/core_ext/module/delegation'

class LazyEmployee
  def initialize(sandwich_maker)
    @sandwich_maker = sandwich_maker
  end
  
  delegate :make_me_a_sandwich, to: :sandwich_maker
  
  private
  attr_reader :sandwich_maker
end
