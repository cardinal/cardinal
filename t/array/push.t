require 'Test'
include Test
plan 8

a = [ 1, 2 ]

a.push()
is a, [1,2], 'push nothing'

a.push(3)
is a, [1,2,3], 'single push'

a.push(4,5)
is a, [1,2,3,4,5], 'multiple push'

a.push(6, 'a')
is a, [1,2,3,4,5,6,'a'], 'multiple type push'

a.push([10,11])
is a, [1,2,3,4,5,6,'a',[10,11]], 'push an array'

a.push(nil)
is a, [1,2,3,4,5,6,'a',[10,11], nil], 'push nil'

b=[1]
c=b.push(2)
is [1,2], c, 'return value is array'
is b, c,     'return value is array'

