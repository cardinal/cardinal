require 'Test'
include Test
plan 4

def foo(*n)
    todo "Slurpy param is apparently not an array.", "3"
    is n.class, Array, "slurpy param is an array"
    i = 0
    n.each do |a|
        is a, i, "slurpy item"
        i += 1
    end
end

foo(0,1,2)
