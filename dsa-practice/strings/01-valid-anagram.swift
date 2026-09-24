// 242. Valid Anagram
// https://leetcode.com/problems/valid-anagram/
//
// Pattern: Hashing / Character Frequency Count
// Time:  O(n)
// Space: O(1) — bounded by the alphabet size (26 lowercase letters)

func isAnagram(_ s: String, _ t: String) -> Bool {
    guard s.count == t.count else { return false }

    var counts: [Character: Int] = [:]

    for char in s {
        counts[char, default: 0] += 1
    }

    for char in t {
        guard let remaining = counts[char], remaining > 0 else { return false }
        counts[char] = remaining - 1
    }

    return true
}

// Alternative: sort-and-compare. Simpler to read, but O(n log n) instead of O(n).
func isAnagramBySorting(_ s: String, _ t: String) -> Bool {
    s.count == t.count && s.sorted() == t.sorted()
}

// --- quick manual checks ---
assert(isAnagram("anagram", "nagaram") == true)
assert(isAnagram("rat", "car") == false)
assert(isAnagram("a", "ab") == false)
assert(isAnagramBySorting("anagram", "nagaram") == true)
assert(isAnagramBySorting("rat", "car") == false)
