# NeetCode Strings — Daily Learning Log

Personal tracker for the daily "learn algorithms/patterns through NeetCode
string problems" routine. Each entry: problem, pattern, and the Swift file
with the walkthrough.

> **Note on continuity:** this routine runs as a scheduled task that starts a
> brand-new disposable branch each day, and those branches are never merged
> back into `main`. That means the tracker below only reflects *this*
> branch's history — it does not (and currently cannot) see what earlier
> daily runs covered, so it will look thin even after weeks of daily runs.
> See the note at the bottom for what would fix this.

## Log

| Date       | Problem                                             | Pattern                      | File |
|------------|------------------------------------------------------|-------------------------------|------|
| 2026-09-11 | [14. Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix/) | Prefix folding / vertical scan | `swift/0014-longest-common-prefix.swift` |

## Recommendation

To make this routine actually cumulative, either:
1. Ask me to open a PR for each day's branch so it lands on `main` (then a
   future run can read this file from `main` before picking a problem), or
2. Point the schedule at a single long-lived branch instead of letting the
   harness mint a new one every day.

Without one of those, "daily progress" is really just "today's lesson" —
still useful for learning in the moment, but it won't accumulate into a
tidy list of what's been covered.
