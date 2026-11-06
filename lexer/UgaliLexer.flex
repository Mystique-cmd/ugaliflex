package lexer;

import lexer.tokens.Token;
import lexer.tokens.TokenType;


/* ===== Section 1: user code (none needed, Token/TokenType are separate files) ===== */

%%

/* ===== Section 2: options and macros ===== */

%public
%class UgaliLexer
%unicode
%line                  /* enables yyline  (0-based) */
%column                /* enables yycolumn (0-based) */
%type Token            /* nextToken() returns our own Token objects */
%function nextToken
%xstate MULTILINE_COMMENT

%{
    /* Helpers: build a Token with 1-based line and column */
    private Token token(TokenType type) {
        return new Token(type, yytext(), null, yyline + 1, yycolumn + 1);
    }
    private Token token(TokenType type, Object value) {
        return new Token(type, yytext(), value, yyline + 1, yycolumn + 1);
    }
    private void lexError(String msg) {
        System.err.println("Lexical error at line " + (yyline + 1)
            + ", column " + (yycolumn + 1) + ": " + msg);
    }
    private void lexErrorAt(String msg, int line, int column) {
        System.err.println("Lexical error at line " + line
            + ", column " + column + ": " + msg);
    }
    private int commentStartLine;
    private int commentStartColumn;
%}

/* What to return when the input ends */
%eofval{
    return new Token(TokenType.EOF, "", null, yyline + 1, yycolumn + 1);
%eofval}

/* Macros (named regular expressions) */
DIGIT    = [0-9]
LETTER   = [a-zA-Z]
INTEGER  = {DIGIT}+
ID       = {LETTER}({LETTER}|{DIGIT}|_)*
WS       = [ \t\r\n\f]+
COMMENT  = "//"[^\r\n]*

%%

/* ===== Section 3: rules (ORDER MATTERS) ===== */

/* 1. Reserved words: listed BEFORE {ID} so they win ties */
"prepare"      { return token(TokenType.PREPARE); }
"ingredients"  { return token(TokenType.INGREDIENTS); }
"boil"         { return token(TokenType.BOIL); }
"water"        { return token(TokenType.WATER); }
"add"          { return token(TokenType.ADD); }
"flour"        { return token(TokenType.FLOUR); }
"stir"         { return token(TokenType.STIR); }
"press"        { return token(TokenType.PRESS); }
"turn"         { return token(TokenType.TURN); }
"cook"         { return token(TokenType.COOK); }
"check"        { return token(TokenType.CHECK); }
"consistency"  { return token(TokenType.CONSISTENCY); }
"shape"        { return token(TokenType.SHAPE); }
"serve"        { return token(TokenType.SERVE); }
"ugali"        { return token(TokenType.UGALI); }
"cups"         { return token(TokenType.CUPS); }
"minutes"      { return token(TokenType.MINUTES); }

/* 2. Integer literal: keep the numeric VALUE as the attribute */
{INTEGER}      { try {
                     return token(TokenType.NUMBER, Integer.parseInt(yytext()));
                 } catch (NumberFormatException e) {
                     lexError("integer too large '" + yytext() + "'");
                 } }

/* 3. Identifier */
{ID}           { return token(TokenType.ID); }

/* 4. Delimiter */
";"            { return token(TokenType.SEMICOLON); }

/* 5. Skipped: no return, so scanning simply continues */
{WS}           { /* ignore */ }
{COMMENT}      { /* ignore */ }
"/*"           { commentStartLine = yyline + 1;
                 commentStartColumn = yycolumn + 1;
                 yybegin(MULTILINE_COMMENT);
               }

/* Consume all comment contents, stopping only at the closing delimiter. */
<MULTILINE_COMMENT> "*/"  { yybegin(YYINITIAL); }
<MULTILINE_COMMENT> [^*]+ { /* ignore */ }
<MULTILINE_COMMENT> "*"  { /* ignore */ }
<MULTILINE_COMMENT> <<EOF>> {
                 lexErrorAt("unterminated multiline comment",
                     commentStartLine, commentStartColumn);
                 yybegin(YYINITIAL);
                 return new Token(TokenType.EOF, "", null,
                     commentStartLine, commentStartColumn);
               }

/* 6. Catch-all, MUST be last */
[^]            { lexError("illegal character '" + yytext() + "'"); }