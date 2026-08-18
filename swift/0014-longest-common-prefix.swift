/**
 * Question Link: https://leetcode.com/problems/longest-common-prefix/
 *
 * Write a function to find the longest common prefix string amongst
 * an array of strings. If there is no common prefix, return "".
 */

import Foundation

class LongestCommonPrefix {

    /// Modern-Swift solution using `commonPrefix(with:)`.
    /// Time:  O(S) where S = total number of characters across all strings
    /// Space: O(1) extra (ignoring the result string)
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard var prefix = strs.first else { return "" }

        for str in strs.dropFirst() {
            // `commonPrefix(with:)` is a Foundation String API that returns
            // the longest shared prefix between two strings.
            prefix = prefix.commonPrefix(with: str)

            // Early exit: once the prefix is empty, it can only stay empty.
            if prefix.isEmpty { return "" }
        }

        return prefix
    }
}
