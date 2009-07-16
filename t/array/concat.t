require 'Test'
include Test

plan 1

a = [1,2,3]
b = [4,5,6]
a.concat(b)
is a, [1,2,3,4,5,6]
