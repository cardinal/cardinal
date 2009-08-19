## $Id$

=head1 TITLE

FalseClass - Cardinal boolean class

=head1 DESCRIPTION

=cut

.namespace ['FalseClass']

.sub 'onload' :anon :init :load
    .local pmc falseproto
    falseproto = newclass 'FalseClass'

    $P0 = get_class 'CardinalObject'
    addparent falseproto, $P0

    $P0 = get_root_namespace ['parrot';'Boolean']
    $P0 = get_class $P0
    addparent falseproto, $P0

    $P0 = new 'FalseClass'
    set_hll_global 'false', $P0
.end

.sub '_get_bool' :vtable('get_bool') :method
    $P0 = new 'Boolean'
    $P0 = 0
    .return ($P0)
.end

.sub '_not' :vtable('logical_not') :method
    .param pmc wtf
    $P0 = get_hll_global 'true'
    .return ($P0)
.end

.sub 'to_s' :method :vtable('get_string')
    $S0 = "false"
    .return ($S0)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
