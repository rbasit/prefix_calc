## [2025-10-23]
Starting Project 1 – Prefix Calculator

### Thoughts
The goal is to create a prefix expression evaluator in Racket. The calculator must handle interactive and batch modes, maintain history, and handle errors gracefully.

### Plan
- Implement mode detection using the provided mode.rkt
- Write parser to tokenize prefix expressions
- Implement evaluator (handles +, *, /, -, numbers, and $n history references)
- Build main REPL loop that supports quit and history tracking

## 2025-10-23 
### Thoughts so far
- Mode detection wired via `mode.rkt` (`prompt?`).

- ### Plan for this session
- Implement evaluator: +, *, /, -, numbers, $n.
- Add REPL loop, history, error handling.
