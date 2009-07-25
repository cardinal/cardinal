require 'Test'
include Test
plan 2

skip_rest "open() doesn't seem to exist", "25"
#pipe = open("| echo *.t")
#p pipe.class
#files = pipe.readline
#p files
#pipe.close
