# NeetCode Strings — Daily Swift Learning Log

Tracks which NeetCode string-pattern problems already have a Swift solution
in this repo, so the daily session picks the next uncovered problem instead
of restarting from "Day 1" every time.

## Already solved in `swift/` (verified in repo, no action needed)

- 242. Valid Anagram
- 49. Group Anagrams
- 125. Valid Palindrome
- 5. Longest Palindromic Substring
- 3. Longest Substring Without Repeating Characters
- 424. Longest Repeating Character Replacement
- 76. Minimum Window Substring
- 20. Valid Parentheses
- 344. Reverse String
- 205. Isomorphic Strings
- 271. Encode and Decode Strings
- 43. Multiply Strings
- 58. Length of Last Word
- 179. Largest Number
- 392. Is Subsequence

## Covered by this log (date — problem — pattern)

- 2026-09-16 — 567. Permutation in String — Sliding Window (fixed-size window + frequency array)

## Queued next (NeetCode150/blind75 string-heavy, missing Swift solution)

1. 647. Palindromic Substrings — expand-around-center / 1-D DP
2. 14. Longest Common Prefix — Arrays & Hashing
3. 680. Valid Palindrome II — Two Pointers
4. 290. Word Pattern — Arrays & Hashing
5. 8. String to Integer (atoi) — Math & Geometry / parsing
6. 6. Zigzag Conversion — Math & Geometry
7. 28. Find the Index of the First Occurrence in a String — Two Pointers / string matching
8. 459. Repeated Substring Pattern — String matching

## Why this file exists

Past scheduled runs of this learning routine each worked on a fresh,
disposable git branch that was never merged, so nothing persisted between
days — most sessions independently redid "Day 1" (Valid Anagram or Longest
Palindromic Substring), both of which were already solved in `swift/`.
Keep this file up to date (and merged to `main`) so the next run can read
it and continue instead of repeating.
