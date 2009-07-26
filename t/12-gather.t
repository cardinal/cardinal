require 'Test'
include Test
plan 4

items = gather do
    take 0
    take 1
    take 2
end

is items.length, 3, "basic gather"

items.each do |i|
    ok i < 3, "basic gather"
end
