/**
 * Question Link: https://leetcode.com/problems/valid-palindrome/
 *
 * Daily NeetCode String Series — Day 1
 * Topic: Two Pointers on Strings
 */

struct ValidPalindrome {

    /// Approach 1 — Modern/Functional Swift.
    /// Uses Character's built-in `isLetter`/`isNumber` predicates instead of a
    /// hand-rolled `isAlphanumeric` extension, plus `filter`, `lowercased`,
    /// and `reversed` from the standard library.
    /// Time: O(n)   Space: O(n) (builds a cleaned copy of the string)
    func isPalindrome(_ s: String) -> Bool {
        let cleaned = s.filter { $0.isLetter || $0.isNumber }.lowercased()
        return cleaned == String(cleaned.reversed())
    }

    /// Approach 2 — Two Pointer (optimal space).
    /// Same idea, but walks inward from both ends of the string without
    /// allocating a second cleaned string.
    /// Time: O(n)   Space: O(1) extra (ignoring the Array(s) staging copy,
    /// which is needed because String is not a random-access collection)
    func isPalindromeTwoPointer(_ s: String) -> Bool {
        let chars = Array(s)
        var left = 0
        var right = chars.count - 1

        while left < right {
            while left < right, !(chars[left].isLetter || chars[left].isNumber) {
                left += 1
            }
            while left < right, !(chars[right].isLetter || chars[right].isNumber) {
                right -= 1
            }
            guard chars[left].lowercased() == chars[right].lowercased() else {
                return false
            }
            left += 1
            right -= 1
        }
        return true
    }
}
