require "Test"
include Test

plan 3

is true, true, "true == true"
is false, false, "false == false"
isnt true, false, "true != false"
