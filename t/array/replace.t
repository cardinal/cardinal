require 'Test'
include Test
plan 3

is [1,2].replace([3]),    [3], "replace"
is [1,2].replace([]),    [], "replace with empty"
is [].replace([3]),    [3], "replace empty"

