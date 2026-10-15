# HowDeepForth

A brief analysis to determine how deep is an implementation of a dictionary of compiled Forth words. 

## How

__In Forth compiled words are never realy executed__

The compiled word is a list of references to another words. 

Inside the inner interpreter, each reference is pushed into return stack until a primitive native code word is found, and executed, then the next reference is pulled from return stack, and the process continues for each reference.

The analysis is done by back tracing the primitives executed, counting how deep until a primitive is found, and how many primitives are executed.

That analysis shows the minimum size of return stack and which primitives are most used, essential parameters to tune any Forth implementation.

Results __Still in work__

