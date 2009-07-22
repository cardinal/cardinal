puts "1..7"

a = [ "a", "b", "c", "d" ]

puts "ok 1" if a.delete("d") == "d"
puts "ok 2" if a.delete("z") == nil
puts "ok 3" if a.delete("zZ"){ "no such element" } ==  "no such element"

puts "ok 4" if a.delete_at(0) == "a"
puts "ok 5" if a.length == 2

puts "ok 6" if a.delete_at(2) == nil

b = ["a", "bb", "ccc", "dddd"]
b.delete_if {|x| x == "bb" }

puts "ok 7" if b == ["a", "ccc", "dddd"]
