.namespace ['Exception']

.sub 'onload' :anon :init :load
    .local pmc excproto, core_type, hll_type, interp
    excproto = newclass 'Exception'

    $P0 = get_class 'Object'
    addparent excproto, $P0 

    $P0 = get_root_namespace ['parrot';'Exception']
    $P0 = get_class $P0
    addparent excproto, $P0

    core_type = get_class 'Exception'
    hll_type = get_class 'Exception'

    interp = getinterp
    interp.'hll_map'(core_type, hll_type)

    $P0 = newclass 'NoMemoryError'
    addparent $P0, excproto
    
    $P0 = newclass 'ScriptError'
    addparent $P0, excproto

    $P1 = newclass 'LoadError'
    addparent $P1, $P0

    $P1 = newclass 'NotImplementedError'
    addparent $P1, $P0

    $P1 = newclass 'SyntaxError'
    addparent $P1, $P0

    $P0 = newclass 'SignalException'
    addparent $P0, excproto

    $P1 = newclass 'Interrupt'
    addparent $P1, $P0

    $P0 = newclass 'StandardError'
    addparent $P0, excproto

    $P1 = newclass 'ArgumentError'
    addparent $P1, $P0

    $P1 = newclass 'IOError'
    addparent $P1, $P0

    $P2 = newclass 'EOFError'
    addparent $P2, $P1
    
    $P1 = newclass 'IndexError'
    addparent $P1, $P0

    $P1 = newclass 'LocalJumpError'
    addparent $P1, $P0

    $P1 = newclass 'NameError'
    addparent $P1, $P0

    $P2 = newclass 'NoMethodError'
    addparent $P2, $P1

    $P1 = newclass 'RangeError'
    addparent $P1, $P0

    $P2 = newclass 'FloatDomainError'
    addparent $P2, $P1
    
    $P1 = newclass 'RegexpError'
    addparent $P1, $P0

    $P1 = newclass 'RuntimeError'
    addparent $P1, $P0

    $P1 = newclass 'SecurityError'
    addparent $P1, $P0

    $P1 = newclass 'SystemCallError'
    addparent $P1, $P0

    $P1 = newclass 'SystemStackError'
    addparent $P1, $P0

    $P1 = newclass 'ThreadError'
    addparent $P1, $P0

    $P1 = newclass 'TypeError'
    addparent $P1, $P0

    $P1 = newclass 'ZeroDivisionError'
    addparent $P1, $P0

    $P0 = newclass 'SystemExit'
    addparent $P0, excproto

    $P0 = newclass 'fatal'
    addparent $P0, excproto
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

