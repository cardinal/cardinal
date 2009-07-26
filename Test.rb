module Test
    $testnum = 1
    $failed = 0
    $planned = 0
    $started = 0
    $todo_upto = 0
    $todo_reason

    def plan(num)
        print '1..',num,"\n"
        $started = 1
        $testnum = 1
        $todo_upto = 0
        $failed = 0
        $planned = num
    end

    def pass(desc='')
        proclaim(1,desc)
    end

    def flunk(desc='')
        proclaim(0,desc)
    end

    def ok(cond,desc='')
        proclaim(cond, desc)
    end

    def nok(cond,desc='')
        if cond then
            flunk desc
        else
            pass desc
        end
    end

    def is(got,expected,desc='')
        proclaim(got == expected, desc)
    end

    def isgt(got,expected,desc='')
        proclaim(got > expected, desc)
    end

    def isge(got,expected,desc='')
        proclaim(got >= expected, desc)
    end

    def isnt(got,expected,desc='')
        proclaim(got != expected, desc)
    end

    def todo(reason,issue="",count=1)
        $todo_upto = $testnum + count
        $todo_reason = " # TODO #{reason} See issue ##{issue}." 
    end

    def skip(reason='',issue="",count=1)
        1.upto(count) { flunk("# SKIP #{reason} See issue ##{issue}.") }
    end

    def skip_rest(reason='',issue="")
        skip(reason,issue,$planned - $testnum + 1)
    end

    def proclaim(cond,desc)
        if cond then
        else
            print "not "
            $failed += 1 if $todo_upto < $testnum
        end
        print 'ok ', $testnum, ' - ', desc
        $testnum += 1
        if $todo_reason and $todo_upto >= $testnum then
            print $todo_reason
        end
        puts
    end
end
