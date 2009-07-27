require 'Test'
include Test
plan 22

a = [ 1, 2, 3, 4 ]

is a.first, 1
is a.first(2).last, 2
is a.last(2).first, 3
is a.length, 4

a = [ 5, 6 ]

n = 5

a.each() do |i|
    is i, n
    n += 1
end

b = [ [ 7, 8 ], [ 9, 10 ] ]

b.each() do |x|
    x.each() do |y|
        is y, n
        n += 1
    end
end

n = 0

a = [ 7, 8, 9, 10]

a.each_index() do |i|
  is i, n
  n+=1
end

a = [ 0, 1, 2, 3]

a.each_with_index() do |x, i|
  is x, i
end

a = [ 3, 2, 1, 0]
n = 0
a.reverse_each() do |x|
  is x, n
  n+=1
end
