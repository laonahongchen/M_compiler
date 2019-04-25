### What have I done

I have wrote a compiler in Java and have made it currently can do semantic check, and will output some information of compile error if it goes wrong. I used ANTLR4 to do Mxstar.Parser and lexer,  then build AST, build Mxstar.Symbol table, and do semantic check.



### What problem have I met

- I had a few problem with my Mxstar.Parser, cause I didn't really understand what ANTLR4 are doing. It once even couldn't recognize '('')' since this will be recognize as longer TOKEN, and when in Mxstar.Parser, ANTLR4 will not get the correct TOKEN for it, so it could not be recognized.
