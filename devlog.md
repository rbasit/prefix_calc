2025-10-23
Thoughts

Starting Project 1 – Prefix Calculator in Racket. Needs interactive/batch modes, history ($n), robust error handling, exact print format, and no-space tokenization per spec.

Plan

Implement mode detection using the provided mode.rkt.

Write a tokenizer for prefix expressions.

Implement evaluator for +, *, / (integer), unary -, numbers, and $n.

Build a REPL loop that supports quit and history tracking.

Work done

Created repo and initial files: main.rkt, mode.rkt, devlog.md.

Commits

Initial commit – scaffold

2025-10-23
Thoughts since last session

Mode detection wired via mode.rkt (prompt?). Grader mentions interactive?, so aliasing makes sense.

Plan for this session

Export prompt? and also alias/provide interactive?.

Confirm interactive vs batch switching.

Work done

Added #lang racket to mode.rkt.

(provide prompt? interactive?) and (define interactive? prompt?).

Verified prompt shows only in interactive mode.

Tests & results

racket main.rkt → shows > prompt 

racket main.rkt -b / --batch → no prompt 

Problems & fixes

“provided identifier is not defined” for interactive? → fixed by defining alias.

Commits

mode: provide prompt? + interactive? alias

2025-10-23
Plan for this session

Implement recursive evaluator returning (value, remaining-tokens).

Add history (cons), $n lookup, REPL loop, error handling.

Work done

Implemented eval-expr for +, *, / (using quotient), unary -, numbers, $n.

REPL: reads, tokenizes, evaluates, prints id: value with real->double-flonum, pushes into history.

Tests & results

+ 2 3 → 1: 5.0 

/ 7 2 → 2: 3.0  (integer division)

- 8 → 3: -8.0 

$1 → 4: 5.0 

+ 1 2 2 → Error: Invalid Expression 

/ 5 0 → Error: Invalid Expression 

Problems & fixes

with-handlers bracket mismatch → fixed by placing [...] handler list before the body and closing correctly.

Commits

evaluator + REPL + error handling

fix with-handlers bracket placement

2025-10-23
Thoughts since last session

Spec allows no-space input like +*2$1+$2 1. Need a character-scanner tokenizer.

Plan

Replace whitespace-split with scanner for + * / -

Match printing rule exactly: display (real->double-flonum value).

Work done

Implemented no-space tokenizer (char-by-char scan).

Updated print-result to use display for the number per spec.

Tests & results

/ 7 2 → 1: 3.0 

10 → 2: 10.0 

+*2$1+$2 1 (after two history results) → 3: 17.0 

Problems & fixes

$2 referenced before it exists produced an error → expected per spec; documented.

Commits

tokenizer: support no-space inputs

print: display real->double-flonum per spec

2025-10-24
Plan

Push to GitHub; fix auth/remote issues as needed.

Work done

Set remote; resolved username mismatch; corrected URL.

Set up HTTPS with PAT; configured Keychain helper.

Resolved “fetch first” by git pull --rebase origin main (and --allow-unrelated-histories when necessary).

When appropriate, used git push --force-with-lease to replace trivial remote README commits.

Added .gitignore and removed .DS_Store from tracking.

Problems & fixes

Auth errors → generated PAT with repo scope; cached with osxkeychain.

Repo not found → fixed owner in remote URL.

Non fast-forward → rebased then pushed.

Local junk (.DS_Store) → added .gitignore, removed from index.

Commits

.gitignore + remove .DS_Store

docs: README draft

2025-10-24
Plan

Final verification against spec. Batch-only output; error format; extra-token rejection.

Tests & results

Interactive

+ 2 3 → 1: 5.0 

* $1 4 → 2: 20.0 

- $2 → 3: -20.0 

/ 7 2 → 4: 3.0 

+*2$1+$2 1 (no spaces) with $1=3, $2=10 → …: 17.0 

$99 with smaller history → Error: Invalid Expression 

+ 1 2 2 → Error: Invalid Expression 

/ 5 0 → Error: Invalid Expression 

quit exits 

Batch (no prompts)
Input:

+ 2 3
* $1 5
/ 9 4
+ 1
/ 5 0


Output:

1: 5.0
2: 25.0
3: 2.0
Error: Invalid Expression
Error: Invalid Expression




Problems & fixes

None — behavior matches spec.

Next session goals

Finalize README, tag v1.0, create submission ZIP.

Commits

verification: tests pass interactive & batch

README polish with examples

2025-10-24
Plan

Package submission.

Work done

Created prefix_calc.zip containing source, devlog, README, .gitignore.

Ready to submit

Interactive prompt vs batch-only output 

History $n (1-based), errors on out-of-range 

Integer division via quotient, printed with real->double-flonum 

No space tokenization supported 

Error format: Error: Invalid Expression 

Extra tokens rejected 

Commits

prepare submission zip