package lexer.tokens;
public class Token {
    public final TokenType type;   // category, e.g. NUMBER
    public final String lexeme;    // actual text, e.g. "4"
    public final Object value;     // Integer for NUMBER, null for others
    public final int line;         // 1-based
    public final int column;       // 1-based

    public Token(TokenType type, String lexeme, Object value, int line, int column) {
        this.type = type;
        this.lexeme = lexeme;
        this.value = value;
        this.line = line;
        this.column = column;
    }

    // Prints NUMBER(4) for numbers, BOIL for everything else
    @Override
    public String toString() {
        return (value != null) ? type + "(" + value + ")" : type.toString();
    }
}