require 'Test'
include Test
plan 3


discrete_range = Range.new(-3, -1)
n = -3
discrete_range.each() do |i|
    is i, n, '.each on Range'
    n += 1
end


# TODO "test range over ascii chars"
#discrete_range = Range.new('a','c')
#discrete_range.each() do |c|
#	p c
#end

# TODO "test range over custom objects"
