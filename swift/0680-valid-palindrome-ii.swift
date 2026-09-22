// 680. Valid Palindrome II
// https://leetcode.com/problems/valid-palindrome-ii/
//
// Pattern: Two Pointers (Greedy)
//
// Given a string s, return true if s can become a palindrome after
// deleting at most one character.
//
// Idea: walk inward from both ends like a normal palindrome check.
// The moment the characters at the two pointers disagree, we have one
// "free" deletion to spend — try skipping the left character OR the
// right character, and check whether either resulting substring reads
// as a plain palindrome. If neither does, no single deletion can save it.

final class Solution {
    func validPalindrome(_ s: String) -> Bool {
        let chars = Array(s)
        return isPalindrome(chars, 0, chars.count - 1, allowedDeletions: 1)
    }

    private func isPalindrome(_ chars: [Character], _ left: Int, _ right: Int, allowedDeletions: Int) -> Bool {
        var left = left
        var right = right
        while left < right {
            if chars[left] != chars[right] {
                guard allowedDeletions > 0 else { return false }
                return isPalindrome(chars, left + 1, right, allowedDeletions: allowedDeletions - 1) ||
                       isPalindrome(chars, left, right - 1, allowedDeletions: allowedDeletions - 1)
            }
            left += 1
            right -= 1
        }
        return true
    }
}

// MARK: - Modern-API variant using String.Index (no array copy)
//
// Same two-pointer idea, but walking the String's native indices instead
// of converting to [Character] first. Demonstrates String.Index navigation,
// which is the "correct" way to index Swift strings when you don't need
// O(1) random access.

final class SolutionStringIndex {
    func validPalindrome(_ s: String) -> Bool {
        isPalindrome(s, s.startIndex, s.index(before: s.endIndex), allowedDeletions: 1)
    }

    private func isPalindrome(_ s: String, _ left: String.Index, _ right: String.Index, allowedDeletions: Int) -> Bool {
        var left = left
        var right = right
        while left < right {
            if s[left] != s[right] {
                guard allowedDeletions > 0 else { return false }
                return isPalindrome(s, s.index(after: left), right, allowedDeletions: allowedDeletions - 1) ||
                       isPalindrome(s, left, s.index(before: right), allowedDeletions: allowedDeletions - 1)
            }
            left = s.index(after: left)
            right = s.index(before: right)
        }
        return true
    }
}
