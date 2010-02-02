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
    .param int ignore_parrot :optional
    .param int ignore_flag   :opt_flag

    setattribute self, 'name', name

    if ignore_flag goto done

    .local pmc pclass

    pclass = getattribute self, '!parrot_class'
    pclass.'name'(name)

  done:

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

