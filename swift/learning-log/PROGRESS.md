# NeetCode Swift String-Pattern Learning Log

This folder is a running, daily curriculum through NeetCode-style **string**
problems, solved in Swift with modern APIs. Each day adds one file named
`day-NN-<slug>.swift` containing a heavily-commented, step-by-step solution.
This file tracks what's been covered so the next session picks up where the
last one left off.

## Curriculum & status

| # | Problem | LeetCode # | Core pattern | Status |
|---|---------|-----------|--------------|--------|
| 1 | Valid Anagram | 242 | Hashing / frequency count | ✅ Day 1 (2026-09-07) |
| 2 | Valid Palindrome | 125 | Two pointers | ⬜ next |
| 3 | Longest Substring Without Repeating Characters | 3 | Sliding window | ⬜ |
| 4 | Longest Repeating Character Replacement | 424 | Sliding window | ⬜ |
| 5 | Minimum Window Substring | 76 | Sliding window | ⬜ |
| 6 | Group Anagrams | 49 | Hashing | ⬜ |
| 7 | Encode and Decode Strings | 271 | Design / parsing | ⬜ |
| 8 | Longest Palindromic Substring | 5 | Expand around center | ⬜ |
| 9 | Palindromic Substrings | 647 | Expand around center | ⬜ |
| 10 | Isomorphic Strings | 205 | Hashing (bijection) | ⬜ |
| 11 | Longest Common Prefix | 14 | Horizontal/vertical scan | ⬜ |
| 12 | String to Integer (atoi) | 8 | Parsing / state machine | ⬜ |
| 13 | Roman to Integer | 13 | Hashing / parsing | ⬜ |
| 14 | Multiply Strings | 43 | Simulation / big-number math | ⬜ |
| 15 | Reverse Words in a String | 151 | Two pointers / parsing | ⬜ |
| 16 | Word Break | 139 | DP + hashing | ⬜ |
| 17 | Palindrome Partitioning | 131 | Backtracking + DP | ⬜ |

## Next up

**Day 2 → Valid Palindrome (125), Two Pointers pattern.**

## How to resume

Each new day:
1. Open this file, find the first `⬜` row — that's today's problem.
2. Write `swift/learning-log/day-NN-<slug>.swift` with the solution + step-by-step
   comments explaining the reasoning (not just the code).
3. Explain the same walkthrough in chat / the daily notification.
4. Flip the row to `✅ Day NN (date)` and update "Next up".
5. Commit and push to the learning branch.
