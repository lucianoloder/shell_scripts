#!/bin/sh

# Code found at "beginning linux programming", Neil Matthew & Rick Stones, P. 54
# Evaluates the operation, returning the result

#	eval is a bit like an extra $: It gives you the value of the value of a variable.
#	The eval command is very useful, allowing code to be generated and run on the fly. It does complicate
#	script debugging, but it can let you do things that are otherwise difficult or even impossible.


foo=10
x=foo
y='$'$x
echo y = $y

foo=10
x=foo
eval y='$'$x
echo y = $y

exit 0
