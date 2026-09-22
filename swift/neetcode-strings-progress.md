# NeetCode String Problems — Swift Learning Log

Daily tracker for the "learn algorithms/patterns via NeetCode string problems"
routine. This file is the single canonical log — earlier runs of this routine
created several differently-named logs (`STRING_PROBLEMS_LOG.md`,
`NEETCODE_STRINGS_TRACKER.md`, `neetcode-strings-log/README.md`, etc.) on
branches that were never merged into `main`, so none of them persisted.
Going forward, update *this* file each day instead of creating a new one.

## Problems covered so far

Collected from `main` plus every prior `claude/ecstatic-goldberg-*` branch
(most of those branches are still unmerged — see note at the bottom).

| # | Problem | Pattern | Swift file |
|---|---------|---------|------------|
| 3 | Longest Substring Without Repeating Characters | Sliding Window | `swift/0003-longest-substring-without-repeating-characters.swift` |
| 5 | Longest Palindromic Substring | Expand Around Center | `swift/0005-longest-palindromic-substring.swift` |
| 14 | Longest Common Prefix | String Scan | `swift/0014-longest-common-prefix.swift` |
| 43 | Multiply Strings | Simulation | `swift/0043-multiply-strings.swift` |
| 49 | Group Anagrams | Hashing | `swift/0049-group-anagrams.swift` |
| 76 | Minimum Window Substring | Sliding Window | `swift/0076-minimum-window-substring.swift` |
| 125 | Valid Palindrome | Two Pointers | `swift/0125-valid-palindrome.swift` |
| 205 | Isomorphic Strings | Hashing | `swift/0205-isomorphic-strings.swift` |
| 242 | Valid Anagram | Hashing | `swift/0242-valid-anagram.swift` |
| 271 | Encode and Decode Strings | Design | `swift/0271-encode-and-decode-strings.swift` |
| 424 | Longest Repeating Character Replacement | Sliding Window | `swift/0424-longest-repeating-character-replacement.swift` |
| 567 | Permutation in String | Sliding Window | `swift/0567-permutation-in-string.swift` |
| 647 | Palindromic Substrings | Expand Around Center | `swift/0647-palindromic-substrings.swift` |
| 929 | Unique Email Addresses | String Parsing | `swift/0929-unique-email-addresses.swift` |
| **680** | **Valid Palindrome II** | **Two Pointers (Greedy)** | `swift/0680-valid-palindrome-ii.swift` |

## Suggested next problems (not yet covered)

- 28. Find the Index of the First Occurrence in a String (strStr / substring search)
- 8. String to Integer (atoi)
- 151. Reverse Words in a String
- 383. Ransom Note
- 409. Longest Palindrome
- 387. First Unique Character in a String
- 459. Repeated Substring Pattern

## ⚠️ Housekeeping note (found 2026-09-22)

There are **~55 `claude/ecstatic-goldberg-*` branches** on `origin`, one per
prior day of this routine, and almost none of them are merged into `main` —
each day's lesson has been landing on its own orphan branch instead of
accumulating. Worth deciding whether to merge the useful ones (dedup first —
several branches solved the same problem, e.g. 0242 and 0049 exist 2-3
times) or just prune the stale branches and keep this log as the source of
truth going forward.
