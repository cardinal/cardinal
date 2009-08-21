# The usual class setup stuff is combined with that of Object and Module.
# Look in src/builtins/classes.pir

=head1 TITLE

Class

=head1 DESCRIPTION

Classes in ruby are objects themselves, as instances of the class Class.

=head2 Class Methods

=over

=cut

.namespace ['Class';'meta']

=item Class.new(super_class=Object) => a_class

Class.new is the method used for making new classes. They're made anonymously
and must be assigned if the user wishes to save them.

=cut

.sub 'new' :method
    .param pmc super_rclass :optional
    .param int super_flag :opt_flag

    if super_flag goto have_super
    super_rclass = '!get_class'('Object')
  have_super:
    .local pmc new_pclass, new_meta_pclass, new_rclass, new_meta_rclass
    .local pmc super_pclass, meta_super_pclass, super_rclass, meta_super_rclass
    
    # We'll need this later:
    .local pmc nil
    nil = get_hll_global 'nil'

    # First get all the superclass information.
    super_pclass = getattribute super_rclass, '!parrot_class'
    meta_super_rclass = getattribute super_rclass, '!meta'
    meta_super_pclass = getattribute meta_super_rclass, '!parrot_class'

    # Then make the new parrot classes 
    new_pclass = subclass super_pclass
    new_meta_pclass = subclass meta_super_pclass 

    # Then make the new ruby classes
    new_rclass = new 'Class'
    new_meta_rclass = new 'Class'

    # Then fill in the parrot classes
    setattribute new_rclass, '!parrot_class', new_pclass
    setattribute new_meta_rclass, '!parrot_class', new_meta_pclass

    # Then the super classes
    setattribute new_rclass, '!super', super_rclass
    setattribute new_meta_rclass, '!super', meta_super_rclass

    # Then the metas
    setattribute new_rclass, '!meta', new_meta_rclass
    setattribute new_meta_rclass, '!meta', nil
    
    .return (new_rclass)
.end

=back

=head2 Instance Methods

=over

=cut

.namespace ['Class']

=item allocate() => an_object

The C<allocate> method is used to create a new object without initializing it.

Users will rarely need to call it, as it's called from C<new> automatically.

=cut

.sub 'allocate' :method
    $P0 = getattribute self, '!parrot_class'
    $P1 = new $P0
    .return ($P1)
.end

=item inherited(subclass)

The C<inherited> method is a callback provided to classes which is called 
whenever that class is subclassed.

=cut

.sub 'inherited' :method
    .param pmc subclass
.end

=item new(args, ...) => an_object

The C<new> method is called on a class to allocate and initialize a new object
of that class.

=cut

.sub 'new' :method
    .param pmc args :slurpy
    .local pmc obj

    obj = self.'allocate'()
    obj.'initialize'(args)
    
    .return (obj)
.end

=item superclass() => a_superclass or nil

The C<superclass> method will return a class's superclass. If called on
C<Object>, C<nil> is returned.

=cut

.sub 'superclass' :method
    $P0 = getattribute self, '!super'
    .return ($P0)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
