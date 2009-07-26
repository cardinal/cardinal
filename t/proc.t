require 'Test'
include Test
plan 8

proc = Proc.new{ |n| 
	is n, 1, '.call on Proc'
}
pass '.new on Proc'
todo ".class of Proc is not Proc, apparently", "10"
is proc.class.to_s, 'Proc', '.class on Proc'
todo "Proc.arity is broken", "11"
is proc.arity, 1, '.arity on Proc'
proc.call(1)
myself = proc.to_proc
todo "Proc.to_proc is broken.", "12"
is myself.class.to_s, 'Proc', '.to_proc on Proc'

def gen_times(factor)
	return Proc.new {|n| n*factor }
end

times3 = gen_times(3)
times5 = gen_times(5)

todo "Problem with Proc.call?", "13"
is times3.call(12), 36, '.call on Proc'
is times5.call(5), 25, '.call on Proc'
todo "Problem with Proc.call?", "13"
is times3.call(times5.call(4)), 60, '.call on Proc' 
