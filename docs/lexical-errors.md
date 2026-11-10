# Lexical Error Handling in UPL

## Overview

During the lexical analysis phase, the scanner processes the input character stream and converts it into valid tokens. However, users may introduce invalid characters or malformed tokens (such as unexpected symbols outside the grammar). To prevent the compiler from crashing or hanging, a robust lexical error-handling mechanism is implemented in `UgaliLexer.flex`.

## Implementation Strategy

1. **Line and Column Tracking:** JFlex is configured to track line and column coordinates using `yyline` and `yycolumn`. This ensures that any reported error includes precise location metadata to help the programmer debug their source code.
2. **Catch-All Error Rule:** A fallback rule is placed at the very bottom of the lexical specification:
   ```flex
   [^] {
       System.err.println("Lexical error at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ": illegal character '" + yytext() + "'");
   }
   ```
