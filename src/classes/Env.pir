.namespace ['Env']

.sub 'onload' :load :anon :init
    $P0 = newclass 'Env'
    
    $P1 = get_root_namespace ['parrot';'Env']
    $P1 = get_class $P1

    addparent $P0, $P1
.end
# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

