require 'Test'
include Test
plan 10

a = [ 1 ]

b = a[0] = 0

is a, [0], 'assignemnt index, simple rhs'
is b, 0, 'assignment simple rhs, return value'

a[3] = 2
is a, [0,nil,nil,2], 'assignment index, simple rhs, with extend'

a[0,2] = [1,2]
is a, [1,2,nil,2], 'assignment index+count, array rhs'

a[0,3] = nil
is a, [2], 'assignment index+count, delete with nil'

a[1,3]=[1,0]
is a, [2,1,0], 'assignment index+count, array rhs'

a[-1]=2
is a, [2,1,2], 'assignment negative index, simple rhs'

a[-2,2]=0
is a, [2,0], 'assignment negative index+count'

a[0..1]=[1,2,3]
is a, [1,2,3], 'assignment range, array rhs'

a[0...1]=[0,0,0]
is a, [0,0,0,2,3], 'assignment range exclusive, array rhs'
