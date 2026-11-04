package lexer;

import java.io.FileReader;
import lexer.tokens.Token;
import lexer.tokens.TokenType;

public class Main {
    public static void main(String[] args) throws Exception {
        if (args.length != 1) {
            System.err.println("Usage: java Main <input-file>");
            return;
        }

        UgaliLexer lexer = new UgaliLexer(new FileReader(args[0]));
        Token t;
        while ((t = lexer.nextToken()).type != TokenType.EOF) {
            System.out.println(t);
        }
    }
}