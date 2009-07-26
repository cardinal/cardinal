require 'Test'
include Test
plan 8

a = []

is a.index(1), nil, 'index'
is a.rindex(1), nil, 'index'

a = [1,2,3,4,5,4,3,2,1]

is a.index(1), 0, 'index'
is a.index(5), 4, 'index'
is a.index(6), nil, 'index'

is a.rindex(1), 8, 'rindex'
is a.rindex(5), 4, 'rindex'
is a.rindex(6), nil, 'rindex'
