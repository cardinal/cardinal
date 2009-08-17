puts "1..4"

a = [ 'ok ', 1 ]

puts a[0] + a[1].to_s

a = [ 'ok ', 2, 3, 4 ]
b = 1

puts a[0] + a[b].to_s
puts a[0] + a[a[1]].to_s
puts a[0] + a[a[a[1]]].to_s
