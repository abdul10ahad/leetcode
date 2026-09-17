// LeetCode 76 - Minimum Window Substring
// Pattern: Sliding Window (variable size) + "need vs have" frequency counting
//
// Given strings s and t, return the smallest substring of s that contains
// every character of t (including duplicates). Return "" if no such window
// exists.
//
// Key insight: grow a window over `s` with `right` until it contains
// everything `t` needs, then greedily shrink it from `left` while it's
// still valid, recording the smallest valid window seen. Each character
// only ever gets counted in and out of the window once, so the whole scan
// is O(|s| + |t|) even though it looks like nested loops.
//
// Modern-Swift notes:
// - `s` and `t` are ASCII letters (upper- and lowercase), so we drop into
//   `.utf8` once with `Array(s.utf8)` / `Array(t.utf8)` to get `[UInt8]`
//   we can index in O(1), instead of `Array(s)` of `Character` (grapheme
//   clusters, which are more expensive to index and compare here).
// - A 128-slot `[Int]` (covers the full ASCII range) replaces a
//   `Dictionary<Character, Int>` for O(1) fixed-size counting with no
//   hashing overhead — same trick as the 424 solution in this log, just
//   sized for mixed-case letters instead of 26 uppercase-only buckets.
// - The final answer is sliced with `String(decoding:as:)` directly on the
//   `[UInt8]` window, which is the recommended modern way to turn a byte
//   range back into a `String` without going through `Character` indices.
final class Solution {
    func minWindow(_ s: String, _ t: String) -> String {
        guard !s.isEmpty, !t.isEmpty, t.count <= s.count else { return "" }

        let sBytes = Array(s.utf8)
        let tBytes = Array(t.utf8)

        var need = [Int](repeating: 0, count: 128)
        for byte in tBytes {
            need[Int(byte)] += 1
        }
        // Number of *distinct* bytes the window still has to satisfy.
        let required = need.filter { $0 > 0 }.count

        var window = [Int](repeating: 0, count: 128)
        var formed = 0 // distinct bytes currently satisfied (window count >= need count)

        var left = 0
        var bestLength = Int.max
        var bestLeft = 0

        for right in sBytes.indices {
            let rightByte = Int(sBytes[right])
            window[rightByte] += 1
            if need[rightByte] > 0 && window[rightByte] == need[rightByte] {
                formed += 1
            }

            // Window already contains everything t needs — shrink greedily
            // from the left to find the tightest fit ending at `right`.
            while formed == required {
                if right - left + 1 < bestLength {
                    bestLength = right - left + 1
                    bestLeft = left
                }

                let leftByte = Int(sBytes[left])
                window[leftByte] -= 1
                if need[leftByte] > 0 && window[leftByte] < need[leftByte] {
                    formed -= 1
                }
                left += 1
            }
        }

        guard bestLength != Int.max else { return "" }
        return String(decoding: sBytes[bestLeft..<(bestLeft + bestLength)], as: UTF8.self)
    }
}

// Why `formed == required` (not `>=`) is enough to know the window is
// valid: `formed` only increments the moment a byte's window count *just
// reaches* its need count, and only decrements the moment shrinking drops
// it *just below* need again — so `formed` is always an exact count of
// "distinct bytes currently fully satisfied," never an overcount. Once it
// equals `required`, every byte t needs is present in at least the right
// quantity, by definition.
//
// Complexity: O(|s| + |t|) time — `right` and `left` each advance at most
// |s| times total, and building `need` is O(|t|). O(1) extra space (two
// fixed 128-slot arrays, independent of input size).
//
// Example trace: s = "ADOBECODEBANC" (indices 0-12), t = "ABC"
//   need = {A:1, B:1, C:1}, required = 3
//
//   right=5 ('C'): window first satisfies all 3 letters ("ADOBEC").
//     Shrink from left=0: window "ADOBEC" (len 6) is the first candidate,
//     bestLength=6. Dropping 'A' at left=0 breaks the window, so shrinking
//     stops there (left is now 1).
//   right=10 ('A'): window becomes valid again over "DOBECODEBA" (len 10,
//     not better). Shrinking walks left up through the non-t letters
//     D, O, then past a redundant 'B' (window still has enough B's) and
//     'E', landing on window "C...A" = s[5...10] = "CODEBA" (len 6, ties
//     but doesn't beat 6) before dropping the only 'C' breaks validity
//     (left is now 6).
//   right=12 ('C'): window valid again over s[6...12] = "ODEBANC" (len 7).
//     Shrinking walks left past 'O', 'D', 'E' (all non-t letters) to reach
//     s[9...12] = "BANC" (len 4) — the smallest window found — before
//     dropping the only 'B' breaks validity again.
//   No shorter valid window remains once `right` reaches the end of `s`.
//   -> returns "BANC"
