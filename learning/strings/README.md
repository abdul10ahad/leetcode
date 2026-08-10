# NeetCode Strings — Daily Learning Log

This log exists because this routine has been running once a day since
**2026-07-12** and, on inspection, every single run created a brand-new
throwaway branch off `main`, never merged, with no shared memory of what the
previous day covered. As a result the "curriculum" reset to "Day 1" roughly
30 times in a row instead of progressing:

| Topic covered | Approx. # of times repeated |
|---|---|
| Longest Palindromic Substring (LC 5) | ~14 |
| Valid Anagram (LC 242) | ~9 |
| Valid Palindrome (LC 125) | 2 |
| Longest Common Prefix (LC 14) | 1 |
| Palindromic Substrings / Permutation in String (code only, no lesson) | 1 each |

None of those branches were ever merged into `main`, so there was never a
single place the next day's run (or the user) could read to know what came
before. This file is that place, starting today.

## How to keep this going

For this to actually progress day over day, one of these needs to happen:
1. Merge each day's branch (or just this log file) back into `main` — the
   next day's run reads this file before picking a topic.
2. Point the schedule at a single long-lived branch instead of a fresh one
   per run.
3. Deliver lessons purely via the scheduled push notification / chat and
   drop the git-persistence idea entirely, since it hasn't been working.

## Progress

| # | Date | Problem | Pattern | Status |
|---|------|---------|---------|--------|
| 1 | 2026-08-10 | [Longest Substring Without Repeating Characters (LC 3)](./2026-08-10-longest-substring-without-repeating-characters.md) | Sliding Window | ✅ |

Next up (not yet covered by any prior run): Group Anagrams (49), Valid
Parentheses (20), Longest Repeating Character Replacement (424), Minimum
Window Substring (76), Encode and Decode Strings (271).
