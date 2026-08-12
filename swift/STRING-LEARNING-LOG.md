# NeetCode Strings — Swift Daily Learning Log

Tracks the daily "NeetCode string problems in Swift" lessons so future sessions
don't repeat a problem that's already been taught. Each day's automated run
lives on its own throwaway git branch (never merged), so this log is
reconstructed by scanning sibling `claude/*` branches in this repo for prior
lessons — if you're a future session reading this, do the same sanity check:

```
git branch -r | grep -E 'ecstatic-goldberg|epic-heisenberg|practical-lovelace'
git log main..<branch> --oneline   # per branch, to see what it added
```

## Covered so far (reconstructed from prior sessions)

| # | Problem | Pattern | Notes |
|---|---------|---------|-------|
| 242 | Valid Anagram | Hashing / frequency count | Taught multiple times (most common "day 1" pick before this log existed) |
| 125 | Valid Palindrome | Two pointers | |
| 3 | Longest Substring Without Repeating Characters | Sliding window | |
| 5 | Longest Palindromic Substring | Expand around center | Taught multiple times |
| 647 | Palindromic Substrings | Expand around center | |
| 567 | Permutation in String | Sliding window + frequency count | |

## Taught today

| Date | Problem | Pattern |
|------|---------|---------|
| 2026-08-12 | 49. Group Anagrams | Hashing with a canonical key (builds on Valid Anagram) |

## Suggested queue (not yet covered) — pull the next one from here

- 424. Longest Repeating Character Replacement (sliding window)
- 76. Minimum Window Substring (sliding window, hard)
- 20. Valid Parentheses (stack)
- 271. Encode and Decode Strings (design)
- 14. Longest Common Prefix (if present in repo)
- 28. Find the Index of the First Occurrence in a String

Pick top-to-bottom, skipping anything that shows up in "Covered so far" above.
