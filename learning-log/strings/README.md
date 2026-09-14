# NeetCode String Problems — Daily Learning Log

A personal curriculum for learning algorithms & coding patterns through NeetCode's
**string** problems, solved in Swift using modern language APIs. One problem is
solved per day; each entry gets a `.swift` file with a heavily-commented solution
plus a step-by-step explanation posted in chat.

This lives outside the per-language solution folders (`swift/`, `python/`, …) on
purpose, so it never collides with this repo's automated README-table generation
or the canonical NeetCode solutions — it's a separate personal study log.

## How to resume

Each future run: find the first unchecked box below, solve that problem, add
`NN-slug.swift` to this folder, check the box, and commit.

## Curriculum (ordered by pattern, easy → hard)

| # | Problem | Pattern | LeetCode | File | Status |
|---|---------|---------|----------|------|--------|
| 1 | Valid Anagram | Hashing / Frequency Count | [242](https://leetcode.com/problems/valid-anagram/) | [01-valid-anagram.swift](01-valid-anagram.swift) | ✅ |
| 2 | Valid Palindrome | Two Pointers | [125](https://leetcode.com/problems/valid-palindrome/) | | ⬜ |
| 3 | Longest Substring Without Repeating Characters | Sliding Window | [3](https://leetcode.com/problems/longest-substring-without-repeating-characters/) | | ⬜ |
| 4 | Longest Repeating Character Replacement | Sliding Window | [424](https://leetcode.com/problems/longest-repeating-character-replacement/) | | ⬜ |
| 5 | Permutation in String | Sliding Window | [567](https://leetcode.com/problems/permutation-in-string/) | | ⬜ |
| 6 | Minimum Window Substring | Sliding Window | [76](https://leetcode.com/problems/minimum-window-substring/) | | ⬜ |
| 7 | Valid Parentheses | Stack | [20](https://leetcode.com/problems/valid-parentheses/) | | ⬜ |
| 8 | Group Anagrams | Hashing | [49](https://leetcode.com/problems/group-anagrams/) | | ⬜ |
| 9 | Encode and Decode Strings | Design | [271](https://leetcode.com/problems/encode-and-decode-strings/) | | ⬜ |
| 10 | Isomorphic Strings | Hashing | [205](https://leetcode.com/problems/isomorphic-strings/) | | ⬜ |
| 11 | Word Pattern | Hashing | [290](https://leetcode.com/problems/word-pattern/) | | ⬜ |
| 12 | Longest Common Prefix | String Scan | [14](https://leetcode.com/problems/longest-common-prefix/) | | ⬜ |
| 13 | Generate Parentheses | Backtracking | [22](https://leetcode.com/problems/generate-parentheses/) | | ⬜ |
| 14 | Palindrome Partitioning | Backtracking | [131](https://leetcode.com/problems/palindrome-partitioning/) | | ⬜ |
| 15 | Decode String | Stack | [394](https://leetcode.com/problems/decode-string/) | | ⬜ |
| 16 | Find All Anagrams in a String | Sliding Window | [438](https://leetcode.com/problems/find-all-anagrams-in-a-string/) | | ⬜ |
| 17 | Reverse String | Two Pointers | [344](https://leetcode.com/problems/reverse-string/) | | ⬜ |
| 18 | Merge Strings Alternately | Two Pointers | [1768](https://leetcode.com/problems/merge-strings-alternately/) | | ⬜ |
| 19 | Removing Stars From a String | Stack | [2390](https://leetcode.com/problems/removing-stars-from-a-string/) | | ⬜ |
| 20 | Simplify Path | Stack | [71](https://leetcode.com/problems/simplify-path/) | | ⬜ |

## Progress notes

- **Day 1 (Valid Anagram)**: introduced the frequency-count / hashing pattern that
  underlies most later string problems (Group Anagrams, Find All Anagrams,
  Minimum Window Substring). Used `Dictionary(grouping:by:)` + `mapValues(\.count)`
  as the modern-Swift way to build a character histogram.
