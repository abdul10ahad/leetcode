/**
 * Question Link: https://leetcode.com/problems/permutation-in-string/
 *
 * Fixed-size sliding window + character-frequency counting.
 * Any permutation of s1 has the exact same letter counts as s1, so we slide
 * a window of length s1.count across s2 and compare frequency tables.
 */
class Solution {
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        let n1 = s1.utf8.count, n2 = s2.utf8.count
        guard n1 <= n2 else { return false }

        let sBytes = Array(s1.utf8)
        let tBytes = Array(s2.utf8)
        let aCode = UInt8(ascii: "a")

        var need = [Int](repeating: 0, count: 26)
        var window = [Int](repeating: 0, count: 26)

        for byte in sBytes {
            need[Int(byte - aCode)] += 1
        }

        for i in tBytes.indices {
            window[Int(tBytes[i] - aCode)] += 1

            if i >= n1 {
                window[Int(tBytes[i - n1] - aCode)] -= 1
            }

            if i >= n1 - 1 && need == window {
                return true
            }
        }

        return false
    }
}
