/**
 * Question Link: https://leetcode.com/problems/longest-common-prefix/
 *
 * Write a function to find the longest common prefix string amongst an array
 * of strings. If there is no common prefix, return "".
 */

class LongestCommonPrefix {

    /// Modern-Swift approach: fold `commonPrefix(with:)` across the array.
    /// `commonPrefix(with:)` is a StringProtocol API that walks two sequences
    /// together and hands back the shared leading run — exactly the
    /// primitive this problem asks us to implement by hand, so let the
    /// standard library do it and focus on the reduction.
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard let first = strs.first else { return "" }

        return strs.dropFirst().reduce(first) { prefix, next in
            prefix.isEmpty ? prefix : prefix.commonPrefix(with: next)
        }
    }

    /// Classic vertical-scanning approach, for comparison / interviews where
    /// you may be asked to not lean on a stdlib helper. Walks column by
    /// column (character index 0, then 1, then 2, ...) across every string
    /// at once, stopping at the first mismatch or the first string that
    /// runs out of characters.
    func longestCommonPrefixVerticalScan(_ strs: [String]) -> String {
        guard let first = strs.first else { return "" }
        let chars = strs.map { Array($0) }

        for (col, char) in chars[0].enumerated() {
            for word in chars.dropFirst() {
                if col >= word.count || word[col] != char {
                    return String(chars[0].prefix(col))
                }
            }
        }
        return first
    }
}
