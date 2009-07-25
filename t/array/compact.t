require "Test"
include Test

plan 3

a = [0, 1, 2, nil, 3, nil, 4, nil, nil, 5, nil]
b = a.compact

is b, [0, 1,2,3,4,5], "Array.compact"

a = [1,2,3,4,5,'']
b = a.compact

is b, [1,2,3,4,5,''], "Array.compact with no nil elements"

a = [1, nil, 2]
a.compact!

is a, [1,2], "Array.compact!"
