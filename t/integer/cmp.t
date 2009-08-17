require "Test"
include Test

plan 3

is 1 < 7, true, "1 < 7"
is 7 < 1, false, "7 < 1"
is -5 < 10, true, "-5 < 10"
