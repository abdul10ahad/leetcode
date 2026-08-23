/**
 * Question Link: https://leetcode.com/problems/valid-anagram/
 *
 * Pattern: Frequency Counting (Hash Map)
 * Time:  O(n)  — one pass over each string to build/compare counts
 * Space: O(1)  — at most 26 lowercase-letter keys, independent of n
 */

class ValidAnagram {

    /// Modern, idiomatic approach: build a [Character: Int] frequency table with
    /// `reduce(into:)` for each string, then let `Dictionary`'s synthesized
    /// `Equatable` conformance compare them in one shot.
    func isAnagram(_ s: String, _ t: String) -> Bool {
        guard s.count == t.count else { return false }

        let countS = s.reduce(into: [Character: Int]()) { counts, char in
            counts[char, default: 0] += 1
        }
        let countT = t.reduce(into: [Character: Int]()) { counts, char in
            counts[char, default: 0] += 1
        }

        return countS == countT
    }

    /// Alternative: sort both strings' characters — if they're anagrams, the
    /// sorted sequences are identical. Simple to read, but O(n log n).
    func isAnagramByLengthAndSortCheck(_ s: String, _ t: String) -> Bool {

        // if the String lengths don't match, then they cannot be anagrams of each other
        guard s.count == t.count else { return false }

        // sorting the String Characters puts them in the same order, which allows us to check equality
        guard s.sorted() == t.sorted() else { return false }

        // if both guards succeed, then we have an anagram
        return true
    }
}
