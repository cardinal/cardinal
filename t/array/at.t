require 'Test'
include Test
plan 8

a = [ 1, 2 ]

is a.at(0), 1, 'at'
is a.at(1), 2, 'at'
is a.at(2), nil, 'at'
is a.at(-1), 2, 'at'
is a.at(-2), 1, 'at'
is a.at(-3), nil, 'at'

b = a.at(1) + 1
is b, 3, 'at'

c = a.at(1) * 2
is c, 4, 'at'
