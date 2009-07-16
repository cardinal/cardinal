require 'Test'
include Test
plan 3


n = Math.cos(0)
is n, 1, '.cos on Math'

n = Math.sin(0)
is n, 0, '.sin on Math'

n = Math.sqrt(25.0)
is n, 5.0, '.sqrt on Math' 
