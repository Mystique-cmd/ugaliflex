package lexer.tokens;
public enum TokenType {
    // Reserved words
    PREPARE, INGREDIENTS, BOIL, WATER, ADD, FLOUR, STIR, PRESS, TURN,
    COOK, CHECK, CONSISTENCY, SHAPE, SERVE, UGALI, CUPS, MINUTES,

    // Other tokens
    NUMBER,
    ID,
    SEMICOLON,
    EOF
}