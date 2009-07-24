require 'Test'
include Test
plan 2

a = [6, 5, 4, 3, 2, 1, 7]
a = a.reject {|int| int % 2 == 0}
# For some reason the next line fails to parse
# a = a.reject {|int| (int % 2) == 0}
is a, [5, 3, 1, 7], 'reject'

b = [5, 4, 3, 2, 1, 8, 7, 6]
b.reject! {|int| int % 2 == 0}
is b, [5, 3, 1, 7], 'reject!'
