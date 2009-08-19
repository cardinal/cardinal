.namespace []

.namespace [ 'NilClass' ]

.sub 'onload' :anon :load :init
    .local pmc nilproto
    nilproto = newclass 'NilClass'

    $P0 = get_class 'CardinalObject'
    addparent nilproto, $P0

    $P0 = get_root_namespace ['parrot';'Undef']
    $P0 = get_class $P0
    addparent nilproto, $P0
.end

=over 4

=item get_string()    (vtable method)

Return the elements of the list concatenated.

=cut

.sub 'get_string' :vtable :method
    $P0 = new 'CardinalString'
    $P0 = 'nil'
    .return($P0)
.end

.sub 'to_i' :method
    $P0 = new 'CardinalInteger'
    $P0 = 0
    .return ($P0)
.end

.sub 'to_a' :method
    $P0 = new 'CardinalArray'
    .return ($P0)
.end

.sub 'to_s' :method
    $P0 = new 'CardinalString'
    $P0 = ''
    .return($P0)
.end

.sub 'nil?' :method
    $P0 = get_hll_global 'true'
    .return ($P0)
.end

.namespace []
.sub 'setup' :anon :load :init
    $P0 = new 'NilClass'
    set_hll_global 'nil', $P0
.end


# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
