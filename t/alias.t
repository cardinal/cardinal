require 'Test'
include Test
plan 2

class NumberHolder
    def initialize(n)
        @num = n
    end

    def inc
        @num = @num + 1
    end
    alias increment inc

    def num
      	@num
    end
end

obj = NumberHolder.new(0)
is obj.inc, 1, '.alias method'
is obj.increment, 2, '.alias method'
