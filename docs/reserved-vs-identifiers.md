# Reserved Words vs. Identifiers in UPL

## Overview

In the Ugali Preparation Language (UPL), certain character sequences are reserved as language keywords (e.g., `PREPARE`, `INGREDIENTS`, `BOIL`, `COOK`), while others are used as user-defined variables or identifiers. Managing the boundary between these two categories is critical to prevent keywords from being incorrectly captured as variable names.

## Rule Priority in JFlex (Part e)

JFlex resolves ambiguities using two primary conflict-resolution rules:

1. **Longest Match Rule:** The lexer always matches the longest possible character sequence that forms a valid token.
2. **Rule Order (Priority) Rule:** If two rules match strings of the exact same length, the rule written _first_ in the `.flex` specification file takes precedence.

## Implementation Details

To ensure that keywords take absolute priority over general identifiers:

- **Keywords First:** All UPL reserved keywords are explicitly declared at the top of the lexical rules section in `UgaliLexer.flex`:
  ```flex
  "PREPARE"      { return symbol(TokenType.PREPARE); }
  "INGREDIENTS"  { return symbol(TokenType.INGREDIENTS); }
  "BOIL"         { return symbol(TokenType.BOIL); }
  "COOK"         { return symbol(TokenType.COOK); }
  ```
