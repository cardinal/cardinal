## $Id$

=head1 NAME

src/builtins/control.pir - Cardinal Control functions

=head1 Functions

=over 4

=cut

.namespace []

.include 'except_types.pasm'
.include 'except_severity.pasm'

.sub raise :multi()
    .local pmc name, ex
    name = get_hll_global '$!'
    $I0 = isnull name
    unless $I0 goto have_name
    name = get_hll_namespace ['RuntimeError']
  have_name:
    ex = new name
    ex['severity'] = .EXCEPT_ERROR
    say "No args"
    throw ex
.end

.sub raise :multi(CardinalString)
    .param pmc description
    .local pmc ex
    ex = new 'RuntimeError'
    ex['severity'] = .EXCEPT_ERROR
    $S0 = description
    ex = $S0
    say $S0
    throw ex
.end

=item lambda

=cut

.sub 'lambda'
    .param pmc block :named('!BLOCK')
    .return (block)
.end

=item take

=cut

.sub 'take'
    .param pmc value

    $P0         = new 'Exception'
    $P0['type'] = .CONTROL_TAKE
    $P0['severity'] = .EXCEPT_NORMAL
    setattribute $P0, 'payload', value
    throw $P0
    .return (value)
.end

.sub gather
    .param pmc block :named('!BLOCK')
    .local pmc list
    .local pmc eh
    list = 'list'()
    eh = new 'ExceptionHandler'
    eh.'handle_types'(.CONTROL_TAKE)
    set_addr eh, handler
    push_eh eh
    block()
    pop_eh
    .return (list)
  handler:
    .local pmc exception, continuation
    .local string message
    .get_results(exception)
    message = exception['message']
    continuation = exception['resume']
    $P0 = exception['payload']
    list.'push'($P0)
    continuation()
.end

.sub 'next'
    .local pmc e
    e = new 'Exception'
    e['type'] = .CONTROL_LOOP_NEXT
    e['severity'] = .EXCEPT_NORMAL
    throw e
.end

=item sleep(num)
Sleep for number of seconds.
=cut
.sub 'sleep'
    .param num a
    sleep a
.end

=item callcc(cc)

=cut
.sub 'callcc'
    .param pmc block :named('!BLOCK')
    $P0 = get_hll_global ['Kernel'], '!CARDINALMETA'
    $P0.'callcc'(block :named('!BLOCK'))
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

