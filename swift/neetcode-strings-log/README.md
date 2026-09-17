# NeetCode Strings — Daily Swift Practice Log

This is the canonical progress log for the "learn algorithms through NeetCode
string problems" daily routine. Check this file **before** picking the next
problem so the routine doesn't re-teach something already covered.

## ⚠️ Continuity issue — STILL open as of 2026-09-17, and still not fixed

This routine's scheduled sessions each get a **brand-new git branch off
`main`**, and none of them have ever been merged. Any progress log written
to one of those branches is invisible to the next day's session unless that
session happens to go digging through unmerged remote branches (which is
how this file keeps getting reconstructed, over and over).

This log was already written **twice before** — on 2026-09-01
(`claude/ecstatic-goldberg-upr4sw`) and again on 2026-09-09
(`claude/ecstatic-goldberg-wgg3d1`) — and both times it made **no
difference**: at least three more runs since 2026-09-09 re-taught a
problem this log already listed as covered (2026-09-10 and 2026-09-15 both
re-did Longest Palindromic Substring; 2026-09-16 re-did Permutation in
String). Writing this file has never once been sufficient, because a fresh
`main`-based branch never sees it.

Full picture, reconstructed from all 47 unmerged `ecstatic-goldberg-*`
branches found on the remote, spanning 2026-07-26 through 2026-09-16 (~2
months of daily runs):

| Problem | LeetCode # | Times taught |
|---|---|---|
| Longest Palindromic Substring | 5 | ~18 |
| Valid Anagram | 242 | ~13 |
| Valid Palindrome | 125 | 2 |
| Group Anagrams | 49 | 2 |
| Permutation in String | 567 | 2 |
| Longest Substring Without Repeating Characters | 3 | 2 |
| Longest Common Prefix | 14 | 2 |
| Reverse String | 344 | 1 |
| Palindromic Substrings | 647 | 1 |
| Longest Repeating Character Replacement | 424 | 1 |
| **Minimum Window Substring** | **76** | **1 (today, 2026-09-17)** |

In two months of daily sessions, the routine has effectively taught **10
distinct problems**, and spent the overwhelming majority of its runs
re-teaching the same 2 of them (Longest Palindromic Substring and Valid
Anagram account for ~31 of the 47 runs). This is not a learning
progression — it's the same lesson on repeat because nothing persists.

### This needs a decision from you (the user), not another log entry

Claude cannot merge branches or open a PR on its own initiative here —
repo policy requires you to ask for that explicitly, and a scheduled run
has no one to ask. Picking one of these actually fixes it:

1. **Ask me to open a PR merging this log (and ideally all the solved-once
   problems' files) into `main`**, so every future daily branch starts
   from a branch that already knows what was taught.
2. **Point the scheduled task at one single persistent branch** instead of
   a fresh throwaway branch per run.
3. **Store the tracker outside git entirely** — e.g. a note the scheduling
   system itself persists across runs, independent of branches.

Until one of these happens, expect the repetition to continue tomorrow.

## Day log

| Date | Problem | LeetCode # | Pattern | File |
|---|---|---|---|---|
| 2026-09-01 | Group Anagrams | 49 | Hashing / grouping | `0049-group-anagrams.swift` |
| 2026-09-09 | Longest Repeating Character Replacement | 424 | Sliding window (variable size) | `0424-longest-repeating-character-replacement.swift` |
| 2026-09-17 | Minimum Window Substring | 76 | Sliding window (variable size) + need/have counting | `0076-minimum-window-substring.swift` |

(Note: this table only ever lists what the *branch that has this file* was
taught, which is exactly the continuity problem described above. The
"times taught" table further up is the more complete picture, reconstructed
by scanning every unmerged branch.)

## Suggested next problems (not yet covered by this routine, per the full scan)

- Encode and Decode Strings (271) — design / string protocol
- Valid Parentheses (20) — stack
- String to Integer (atoi) (8) — careful parsing / edge cases
- Multiply Strings (43) — string math, no built-in bignum
- Reverse Words in a String (151) — in-place-style manipulation
- Decode String (394) — stack, nested structure
- Isomorphic Strings (205) — hashing / bijection

## Problems already covered at least once (avoid re-teaching unless revisiting on purpose)

Longest Palindromic Substring (5), Valid Anagram (242), Valid Palindrome
(125), Group Anagrams (49), Permutation in String (567), Longest Substring
Without Repeating Characters (3), Longest Common Prefix (14), Reverse
String (344), Palindromic Substrings (647), Longest Repeating Character
Replacement (424), Minimum Window Substring (76).
