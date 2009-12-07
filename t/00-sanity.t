require "Test"
include Test

puts "1..5" if 1

# comments work!
#
puts "ok 1" 
 
puts "ok 2" ; puts "ok 3"
 
print "ok "; print 1 + 3; print "\n"
 
print "ok #{ 2 * 2 + 1 }\n"

 ; ;   ; # Trailing whitespace should not be a problem for the code

