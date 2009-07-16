require "Test"
include Test

plan 8

a = {"foo" => "bar", "baz" => "quux", "frotz" => nil}

b = a.has_key?("foo")
is b, 1, "has_key? true"

b = a.has_key?("nope")
is b, 0, "has_key? false"

b = a.include?("foo")
is b, 1, "include?"

b = a.key?("foo")
is b, 1, "key?"

b = a.member?("foo")
is b, 1, "member?"

b = a.has_value?("baz")
is b, 1, "has_value? true"

b = a.has_value?("frotz")
is b, 0, "has_value? false"

b = a.value?("foo")
is b, 1, "value?"
