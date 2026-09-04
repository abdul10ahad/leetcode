class Solution {
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.count > 0 else { return 0 }
        let list = Array(s)
        var hs = Set<Character>()
        var l = 0
        var r = 0
        var mv = 0
        for r in 0..<s.count {
            while hs.contains(list[r]) {
                hs.remove(list[l])
                l += 1
            }
            hs.insert(list[r])
            mv = max(mv, r - l + 1)
        }
        return mv
    }

    /// Single-pass sliding window using modern Swift APIs.
    /// Instead of a Set + inner while-loop to shrink the window one step at a
    /// time, this keeps a dictionary of each character's last-seen index and
    /// jumps `left` straight past the duplicate in O(1), so every character
    /// is visited exactly once.
    func lengthOfLongestSubstringModern(_ s: String) -> Int {
        var lastSeenIndex: [Character: Int] = [:]
        var left = 0
        var longest = 0

        for (right, char) in s.enumerated() {
            if let previous = lastSeenIndex[char], previous >= left {
                left = previous + 1
            }
            lastSeenIndex[char] = right
            longest = max(longest, right - left + 1)
        }

        return longest
    }
}
