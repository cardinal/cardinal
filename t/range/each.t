require 'Test'
include Test
plan 4


discrete_range = Range.new(-3, -1)
n = -3
discrete_range.each() do |i|
    is i, n, '.each on Range'
    n += 1
end


skip "test range over ascii chars", "14"
#res = ['a','b','c']
#test = []
#discrete_range = Range.new('a','c')
#discrete_range.each() do |c|
#	test += c
#end
#
#is test, res, "Range.each with String"

# TODO "test range over custom objects"
