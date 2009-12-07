require 'Test'
include Test
plan 4

a = [ ]
is a.count(), 0, 'count, no items'

a = [ 1, 2, 3, 4 ]
is a.count(), 4, 'count, no args '

is a.count(2), 1, 'count, obj arg'

is a.count{|x| x>2 }, 2, 'count, block arg'

