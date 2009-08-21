# The usual class setup stuff is combined with that of Class and Module.
# See src/builtins/classes.pir

=head1 TITLE

Object - Cardinal Object class

=head1 DESCRIPTION

Object is the base class for all Ruby objects and classes.

=head2 Class Methods

=over

=cut 

.namespace ['Object';'meta']

=item new()

In the standard Ruby documentation, this is listed but undocumented.

The actual code just returns C<nil>.

=cut

.sub 'new' :method
    $P0 = get_hll_global 'nil'
    .return ($P0)
.end

=back

=head2 Instance Methods

=over

=cut

.namespace ['Object']

=item obj == other => true or false

=item obj.equal?(other) => true or false

=item obj.eql?(other) => true or false

For C<Object>, all three of these test to see if the other is the exact same 
object as obj.

In inherited classes, C<==> is often overridden to provide class-specific 
meaning.

C<equal?()> should B<never> be overridden, and should always be expected to
test for object equality.

C<eql?()> is used to test for equality of value, and should be overidden to
provide that functionality.

=cut

.sub '==' :method
    .param pmc other

    .tailcall self.'equal?'(other)
.end

.sub 'equal?' :method
    .param pmc other

    $I0 = self.'object_id'()
    $I1 = other.'object_id'()
    
    if $I0 == $I1 goto true
    $P0 = get_hll_global 'false'
    .return ($P0)

  true:
    $P0 = get_hll_global 'true'
    .return ($P0)
.end

.sub 'eql?' :method
    .param pmc other

    .tailcall self.'equal?'(other)
.end

=item obj === other => true or false

C<===> is the operator for Case Equality. On C<Object>, it's the same as 
calling C<==>, but many classes override it to provide enhanced functionality
for case statements.

=cut

.sub '===' :method
    .param pmc other

    .tailcall self.'=='(other)
.end

=item obj =~ other => false

C<=~> is the Pattern Match operator, which can be overridden to provide
pattern matching functionality.

=cut

.sub '=~' :method
    .param pmc other

    $P0 = get_hll_global 'false'
    .return ($P0)
.end

=item obj.__id__() => fixnum

=item obj.object_id() => fixnum

Returns a numeric ID for the object. No two objects will ever have the same ID.

=cut

.sub '__id__' :method
    get_addr $I0, self
    .return ($I0)
.end

.sub 'object_id' :method
    get_addr $I0, self
    .return ($I0)
.end

=item obj.send(symbol, [args...]) => obj

=item obj.__send__(symbol, [args...]) => obj

Invokes the method indicated by C<symbol>, passing C<args> as given.

C<__send__> is available in case C<send> conflicts with another method name.

=cut

.sub 'send' :method
    .param pmc symbol
    .param pmc args :slurpy

    .tailcall self.'__send__'(symbol, args :flat)
.end

.sub '__send__' :method
    .param pmc symbol
    .param pmc args :slurpy
    .local string name

    $P0 = symbol.'to_s'()
    name = $P0

    $P0 = self.name(args)

    .return ($P0)
.end

=item obj.class() => a_class

Returns obj's class.

=cut

.sub 'class' :method
    $P0 = getattribute self, 'class'
    .return ($P0)
.end

=item to_s()

Return a String representation of the object.

=cut

.sub 'to_s' :method
    .tailcall self.'inspect'()     
.end

=item inspect()

This is the same a to_s by default unless overriden

=cut

.sub 'inspect' :method
    .local pmc classname
    .local string id
    $P0 = getattribute self, 'class'
    classname = $P0.'name'()
    id = self.'__id__'()
    $P0 = 'sprintf'('#<%s:%s>', classname, id)
    .return ($P0)
.end

=item methods()

Get a list of all methods in the object.

=cut

.sub 'methods' :method
    $P0 = class self
    $P1 = $P0.'methods'()
    .local pmc meth_iter
    meth_iter = iter $P1
    .local pmc method_list
    method_list = new 'Array'
  methods_loop:
    unless meth_iter goto methods_loop_end
    $P0 = shift meth_iter
    method_list.'push'($P0)
    goto methods_loop
  methods_loop_end:
    .return(method_list)
.end

=item obj.nil?()

Returns C<false> unless obj is C<nil>.

=cut

.sub 'nil?' :method
    $P0 = get_hll_global 'false'
   .return ($P0)
.end

=item obj.freeze() => obj

Prevents modification to obj, or it would if Cardinal paid attention to it.

When this is implemented, it will cause a C<TypeError> to be thrown if any
attempt to modify obj is made.

=cut

.sub 'freeze' :method
    $P0 = get_hll_global 'true'
    setattribute self, 'frozen', $P0
   .return (self)
.end

=item obj.frozen?() => true or false

Returns whether or not obj is frozen. At the moment, this doesn't actually
mean anything.

=cut

.sub 'frozen?' :method
    $P0 = getattribute self, 'frozen'
    .return ($P0)
.end

.sub 'is_a?' :method
        .param pmc test
        .local pmc metaclass
        .local int result
        metaclass = self.'HOW'()
        result = metaclass.'isa'(test)
        if result goto yes
        goto no
        yes:
          $P0 = get_hll_global 'true'
          .return ($P0)
        no:
          $P0 = get_hll_global 'false'
.end

.sub 'kind_of?' :method
        .param pmc test
        $P0 = self.'is_a?'(test)
        .return ($P0)
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
