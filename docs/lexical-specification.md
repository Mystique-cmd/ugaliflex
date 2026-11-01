

The scanner groups characters of a UPL program into lexemes and classifies each into a token category. Each reserved word gets its own token because the grammar refers to them individually (e.g. `BOIL`, `WATER`). Whitespace and comments are discarded and never reach the parser.

## Reserved words

| Lexeme | Token | Lexeme | Token |
|---|---|---|---|
| prepare | PREPARE | check | CHECK |
| ingredients | INGREDIENTS | consistency | CONSISTENCY |
| boil | BOIL | shape | SHAPE |
| water | WATER | serve | SERVE |
| add | ADD | ugali | UGALI |
| flour | FLOUR | cups | CUPS |
| stir | STIR | minutes | MINUTES |
| press | PRESS | cook | COOK |
| turn | TURN | | |

## Other token categories

| Category | Example lexemes | Token | Passed to parser? |
|---|---|---|---|
| Integer literal | `4`, `2`, `8`, `15` | NUMBER | Yes |
| Delimiter | `;` | SEMICOLON | Yes |
| Identifier | `temperature`, `maize_flour`, `step2`, `cooking_time` | ID | Yes (recognized, though not used by the grammar) |
| Whitespace | spaces, tabs, newlines | WS | No, discarded |
| Single-line comment | `// stir slowly` | COMMENT | No, discarded |
| End of input | | EOF | Yes |
| Unrecognized character | `@`, `#`, `$` | ERROR | Lexical error reported |

## Example

Input:

```
boil 4 cups water; // heat first
```

Token stream:

```
BOIL  NUMBER(4)  CUPS  WATER  SEMICOLON
```

The comment and whitespace are discarded.

## Disambiguation rules

1. **Longest match:** the scanner always takes the longest possible lexeme. For example, `cooking_time` is one ID, not `COOK` followed by `ing_time`.
2. **Keyword priority:** if a lexeme matches both a keyword and the identifier pattern (e.g. `boil`), the keyword wins. In practice the scanner matches the identifier pattern, then looks the lexeme up in a reserved-word table.
3. **Case:** keywords are case-sensitive and lowercase, as in the examples.
