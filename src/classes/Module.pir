# The usual class setup stuff is combined with that of Object and Class.
# Look in src/builtins/classes.pir

=head1 TITLE

Module

=head1 DESCRIPTION

=cut

.namespace ['Module';'meta']

.namespace ['Module']

.sub 'name=' :method
    .param pmc name

    setattribute self, 'name', name

    .local pmc pclass

    #pclass = getattribute self, '!parrot_class'
    #pclass.'name'(name) 
.end

.sub 'name' :method
    .local pmc value
    value = getattribute self, 'name'
    .return (value)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

