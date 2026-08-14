class Solution {
    func checkInclusion(_ s1: String, _ s2: String) -> Bool {
        guard s1.count <= s2.count else { return false }

        let base = UInt8(Unicode.Scalar("a").value)
        func index(for byte: UInt8) -> Int { Int(byte - base) }

        let s1Bytes = Array(s1.utf8)
        let s2Bytes = Array(s2.utf8)
        let windowSize = s1Bytes.count

        var need = [Int](repeating: 0, count: 26)
        var window = [Int](repeating: 0, count: 26)
        for byte in s1Bytes {
            need[index(for: byte)] += 1
        }

        // How many of the 26 letter-buckets currently agree between need and window.
        // Starts at 24 (every letter except a's and b's zero-vs-need mismatch)... in
        // general: all buckets where need is already 0 count as "matching" up front.
        var matches = need.reduce(0) { $0 + ($1 == 0 ? 1 : 0) }

        for right in 0..<s2Bytes.count {
            let rIdx = index(for: s2Bytes[right])
            if window[rIdx] == need[rIdx] { matches -= 1 }
            window[rIdx] += 1
            if window[rIdx] == need[rIdx] { matches += 1 }

            let left = right - windowSize
            if left >= 0 {
                let lIdx = index(for: s2Bytes[left])
                if window[lIdx] == need[lIdx] { matches -= 1 }
                window[lIdx] -= 1
                if window[lIdx] == need[lIdx] { matches += 1 }
            }

            if matches == 26 { return true }
        }

        return false
    }
}
