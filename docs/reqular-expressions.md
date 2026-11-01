

## Definitions

```
letter = [a-zA-Z]
digit  = [0-9]
```

## Regular expressions

| Token | Regular expression |
|---|---|
| Integer literal (NUMBER) | `digit+`, i.e. `[0-9]+` |
| Identifier (ID) | `letter (letter \| digit \| _)*`, i.e. `[a-zA-Z][a-zA-Z0-9_]*` |
| Whitespace (WS) | `[ \t\n\r]+` |
| Single-line comment (COMMENT) | `//[^\n]*` (`//` followed by any characters except newline) |
| Semicolon (SEMICOLON) | `;` |
| Reserved words | see below |

## Reserved words

Each keyword is the literal string itself, and the full set is their union:

```
prepare | ingredients | boil | water | add | flour | stir | press | turn |
cook | check | consistency | shape | serve | ugali | cups | minutes
```

Individual patterns:

```
PREPARE      -> prepare
INGREDIENTS  -> ingredients
BOIL         -> boil
WATER        -> water
ADD          -> add
FLOUR        -> flour
STIR         -> stir
PRESS        -> press
TURN         -> turn
COOK         -> cook
CHECK        -> check
CONSISTENCY  -> consistency
SHAPE        -> shape
SERVE        -> serve
UGALI        -> ugali
CUPS         -> cups
MINUTES      -> minutes
```

## Verification of identifiers

| Lexeme | Derivation | Valid? |
|---|---|---|
| `temperature` | letters only | Yes |
| `maize_flour` | letters, `_`, letters | Yes |
| `step2` | letters, then digit | Yes |
| `cooking_time` | letters, `_`, letters | Yes |
| `2step` | starts with a digit, so lexes as NUMBER(2) then ID(step) | No (as one ID) |
| `_flour` | starts with `_`, which is not a letter | No |

## Flex implementation sketch

```lex
DIGIT   [0-9]
LETTER  [a-zA-Z]

%%
"prepare"        { return PREPARE; }
"ingredients"    { return INGREDIENTS; }
"boil"           { return BOIL; }
"water"          { return WATER; }
"add"            { return ADD; }
"flour"          { return FLOUR; }
"stir"           { return STIR; }
"press"          { return PRESS; }
"turn"           { return TURN; }
"cook"           { return COOK; }
"check"          { return CHECK; }
"consistency"    { return CONSISTENCY; }
"shape"          { return SHAPE; }
"serve"          { return SERVE; }
"ugali"          { return UGALI; }
"cups"           { return CUPS; }
"minutes"        { return MINUTES; }

{DIGIT}+                          { return NUMBER; }
{LETTER}({LETTER}|{DIGIT}|_)*     { return ID; }
";"                               { return SEMICOLON; }
"//"[^\n]*                        { /* skip comment */ }
[ \t\r\n]+                        { /* skip whitespace */ }
.                                 { lexical_error(yytext); }
%%
```

Flex picks the longest match, and on a tie it picks the rule listed first. Because the keyword rules come before the ID rule, `boil` returns BOIL, while `boiler` returns ID because it is a longer match.
