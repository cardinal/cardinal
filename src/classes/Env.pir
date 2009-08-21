.namespace ['Env']

.sub 'onload' :load :anon :init
    $P0 = '!get_parrot_class'('Env')
    $P1 = '!get_class'('Object')
    '!make_named_class'('Env', $P1, $P0)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

