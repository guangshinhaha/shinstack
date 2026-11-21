---
name: break-ui
description: "Stress-test a UI with realistic worst-case data: long and non-Latin names, missing fields, counts of 0 and 1, huge lists. Renders both datasets behind a toggle and reports what broke. Use for /shinstack:break-ui, 'stress-test this screen', 'try the worst case', or 'what edge cases break this'."
---

# break-ui

A UI built on kind demo data ("Jane Doe, 12 members") looks right and fails on real names. Take the realistic worst case for every value it renders, show both datasets behind a toggle, and report what broke. Report only; fix when asked. Idea and failure table adapted from [emilkowalski/skills](https://github.com/emilkowalski/skills) `break-ui` (MIT).

## Rules
1. **Plausible or schema-backed, never random.** Each value is a real naming pattern or the actual limit from the schema, column, API type or `maxLength`. No limit found is itself a finding. A 5,000-character name proves nothing.
2. **Change the data, not the component.** Break it through the fixture, mock or props. Never hand-edit markup or CSS to cause a break.
3. **Mix the failures across rows.** Row 1 long name, row 2 long email, row 3 one-letter name, as real data does.
4. **Synthetic data only.** Never real student, staff or citizen data (PDPA), even to "see a real case".
5. **The toggle is dev-only.** Never shipped.
6. **A finding survives only if a run shows it** (same bar as `interrogate`). Screenshot or read the rendered result; mark anything inferred from CSS as inferred.

## Steps
1. **Map the surface.** List every rendered value with its source, type and limit: names, emails, counts in headers, timestamps, badge and button text from data, avatars, tooltips, and the list's length itself.
2. **Build the worst case** next to the demo fixture, same shape. Cover text, numbers, collections and media from the catalog below, plus the non-dataset cases: **empty**, **one** (every count at exactly 1), **huge** (1,000+ rows if unpaginated).
3. **Wire the toggle**: a plain segmented control, `Demo / Worst case / Empty / One / 1,000 rows`, swapping data at the fixture boundary; a `?data=worst` param works and survives reload. No project: one self-contained HTML file.
4. **Break it.** Check at the component's real container width, at 320px, at the widest layout, at 200% zoom, and in dark mode or RTL if supported.
5. **Report and stop.**

## Catalog
- **Names (use all that apply):** long Chinese (`欧阳明轩`), Tamil (`கார்த்திகேயன் சுப்பிரமணியம்`), Malay patronymic (`Nur Aisyah binti Mohd Abdul Rahman`), Indian `s/o` and `d/o` (`Rajendran s/o Krishnasamy`), a single name (`Sukarno`), one letter, a surname-first pattern, an emoji or accent first character.
- **Org text:** a long agency or school name (`Ministry of ... Statutory Board for ...`), a long role title, a long translated button label.
- **Identifiers:** an email with a long domain, a URL with no break points, a file name differing only at the end.
- **Numbers:** 0, 1, 1,284, a million, null, negative.
- **Collections:** empty, one, 1,000+.
- **Media:** missing avatar, a broken image URL, a very wide or tall image.

## Failure signatures
| What you see | Cause | Fix |
|---|---|---|
| Avatar squished to an oval | flex child shrinks | `flex-shrink: 0` |
| Text overflows its box | flex or grid child `min-width: auto` | `min-width: 0` (`minmax(0, 1fr)`) |
| Email or URL runs past the edge | no break points | `overflow-wrap: anywhere` |
| Trailing menu or button pushed off | middle content took the space | `min-width: 0` on middle, `flex-shrink: 0` on action |
| Badge wraps to two lines | badge may shrink | `white-space: nowrap; flex-shrink: 0` |
| Wrong initials, or `�` | `name.split(' ')[0][0]` | grapheme clusters (`Intl.Segmenter`), skip suffixes, icon fallback |
| Orphan `—` where a field was missing | placeholder always rendered | omit the line or reserve the height on purpose |
| "1 members" | hardcoded plural | `Intl.PluralRules` |
| `NaN`, `undefined`, `1284` | raw number | `Intl.NumberFormat`, guard null |
| Tamil or Thai clipped top or bottom | tight `line-height` with `overflow: hidden` | looser line height, no clipping on text |
| Boxes (`□`) or a mismatched font for Chinese or Tamil | font lacks the glyphs | font stack with script fallbacks |
| Ellipsis with no way to read it | truncate only | `title` or tooltip, full value in a detail view |
| 1,000 rows stutter | every row rendered | virtualize or paginate |

**Truncate, wrap or clamp per field:** wrap what identifies (names), truncate the end of secondary text, truncate the middle where items differ at the end (files, emails), clamp card previews, never truncate numbers, amounts or dates.

## Reply
A table, worst first: `# | Severity | Field | Worst-case value | What happens | Fix (file:line)`. Severity: **Broken** (unreadable, unreachable or wrong data), **Ugly** (readable but visibly wrong), **Fragile** (fine today, one realistic step from breaking). Then decisions for the user (truncate vs wrap, what empty shows), then what held up, then where the toggle lives. After "fix 1, 3" or "fix all": apply, then flip every state again, Demo included, and confirm. Keep the worst-case fixture as the regression test.
