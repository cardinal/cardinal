require 'Test'
include Test
plan 4

a = [ 1, 2, 3, 4 ]

is a.insert(0, 'cat'),    ['cat', 1, 2, 3, 4,], "insert front"
is a.insert(0, 'cat', 8), ['cat', 8, 'cat', 1, 2, 3, 4,], "insert front"
is a.insert(-1, 'dog'),   ['cat', 8, 'cat', 1, 2, 3, 4, 'dog'], "insert end"

todo "Need to sort out nil vs undef", "30"
is a.insert(9, 'fish'),   ['cat', 8, 'cat', 1, 2, 3, 4, 'dog', nil, 'fish'], "insert and extend"

todo "Throw exceptions correctly", "29"
#is a.insert(-88, 'shark') should throw an exception
