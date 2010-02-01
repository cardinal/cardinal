.namespace []

.namespace [ 'NilClass' ]

.sub 'initialize' :method
    .param pmc args :slurpy
    noop
.end

=over 4

=item get_string()    (vtable method)

Return the elements of the list concatenated.

=cut

.sub 'get_string' :vtable :method
    $P0 = new 'String'
    $P0 = 'nil'
    .return($P0)
.end

.sub 'to_i' :method
    $P0 = new 'Integer'
    $P0 = 0
    .return ($P0)
.end

.sub 'to_a' :method
    $P0 = new 'Array'
    .return ($P0)
.end

.sub 'to_s' :method
    $P0 = new 'String'
    $P0 = ''
    .return($P0)
.end

.sub 'nil?' :method
    $P0 = get_hll_global 'true'
    .return ($P0)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
