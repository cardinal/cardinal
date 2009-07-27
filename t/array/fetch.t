require 'Test'
include Test
plan 8

a = [ 1, 2, 3, 4 ]

is a.fetch(0), 1, 'fetch, valid lookup'
is a.fetch(3), 4, 'fetch, valid lookup'
# TODO is a.fetch(5) throws IndexError exception

is a.fetch(3, 5), 4,         'fetch, valid lookup, default value'
is a.fetch(5, 5), 5,         'fetch, out of bounds, default value'
is a.fetch(5, 'cat'), 'cat', 'fetch, out of bounds, default value'

b=a.fetch(3) {|x| x*x }
is b, 4, 'fetch, valid lookup, default block'

b=a.fetch(5) {|x| 'dog' }
is b, 'dog', 'fetch, out of bounds, default block'

b=a.fetch(5) {|x| x*x }
is b, 25, 'fetch, out of bounds, default block'


