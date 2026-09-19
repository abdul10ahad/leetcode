/**
 * Question Link: https://leetcode.com/problems/longest-common-prefix/
 */

class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        let charRows = strs.map { Array($0) }

        guard let shortest = charRows.min(by: { $0.count < $1.count }) else {
            return ""
        }

        for i in shortest.indices {
            let candidate = shortest[i]
            if charRows.contains(where: { $0[i] != candidate }) {
                return String(shortest[0..<i])
            }
        }

        return String(shortest)
    }
}
