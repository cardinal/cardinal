require 'Test'
include Test
plan 2

a = [ "a", "b", "c", "d", "e", "f" ]
b = a.select {|v| v == "a"}
is b, [ "a" ]

a = [ 0, 1, 2, 3, 4, 5 ]
b = a.select {|v| v % 2 == 1}
is b, [ 1, 3, 5 ]
