require 'Test'
include Test
plan 15

a = [ 1, 2 ]
b = [ 3, 4]

c = a + b

index = 1
c.each() do |i|
    is i, index, "Array Addition"
    index += 1
end

c = b + a
c = c.collect{ |x| x + 4 }
c = c.sort
index = 5
c.each() do |i|
    is i, index, "collect"
    index += 1
end

a = [ 25, 50, 75, 100, 125 ]
b = [ 25, 50 ]
c = a - b
is c, [ 75, 100, 125 ], 'Array subtraction'
langs = [ "parrot", "perl", "erlang", "java" ]
minus = [ "java", "perl", "erlang" ]
langs = langs - minus
is langs, ["parrot"], 'Array subtraction'

d = b * 4
is d, [25,50,25,50,25,50,25,50], "Array multiplication with Integer"
d = b * ' '
is d, "25 50", "Array multiplication with String"

a = [1,3,5,7,8]
b = [1,5,8,9]
c = a & b
is c, [1,5,8], "Array & (intersection)"

a = [1,2] << "a" << 3 << [4,5]
is a, [1,2,"a",3,[4,5]], "Array <<"

a = [1,2,3] <=> [1,2,3]
is a, 0, "<=> with numbers, equal"
