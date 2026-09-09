// LeetCode 424 - Longest Repeating Character Replacement
// Pattern: Sliding Window (variable size) + frequency counting
//
// You may change at most `k` characters in `s` to any other uppercase
// letter. Return the length of the longest substring that can be made to
// contain a single repeating letter after those changes.
//
// Key insight: a window [left, right] is "valid" exactly when
//   windowSize - mostFrequentLetterCountInWindow <= k
// i.e. the number of characters that are *not* the window's most common
// letter (the ones we'd have to repaint) is at most k.
//
// Modern-Swift notes:
// - `s` is fixed-width Character (Character is a grapheme cluster, so
//   indexing/counting through it is O(n) per access in the worst case).
//   Since the problem guarantees uppercase English letters (ASCII), we
//   drop into the `.utf8` view once with `Array(s.utf8)` to get a
//   `[UInt8]` we can index in O(1) — the recommended way to do byte-level
//   work on a Swift String instead of `Array(s)` of `Character`.
// - A 26-slot `[Int]` (one bucket per letter) replaces a `Dictionary`
//   for O(1) fixed-size counting with no hashing overhead.
final class Solution {
    func characterReplacement(_ s: String, _ k: Int) -> Int {
        let letters = Array(s.utf8)
        let base = UInt8(ascii: "A")
        var frequency = [Int](repeating: 0, count: 26)

        var left = 0
        var mostFrequentCount = 0
        var longest = 0

        for right in letters.indices {
            let rightIndex = Int(letters[right] - base)
            frequency[rightIndex] += 1
            mostFrequentCount = max(mostFrequentCount, frequency[rightIndex])

            let windowSize = right - left + 1
            if windowSize - mostFrequentCount > k {
                // Too many characters would need repainting — shrink from the left.
                let leftIndex = Int(letters[left] - base)
                frequency[leftIndex] -= 1
                left += 1
            }

            longest = max(longest, right - left + 1)
        }

        return longest
    }
}

// Why it's safe that `mostFrequentCount` can go "stale" after a shrink:
// once a window of length L was valid, matching or beating that L again
// later requires `mostFrequentCount` to grow to keep pace — a shrunk
// window can never silently produce a new, larger `longest` while
// carrying an outdated (too-high) count, because `longest` only ever
// records `right - left + 1` *after* the window has been brought back
// into a valid shape for this `right`. The loop invariant does the
// bookkeeping so we never need to rescan the window to find the true
// max frequency after a shrink — that's what keeps this O(n) instead
// of O(26n) or worse.
//
// Complexity: O(n) time, O(1) extra space (26 fixed buckets).
//
// Example trace: s = "AABABBA", k = 1
//   r=0 'A' -> freq[A]=1 window=1  (1-1=0<=1)               longest=1
//   r=1 'A' -> freq[A]=2 window=2  (2-2=0<=1)               longest=2
//   r=2 'B' -> freq[B]=1 window=3  (3-2=1<=1)               longest=3
//   r=3 'A' -> freq[A]=3 window=4  (4-3=1<=1)               longest=4
//   r=4 'B' -> freq[B]=2 window=5  (5-3=2>1) shrink -> l=1  longest=4
//   r=5 'B' -> freq[B]=3 window=5  (5-3=2>1) shrink -> l=2  longest=4
//   r=6 'A' -> freq[A]=2 window=5  (5-3=2>1) shrink -> l=3  longest=4
//   -> returns 4  (e.g. "ABBA" from index 3..6, or "AABA" from 0..3,
//      each needs only 1 repaint)
