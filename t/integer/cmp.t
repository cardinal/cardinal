require "Test"
include Test

plan 3

is 1 < 7, 1, "1 < 7"
isnt 7 < 1, 1, "7 < 1"
is -5 < 10, 1, "-5 < 10"
