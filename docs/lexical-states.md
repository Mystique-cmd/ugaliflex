## Multiline comments

The scanner uses the exclusive `MULTILINE_COMMENT` lexical state for comments
delimited by `/*` and `*/`. Matching `/*` in the initial state records its
source position and enters the comment state. The comment rules discard
ordinary characters and single `*` characters; matching `*/` returns to
`YYINITIAL`. Comment text, including line breaks and token-like words, does
not produce tokens.

If end-of-file is reached before `*/`, a lexical error reports an unterminated
multiline comment at the opening delimiter and the scanner returns EOF.
Comments are not nested.

```upl
/* Ugali should be stirred continuously.
	Add flour gradually. */
boil 4 cups water;
```

Only `BOIL NUMBER(4) CUPS WATER SEMICOLON` is emitted for this input.
