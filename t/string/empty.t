require 'Test'
include Test

plan 3

s = 'parrot'
nok s.empty?, "empty? on 'parrot'"

s = ''
ok s.empty?, "empty? on ''"

s = "\n"
nok s.empty?, "empty? on \"\\n\""
