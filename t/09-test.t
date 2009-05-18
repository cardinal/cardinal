require 'Test'
include Test

plan 3

ok(1)
is 1+1, 2
is "foo", ['f','o','o'].to_s
