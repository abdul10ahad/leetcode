# NeetCode Strings — Daily Swift Practice Log

This is the canonical progress log for the "learn algorithms through NeetCode
string problems" daily routine. Earlier runs of this routine each started
from a fresh throwaway branch (never merged), so each one invented its own
differently-named log file and had no memory of previous days. This file
consolidates what was actually taught (reconstructed from those branches)
so future runs have one place to check before picking the next problem.

## ⚠️ Continuity issue found 2026-09-01

Between 2026-07-12 and 2026-08-28 this routine ran ~48 times, one branch per
day (`claude/practical-lovelace-*`, `claude/epic-heisenberg-*`,
`claude/ecstatic-goldberg-*`), none of them merged to `main`. Because each
run started fresh from `main`, none could see what a previous run had
taught, so the log file got reinvented under a different name almost every
time (`STRING_PROBLEMS_LOG.md`, `NEETCODE_STRINGS_LOG.md`,
`NEETCODE_STRING_PROGRESS.md`, `STRING_LEARNING_LOG.md`, `STRING-LEARNING-LOG.md`,
`STRING_STUDY_LOG.md`, `STRING_PATTERNS_PROGRESS.md`, `NEETCODE_STRINGS_TRACKER.md`,
`neetcode-strings-progress.md`, `neetcode-strings/PROGRESS.md`,
`neetcode-daily-string-practice/PROGRESS.md`, `string-learning-journal/README.md`).

Net effect: **Longest Palindromic Substring (LeetCode 5) was taught roughly
20 separate times**, while most other string patterns were touched once or
twice (or not at all). This file/branch will *also* be discarded and never
seen by tomorrow's run unless someone merges it into `main` — see the
recommendation at the bottom.

## Problems actually covered, July 12 – Aug 28 2026 (reconstructed from branch history)

| Problem | LeetCode # | Times taught | Dates |
|---|---|---|---|
| Longest Palindromic Substring | 5 | ~20 | Jul 12,13,14,16,17,19,22,24,26,27,28,30, Aug 6,11,13,16,17,20,22,26,28 |
| Valid Anagram | 242 | 6 | Jul 23, 29, Aug 15, 21, 23, 25, 27 |
| Longest Common Prefix | 14 | 2 | Jul 25, Aug 18 |
| Permutation in String | 567 | 2 | Aug 7, 14 |
| Palindromic Substrings | 647 | 1 | Aug 9 |
| Valid Palindrome | 125 | 1 | Aug 5 |
| Reverse String | 344 | 1 | Aug 24 |

## Day log (this canonical log, going forward)

| Date | Problem | LeetCode # | Pattern | File |
|---|---|---|---|---|
| 2026-09-01 | Group Anagrams | 49 | Hashing / grouping | `0049-group-anagrams.swift` |

## Suggested next problems (not yet covered by this routine)

- Longest Substring Without Repeating Characters (3) — sliding window
- Longest Repeating Character Replacement (424) — sliding window
- Minimum Window Substring (76) — sliding window, advanced
- Valid Parentheses (20) — stack
- Encode and Decode Strings (271) — design / string protocol
- String to Integer atoi (8) — careful parsing / edge cases
- Multiply Strings (43) — string math, no built-in bignum
- Reverse Words in a String (151) — in-place-style manipulation
- Decode String (394) — stack, nested structure

## Recommendation

The root cause is structural, not a one-off mistake: this routine's
scheduled sessions each get a brand-new branch off `main`, and none of the
~48 branches from the last 7 weeks were ever merged or turned into a PR. Any
progress log written to one of them is invisible to the next day's session.
To actually fix continuity, either:

1. Ask Claude to open (or merge) a PR that lands this log on `main`, so every
   future daily branch starts from a branch that already knows what was
   taught, or
2. Point the scheduled task at a single persistent branch instead of a fresh
   one per run.

Until one of those happens, expect the same repetition to continue.
