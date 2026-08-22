# NeetCode String Study Log (Swift)

Daily log for the recurring "learn algorithms through NeetCode string
problems" routine. Each entry records what was taught, which pattern it
drills, and what's queued up next so the next run doesn't repeat itself.

## Already covered (existing solutions in this folder before this routine started)

| # | Problem | Pattern |
|---|---------|---------|
| 242 | Valid Anagram | Hash map frequency count |
| 49 | Group Anagrams | Hash map + sorted/canonical key |
| 125 | Valid Palindrome | Two pointers |
| 3 | Longest Substring Without Repeating Characters | Sliding window |
| 424 | Longest Repeating Character Replacement | Sliding window |
| 76 | Minimum Window Substring | Sliding window |
| 271 | Encode and Decode Strings | Design / length-prefix encoding |
| 205 | Isomorphic Strings | Hash map bijection |
| 344 | Reverse String | Two pointers |
| 43 | Multiply Strings | Simulated grade-school multiplication |
| 131 | Palindrome Partitioning | Backtracking + palindrome check |
| 9 | Palindrome Number | Two pointers / math |

## Routine log

### 2026-08-22 — Problem 5: Longest Palindromic Substring
- **Pattern:** Two Pointers — Expand Around Center
- **File:** `swift/0005-longest-palindromic-substring.swift`
- **Why this one:** it's the natural next problem after Valid Palindrome —
  same "match from the edges inward" idea, but now applied at every
  possible center to find the best palindrome rather than checking one
  fixed string.
- **Complexity:** O(n^2) time, O(n) space (character buffer).

### Up next
- **647 — Palindromic Substrings**: same Expand Around Center pattern,
  but instead of tracking the single longest palindrome, we count *every*
  palindromic substring. Good immediate follow-up to reinforce today's
  pattern before moving to something new.
- After that: consider Manacher's Algorithm (O(n)) as an "advanced" pass
  on problem 5, and 8 (String to Integer/atoi) or 14 (Longest Common
  Prefix) for a change of pattern (parsing / prefix comparison).
