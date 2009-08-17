require "Test"
include Test

plan 8

a = {"foo" => "bar", "baz" => "quux", "frotz" => nil}

b = a.has_key?("foo")
is b, true, "has_key? true"

b = a.has_key?("nope")
is b, false, "has_key? false"

b = a.include?("foo")
is b, true, "include?"

b = a.key?("foo")
is b, true, "key?"

b = a.member?("foo")
is b, true, "member?"

b = a.has_value?("baz")
is b, true, "has_value? true"

b = a.has_value?("frotz")
is b, false, "has_value? false"

b = a.value?("foo")
is b, true, "value?"
