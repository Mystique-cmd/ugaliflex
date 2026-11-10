---

### 2. File 5: `docs/lexical-vs-syntax.md` (Lexical Analysis vs. Syntax Analysis)

```markdown
# Lexical Analysis vs. Syntax Analysis in the UPL Compiler

## Introduction
The frontend of the Ugali Preparation Language (UPL) compiler is split into two foundational phases: **Lexical Analysis (Scanning)** and **Syntax Analysis (Parsing)**. While both handle the source code text before code generation or interpretation, their responsibilities, mechanisms, and error domains are distinct.

---

## Comparison Table

| Feature            | Lexical Analysis (Scanner - JFlex)                                                | Syntax Analysis (Parser - CUP/Java)                                                   |
| :----------------- | :-------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------ |
| **Input**          | Raw source code character stream (`.upl` files)                                   | Stream of discrete tokens produced by the lexer                                       |
| **Output**         | A stream of categorized `Token` objects (e.g., `KEYWORD`, `IDENTIFIER`, `NUMBER`) | Abstract Syntax Tree (AST) or parse tree                                              |
| **Core Theory**    | Regular Expressions and Finite Automata (DFA/NFA)                                 | Context-Free Grammars (CFG) and Pushdown Automata                                     |
| **Error Handling** | Catches illegal characters (e.g., `@`, `#`)                                       | Catches structural or grammatical errors (e.g., missing semicolons, unmatched blocks) |
| **Scope of View**  | Operates locally (character by character, with regex matching)                    | Operates structurally (token by token, looking at grammar rules and hierarchies)      |

---

## How They Work Together

1. The **Lexer** strips away whitespace, ignores comments, and groups raw characters into meaningful lexical tokens.
2. The **Parser** receives this token stream sequentially and checks whether the sequence conforms to the grammar rules defined for UPL instructions (e.g., ensuring a `PREPARE` statement is properly structured).
