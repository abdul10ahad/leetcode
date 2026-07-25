/**
 * Question Link: https://leetcode.com/problems/longest-common-prefix/
 */

class Solution {

    // Horizontal scan: shrink a running prefix until every string starts with it.
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard var prefix = strs.first else { return "" }

        for str in strs.dropFirst() {
            while !str.hasPrefix(prefix) {
                prefix.removeLast()
                if prefix.isEmpty { return "" }
            }
        }
        return prefix
    }

    // Same idea, written with modern Sequence APIs: zip two strings' Characters
    // together, keep pairing while they match, fold that over the whole array.
    func longestCommonPrefixFunctional(_ strs: [String]) -> String {
        guard let first = strs.first else { return "" }

        return strs.dropFirst().reduce(into: first) { prefix, current in
            prefix = String(zip(prefix, current).prefix(while: { $0.0 == $0.1 }).map(\.0))
        }
    }
}
