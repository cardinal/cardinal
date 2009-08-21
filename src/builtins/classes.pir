# Since Class, Module, and Object are all kinda bound up together, this
#   file handles their declaration all at once. Methods are still found
#   in the appropriate places.

.sub '' :load :init :anon
    # Well need this later:
    .local pmc nil
    nil = get_hll_global 'nil'

    # First, we'll make the parrot classes.
    .local pmc obj_pclass, cls_pclass, mdl_pclass

    obj_pclass = newclass 'Object'
    addattribute obj_pclass, 'class'
    addattribute obj_pclass, 'frozen'

    mdl_pclass = subclass obj_pclass, 'Module'
    addattribute mdl_pclass, '!super'
    addattribute mdl_pclass, '!meta'
    addattribute mdl_pclass, '!parrot_class'
    # This next is actually for metaclasses to refer back to their class.
    addattribute mdl_pclass, '!class'

    cls_pclass = subclass mdl_pclass, 'Class'

    # Then we make the parrot classes for the metaclasses.
    .local pmc obj_meta_pclass, mdl_meta_pclass, cls_meta_pclass
    obj_meta_pclass = subclass cls_pclass, ['Object';'meta']
    mdl_meta_pclass = subclass obj_meta_pclass, ['Module';'meta']
    cls_meta_pclass = subclass mdl_meta_pclass, ['Class';'meta']

    # Then we make the Ruby Classes.
    .local pmc obj_rclass, cls_rclass, mdl_rclass
    .local pmc obj_meta_rclass, cls_meta_rclass, mdl_meta_rclass

    obj_rclass = new 'Class'
    cls_rclass = new 'Class'
    mdl_rclass = new 'Class'

    obj_meta_rclass = new 'Class'
    cls_meta_rclass = new 'Class'
    mdl_meta_rclass = new 'Class'

    # And fill in the parrot classes.

    setattribute obj_rclass, '!parrot_class', obj_pclass
    setattribute mdl_rclass, '!parrot_class', mdl_pclass
    setattribute cls_rclass, '!parrot_class', cls_pclass

    setattribute obj_meta_rclass, '!parrot_class', obj_meta_pclass
    setattribute mdl_meta_rclass, '!parrot_class', mdl_meta_pclass
    setattribute cls_meta_rclass, '!parrot_class', cls_meta_pclass

    # And then the super classes

    setattribute obj_rclass, '!super', nil
    setattribute mdl_rclass, '!super', obj_rclass
    setattribute cls_rclass, '!super', mdl_rclass

    setattribute obj_meta_rclass, '!super', cls_rclass
    setattribute mdl_meta_rclass, '!super', obj_meta_rclass
    setattribute cls_meta_rclass, '!super', mdl_meta_rclass

    # And then the metas

    setattribute obj_rclass, '!meta', obj_meta_rclass
    setattribute mdl_rclass, '!meta', mdl_meta_rclass
    setattribute cls_rclass, '!meta', cls_meta_rclass

    setattribute obj_meta_rclass, '!meta', nil
    setattribute mdl_meta_rclass, '!meta', nil
    setattribute cls_meta_rclass, '!meta', nil

    # Now we populate the globals
    .local pmc glbl

    glbl = new obj_meta_pclass
    setattribute glbl, '!class', obj_rclass
    set_hll_global 'Object', glbl

    glbl = new mdl_meta_pclass
    setattribute glbl, '!class', mdl_rclass
    set_hll_global 'Module', glbl

    glbl = new cls_meta_pclass
    setattribute glbl, '!class', cls_rclass
    set_hll_global 'Class', glbl

    # Now things should be good to go.
.end

.sub '!get_class'
    .param pmc name
    $S0 = name
    $P0 = get_hll_global $S0
    $P0 = getattribute $P0, '!class'
    .return ($P0)
.end

.sub '!get_parrot_class'
    .param pmc name
    $S0 = name
    $P0 = get_root_namespace ['parrot';$S0]
    $P0 = get_class $P0
    .return ($P0)
.end

.sub '!new'
    .param pmc cls
    .param pmc args :slurpy
    .local pmc meta
    cls = '!get_class'(cls)
    meta = getattribute cls, '!meta'
    meta = new meta
    $P0 = meta.'new'(args :flat)
    .return ($P0)
.end

.sub '!make_named_class'
    .param pmc name
    .param pmc superclass
    .param pmc parrot_super :optional
    .param int psuper_flag :opt_flag

    .local pmc class_meta
    .local pmc new_class
    class_meta = get_hll_global 'Class'
    new_class = class_meta.'new'(superclass)
    
    $P0 = getattribute new_class, '!meta'
    $P0 = getattribute $P0, '!parrot_class'
    $P1 = new $P0
    setattribute $P1, '!class', new_class
    $S0 = name
    set_hll_global $S0, $P1

    unless psuper_flag goto done
    .local pmc interp
    $P0 = getattribute new_class, '!parrot_class'

    addparent $P0, parrot_super

    interp = getinterp
    interp.'hll_map'(parrot_super, $P0)

  done:
    .return (new_class)
.end

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:

