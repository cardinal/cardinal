require "Test"
include Test

plan 10

is true, true, "true == true"
is false, false, "false == false"
isnt true, false, "true != false"
isnt true, 1, "true != 1"
isnt true, 0, "true != 0"
isnt false, 0, "false != 0"
isnt -1, false, "-1 != false"
isnt -1, true, "-1 != false"
isnt "", false, "empty string isn't false"
isnt "", true, "empty string isn't true"
