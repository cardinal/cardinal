require 'Test'
include Test
plan 2

a = [ 1, 2 ]
nothing = []
ok nothing.empty?, ".empty? on Array"
nok a.empty?, ".empty? on Array"
