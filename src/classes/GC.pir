## $Id$

=head1 TITLE

GC - Cardinal GC class

=head1 DESCRIPTION

=head2 Functions

=over

=item onload()

Perform initializations and create the GC class

=cut

.namespace ['GC']

.sub 'onload' :anon :init :load
    .local pmc gcpclass

    $P0 = '!get_class'('Object')
    $P1 = '!make_named_class'('GC', $P0)
    
    gcpclass = getattribute $P1, '!parrot_class'
    addattribute gcpclass, '$!disabled'
.end

.sub 'get_bool' :vtable
    .return (1)
.end

#.sub 'get_string' :vtable
#   $S0 = 'GC'
#   .return ($S0)
#.end

.sub 'init' :vtable('init')
    $P1 = new 'Bool'
    $P1 = get_hll_global ['Bool'], 'false'
    setattribute self, '$!disabled', $P1
.end

.sub 'disable' :method
   $P0 = getattribute self, "$!disabled"
   #could have been null, need to make this class a singleton with these a class methods, not instance methods
   if $P0 == 1 goto already_disabled
   goto disable
   disable:
        $P1 = new 'Integer'
        $P1 = 1
        setattribute self, '$!disabled', $P1
        collectoff
        $P0 = get_hll_global 'false'
        .return ($P0)
   already_disabled:
        $P0 = get_hll_global 'true'
        .return ($P0)
.end

.sub 'enable' :method
   $P0 = getattribute self, "$!disabled"
   if $P0 == 1 goto enable
   goto already_enabled
   already_enabled:
        $P0 = get_hll_global 'false'
        .return ($P0)
   enable:
        $P1 = new 'Integer'
        $P1 = 0
        setattribute self, '$!disabled', $P1
        collecton
        $P0 = get_hll_global 'true'
        .return ($P0)
.end

.sub 'start' :method
    collect
    $P0 = get_hll_global 'nil'
    .return ($P0)
.end

.sub 'each_object' :method
    .param pmc block :named('!BLOCK')
    .local pmc addr_space, itr
    .local pmc test
    .return(1)
    test = new 'String'
    test = "yo"
    # Nope AddrResgistry is not what I expected, we cant use it.
    # We need to create Hash to store all the objects, Use WeakRefs to store the pmcs?
    addr_space = new 'AddrRegistry'
    $I0 = get_addr test
    addr_space[$I0] = test
    #$P0 = addr_space.'methods'()
    #say $P0
    itr = iter addr_space
    print "created iterator: "
    say itr
    $S0 = typeof itr
    print "itr type="
    say $S0
    itr_loop:
        unless itr goto itr_end
        $P0 = shift itr
        $I0 = defined $P0
        unless $I0 goto itr_loop
        print "found: "
        say $P0
        goto itr_loop
    itr_end:
        say "done looping thru addr_space"
        .return ()
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
