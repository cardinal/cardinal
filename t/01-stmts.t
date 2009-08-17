# If this is to test the basic statements then we can't really use Test.rb
# Although of course Test.rb itself contains all the statements tested
puts "1..2"

if 1 then
  puts "ok 1"
else
  puts "not ok 1"
end

unless 0
  puts "not ok 2 # TODO 0 evaluates to false (and so do [] and '') See issue #28"
else
  puts "ok 2"
end


