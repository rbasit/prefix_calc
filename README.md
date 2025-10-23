# prefix_calc

# CS4337 Project 1 — Prefix Calculator (Racket)

## Files
- `main.rkt` — Prefix evaluator + REPL (interactive/batch), history, error handling.
- `mode.rkt` — Sets `prompt?` based on CLI flags (`-b`/`--batch` = batch mode).
- `devlog.md` — Session-by-session development journal.

## Requirements implemented
- Prefix ops: `+` (add), `*` (multiply), `/` (integer division), `-` (unary negation).
- History `$n` (1-based id, newest last, printed as float via `real->double-flonum`).
- Errors print as `Error: Invalid Expression`.
- Interactive mode (prompt) vs batch mode (no prompt); behavior identical otherwise.
- Rejects extra tokens (e.g., `+ 1 2 2` → error).

## How to run
Interactive:
```bash
racket main.rkt
