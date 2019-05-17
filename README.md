# M_compiler

This project is a compiler for Mx* language(which is designed in compiler@ACM-honored class@SJTU).

My project's code frame referenced @idy002 's compiler. So it may seem similar to a few other repos but in many details they are different(probably, I personally didn't check).

# Code Generation List

[X] finish the antlr g4 grammar file

[X] change the Mxstar.Parser tree to AST

[X] define the field on the AST

[X] finish semantic test

[X] build IR

[X] naive register allocation

[X] Stack pointer builder

currently we can already get a nasm.

[X] Global Variable allocation

# Optimize List

[X] Graph coloring allocation

[X] Value Numbering

[X] Bool shortcut optimization

[X] Inline Optimization(very ugly implementation, has a interface for a more beautiful one but not coded)

[X] Dead code Elimination

[X] Useless Loop Elimination on AST

