.namespace ['Exception']

.sub 'onload' :anon :init :load
    .local pmc exc, pexc
    pexc = '!get_parrot_class'('Exception')
    obj = '!get_class'('Object')
    exc = '!make_named_class'('Exception', obj, pexc)

    $P0 = '!make_named_class'('NoMemoryError', exc)
    
    $P0 = '!make_named_class'('ScriptError', exc)

    $P1 = '!make_named_class'('LoadError', $P0)

    $P1 = '!make_named_class'('NotImplementedError', $P0)

    $P1 = '!make_named_class'('SyntaxError', $P0)

    $P0 = '!make_named_class'('SignalException', exc)

    $P1 = '!make_named_class'('Interrupt', $P0)

    $P0 = '!make_named_class'('StandardError', exc)

    $P1 = '!make_named_class'('ArgumentError', $P0)

    $P1 = '!make_named_class'('IOError', $P0)

    $P2 = '!make_named_class'('EOFError', $P1)
    
    $P1 = '!make_named_class'('IndexError', $P0)

    $P1 = '!make_named_class'('LocalJumpError', $P0)

    $P1 = '!make_named_class'('NameError', $P0)

    $P2 = '!make_named_class'('NoMethodError', $P1)

    $P1 = '!make_named_class'('RangeError', $P0)

    $P2 = '!make_named_class'('FloatDomainError', $P1)
    
    $P1 = '!make_named_class'('RegexpError', $P0)

    $P1 = '!make_named_class'('RuntimeError', $P0)

    $P1 = '!make_named_class'('SecurityError', $P0)

    $P1 = '!make_named_class'('SystemCallError', $P0)

    $P1 = '!make_named_class'('SystemStackError', $P0)

    $P1 = '!make_named_class'('ThreadError', $P0)

    $P1 = '!make_named_class'('TypeError', $P0)

    $P1 = '!make_named_class'('ZeroDivisionError', $P0)

    $P0 = '!make_named_class'('SystemExit', exc)

    $P0 = '!make_named_class'('fatal', exc)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

