## $Id$

=head1 NAME

src/builtins/op.pir - Cardinal ops

=head1 Functions

=over 4

=cut

.namespace []

.sub 'infix:+' :multi(_,_)
    .param num a
    .param num b
    $P0 = new 'Integer'
    $N0 = add a, b
    $P0 = $N0
    .return ($P0)
.end

.sub 'infix:-' :multi(_,_)
    .param num a
    .param num b
    $P0 = new 'Integer'
    $N0 = sub a, b
    $P0 = $N0
    .return ($P0)
.end

.sub 'infix:*' :multi(_,_)
    .param num a
    .param num b
    $P0 = new 'Integer'
    $N0 = mul a, b
    $P0 = $N0
    .return ($P0)
.end

.sub 'infix:/' :multi(_,_)
    .param num a
    .param num b
    $P0 = new 'Integer'
    $N0 = div a, b
    $P0 = $N0
    .return ($P0)
.end

.sub 'infix:+' :multi(String,_)
    .param pmc a
    .param pmc b
    $P0 = new 'String'
    $P0 = concat a, b
    .return ($P0)
.end

.sub 'infix:+' :multi(Array,Array)
    .param pmc a
    .param pmc b
    $P0 = new 'Array'
    $P0 = 'list'(a :flat, b :flat)
    .return ($P0)
.end

.sub 'infix:-=' :multi(_,_)
    .param pmc a
    .param pmc b
    a -= b
    .return (a)
.end

.sub 'infix:+=' :multi(_,_)
    .param pmc a
    .param pmc b
    a += b
    .return (a)
.end

.sub 'infix:+=' :multi(String,_)
    .param pmc a
    .param pmc b
    $P0 = 'infix:+'(a,b)
    assign a, $P0
    .return (a)
.end

.sub 'infix:&' :multi(_,_)
    .param int a
    .param int b
    $I0 = band a, b
    .return ($I0)
.end

.sub 'infix:*' :multi(CardinalString,CardinalInteger)
    .param pmc a
    .param pmc b
    $P0 = new 'String'
    $P0 = repeat a, b
    .return ($P0)
.end


## autoincrement
.sub 'postfix:++' :multi(_)
    .param pmc a
    $P0 = clone a
    inc a
    .return ($P0)
    #.return (a)
.end

.sub 'postfix:--' :multi(_)
    .param pmc a
    $P0 = clone a
    dec a
    .return ($P0)
.end


=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
