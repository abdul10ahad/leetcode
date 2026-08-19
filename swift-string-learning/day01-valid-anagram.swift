/// NeetCode Strings Track — Day 1
/// LeetCode 242 — Valid Anagram
/// https://leetcode.com/problems/valid-anagram/
///
/// Written for the "learn algorithms & patterns" daily routine.
/// Pattern: Hashing / frequency counting.

struct Solution {

    /// Modern-Swift, single-pass frequency count.
    /// Time:  O(n)  — one pass over both strings (they're equal length)
    /// Space: O(k)  — k = number of distinct characters (<= 26 for lowercase-English)
    func isAnagram(_ s: String, _ t: String) -> Bool {
        // Different lengths can never be anagrams — cheap early exit
        // before we do any real work.
        guard s.count == t.count else { return false }

        // `zip` walks both strings together; `reduce(into:)` builds the
        // frequency table in one fold instead of two separate loops.
        // +1 for every character seen in `s`, -1 for every character seen in `t`.
        let counts = zip(s, t).reduce(into: [Character: Int]()) { table, pair in
            table[pair.0, default: 0] += 1
            table[pair.1, default: 0] -= 1
        }

        // Anagrams cancel every entry back down to exactly zero.
        return counts.values.allSatisfy { $0 == 0 }
    }

    /// Simplest possible correct solution — great for interviews when you
    /// want to state the brute-force approach first, worse asymptotically.
    /// Time: O(n log n) because of the two sorts. Space: O(n).
    func isAnagramBySorting(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }
        return s.sorted() == t.sorted()
    }
}

// MARK: - Quick sanity checks
let sol = Solution()
assert(sol.isAnagram("anagram", "nagaram") == true)
assert(sol.isAnagram("rat", "car") == false)
assert(sol.isAnagramBySorting("anagram", "nagaram") == true)
