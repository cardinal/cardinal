require 'Test'
include Test
plan 4
 
a = [ ]
is a.nitems(), 0, 'nitems, no items'
 
a = [ 1, 2, 3, 4 ]
is a.nitems(), 4, 'nitems, 4 non-nil items'
 
a = [ 1, 2, 3, nil ]
is a.nitems(), 3, 'nitems, 3 non-nil items, 1 nil'
 
a = [ nil, nil, nil, nil ]
is a.nitems(), 0, 'nitems, 4 nil items'
 
