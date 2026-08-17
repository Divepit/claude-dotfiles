---
name: scientific-writing
description: Rules for writing scientific manuscript text (papers, reports, theses). Use WHENEVER prose is being written into a manuscript — "let's write", "add text to the section", "draft the introduction", filling any section of a paper — BEFORE writing the first sentence. Companion to publication-data-representation (its sourcing gates apply to text too).
---

# Scientific Writing

Manuscript text is a data representation in prose form: every sentence carries
claims, and every claim needs the same sourcing discipline as a figure box.
The user's career depends on this — treat it as career-critical.

## 1. The three-class sentence law (ABSOLUTE)

Every sentence must be exactly one of:

1. **Textbook knowledge** — uncontroversial, found in standard textbooks,
   no citation needed (e.g., "an EKF fuses a prediction step with measurement
   updates"). When in doubt, it is NOT textbook knowledge — cite or cut.
2. **Sourced** — carries a citation to a document in hand. Cite EVERY such
   sentence individually; never let one citation silently "cover" following
   sentences.
3. **Derived** — computed by us from stated inputs. Say so explicitly in the
   text ("derived from …"), and keep the calculation reproducible (in the
   paper, an appendix, or the project notes).

A sentence that fits none of the three classes does not ship. Before moving
on, walk the paragraph sentence-by-sentence and assign each its class.

**Exception: roadmap/scope sentences.** Sentences that describe what THIS
paper or section does ("This section reviews...", "Section IV compares...")
are authorial statements about the document, not claims about the world.
They take no citation and no \srcnote. Keep them strictly self-referential:
the moment such a sentence asserts something about the world ("no flight-proven
option exists"), it is a normal claim and falls back under the three-class law.

## 2. No plagiarism — restate, never copy

- Never copy sentences or distinctive multi-word phrasing from sources;
  restate facts in your own words. Short standard technical terms
  ("extended Kalman filter", "cross-track position error") and factual
  values/part names are fine — sentence ARCHITECTURE is not.
- **Patchwriting is plagiarism too**: keeping the source's sentence skeleton,
  clause order, or distinctive enumerations while swapping synonyms
  ("detect and track" → "find and follow" in an otherwise parallel sentence)
  fails plagiarism screening — IEEE journals run submissions through
  detection software before review. The fix is never more synonyms: it is
  RESTRUCTURING around a different organizing principle (e.g., organize by
  the algorithm's predict/correct stages instead of the source's narrative
  order, attach sensors to roles instead of listing them).
- After writing, put your paragraph and the source passage side by side and
  compare sentence by sentence: for each, ask whether its skeleton, clause
  order, or any ≥4-word run (excluding technical terms/values) matches. Any
  match → restructure that sentence. This diff is mandatory, not optional.
- Direct quotes are allowed only as explicit quotations with quote marks and
  citation — rare in engineering papers.

## 3. Red source-verification annotations (until final submission)

The author must be able to manually verify every sentence. Define once in the
preamble:

```latex
% #1 = source + EXACT printed page (rendered CAPS); #2 = file path in the
% project/vault (lowercase — paths are case-sensitive — and line-breakable).
% Strip for submission: \renewcommand{\srcnote}[2]{}
\newcommand{\srcnote}[2]{{\color{red}\scriptsize\MakeUppercase{#1} \nolinkurl{#2}}}
\expandafter\def\expandafter\UrlBreaks\expandafter{\UrlBreaks\do\-\do\_}
```

- After each sourced sentence — or after a GROUP of consecutive sentences
  drawn from the same page/passage — append
  `\srcnote{[<FirstAuthor> et al. <year>, p.~<page>, Sec.~<N> ``<section title spelled out>'', find: ``<short verbatim phrase>'']}{<path/to/source.pdf>}`.
- Every locator must be self-explanatory to the author: NEVER a bare section
  number ("§3" means nothing to a reader) — always the section's actual title,
  and always a `find:` anchor: a short VERBATIM phrase from the source that
  the author can Ctrl-F on that page to land on the exact passage. Verify the
  anchor exists on that page before writing it.
- The page is the PRINTED page number the reader sees when opening the PDF.
  Verify it by per-page text extraction (`pdftotext -f N -l N … | grep`) for
  each key phrase — never from memory or from your own notes.
- The second argument is the source file's path in the author's folder
  structure (project-root-relative), so every red item is findable and
  checkable without searching. The `\UrlBreaks` line lets long hyphenated
  filenames wrap inside narrow columns instead of overflowing.
- Derived sentences get `\srcnote{[derived: <what from>]}{<notes/calc file>}`;
  textbook sentences get none (their absence is itself the class marker — so
  the three classes are visually distinguishable: red note = sourced/derived,
  no note + no cite = textbook).
- These annotations are for the author's fact-check pass; strip them (redefine
  to a no-op) only when the author says so.

## 4. Bibliography discipline

- Citation metadata (authors, exact title, venue, year, DOI) is verified
  against the actual document's title page before the bib entry is written —
  never from memory (a from-memory "(Nash et al.)" for a paper by Nayak et
  al. is a fabrication).
- Use the venue's required bibliography style (e.g., TAES ships `IEEEtaes.bst`).

## 5. Register and scope

- **Em-dashes are BANNED. Never use them** (`---`, `—`, `\textemdash`) in any
  manuscript text, figure, caption, or note — no exceptions. Restructure with
  commas, parentheses, colons, or separate sentences. En-dashes in numeric
  ranges (`pp. 13--14`) are fine.
- Plain, direct sentences; paper-level but not pompous. Explain a term the
  first time it appears. Prefer short sentences carrying one claim each —
  that is what makes per-sentence classing and citing possible.
- **Author's hardware-description style** (learned from edits, 2026-08-07):
  no framing or preamble sentences ("X's hardware consists of the
  following…") — open directly with the system name and the first device.
  One device per sentence, packing part number, key config, and geometry
  together. When one sentence mixes sources, split the citations mid-sentence
  at the clause each supports (part \cite{design}, flown rate \cite{flight}).
  Simple connectors ("Furthermore,") over enumerations. Mounting/assembly
  minutiae may be trimmed from text (the figure carries them). No redundant
  restatement: if adjacent sentences already imply a fact (e.g., ground-side
  selection sentences already show who did the work), the explicit
  restatement gets cut. State WHAT, never WHY: rationale sentences ("this
  limitation was deliberate…") get cut; only observable facts of what the
  system does/did. Spec attributes flow as words ("a rolling shutter color
  camera with a 4208x3120 resolution"), not parenthesized spec dumps.
- When trimming, re-check what the deleted sentence carried: definitions of
  abbreviations used later, and scope caveats (e.g., "design-phase candidate
  parts") die silently with it. After any edit pass, re-run the
  first-use-definition sweep and confirm every scope caveat still lives
  somewhere reader-visible.
- Completeness over length: include every relevant sourced fact the project
  holds for the subsection, then stop. Do not pad.
- Facts have a schema home in the document, like fields in a figure: don't
  smuggle another section's facts in (part numbers belong to Sensors, not
  Odometry; hosting belongs to Compute Architecture). If a fact has no home,
  raise it — don't park it.

## 6. Inherited gates (from publication-data-representation)

Full-read gate, per-field gap-checks before writing "not published",
deterministic-part-number rule for datasheet values, analogy/transfer scope,
and discuss-before-including-anything-unprovable all apply to prose exactly
as they do to figures. When text and a figure state the same fact, they must
agree word-for-word on the value and cite the same source.

## 7. Self-review checklist (before showing the author)

- [ ] Every sentence classed: textbook / sourced / derived — none unclassed
- [ ] Every sourced sentence has its own \cite AND a \srcnote with verified
      printed page
- [ ] No copied phrasing (diffed against the source passages)
- [ ] Bib entries verified against the documents' title pages
- [ ] Values identical to the corresponding figure/table and its source map
- [ ] Compiles; annotations render red CAPS; citations resolve (no [?])
