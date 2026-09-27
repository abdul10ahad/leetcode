/**
 * Question Link: https://leetcode.com/problems/longest-common-prefix/
 */

class LongestCommonPrefix {
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard let first = strs.first else { return "" }

        return strs.dropFirst().reduce(first) { prefix, next in
            String(zip(prefix, next).prefix(while: { $0 == $1 }).map(\.0))
        }
    }
}
