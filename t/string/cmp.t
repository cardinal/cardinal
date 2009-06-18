require 'Test'
include Test
plan 2

is "foo", "foo", "string equality"
isnt "foo", "bar", "string inequality"
