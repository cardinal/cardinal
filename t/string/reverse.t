require 'Test'
include Test
plan 2

todo "String.reverse is kinda broken.","22",2
s1 = "testset!"
#s2 = s1.reverse
is s2, '!testset', '.reverse for String'
s2 = "!testset"
#s2.reverse!
is s2, 'testset!', '.reverse! for String'
