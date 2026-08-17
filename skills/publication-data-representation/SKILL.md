---
name: publication-data-representation
description: Rules for publication-grade representation of structured information — tables, figures, diagrams, lists, structured prose, slides. Use WHENEVER data or facts are being arranged for a reader in any deliverable (papers, reports, docs, READMEs), BEFORE writing the first cell, box, or bullet. Triggers - "make a table", "summarize these systems", "comparison", "overview of", building any figure or schema, or presenting collected research results.
---

# Publication-Grade Data Representation

An LLM's first draft of a data representation is typically inconsistent: information
appears in random places, equivalent items carry different fields, some entries are
annotated and others not, and unknowns are silently omitted or silently guessed.
This skill exists because those failures are structural, not cosmetic — and they are
fixed by procedure, not by taste. Work through it in order.

## 1. The core law: schema before rendering

Never start drawing/writing the representation directly from what you happen to know.
First define the **schema**: for every entity type that will appear (row, box, list
item, paragraph-per-system), fix the exact set of fields and their order.

- Every instance of a type fills the SAME blanks in the SAME positions.
- A field with no published value is rendered as **"n/a"** — visibly, in place.
  Never omit the field, never fill it with something plausible.
- If most instances would be "n/a" for a field, reconsider the field — but make that
  a deliberate schema change, not a per-instance omission.
- Write the schema down (file comment, notes file) so the next instance can't drift.

Example schema (from an avionics survey): sensor box = type(×N) / part / key spec /
sample rate; compute box = role(×N) / part / clock+cores / redundancy mode;
algorithm chip = function / rate. Unknown → "n/a".

## 1b. Cross-instance consistency is part of the schema

The schema binds across the WHOLE series, not just within one artifact: the same
box/row/entry type carries the same field set in every figure/table of the
document (compute box = part / cores @ clock / OS everywhere — "n/a" where
unknown). When revising one instance, re-open its siblings and reconcile.

## 2. One semantic level per element type

Do not mix kinds of information inside one element class. The canonical failure:
listing "1 active + 1 hot spare" as an *algorithm* — it is an architecture property
and belongs in the device's data fields. Ask for each datum: *what kind of fact is
this?* — then it has exactly one home defined by the schema. If a datum has no home,
extend the schema explicitly or leave the datum out; never park it "somewhere it fits".

The same law applies to visual encodings: a color scheme / shading / border style /
marker binds to exactly ONE type of represented data across the whole deliverable
set. Never reuse a scheme — even a "neutral" tone — for a second data type, and never
let two types share a look. A tone consumed by one element type is unavailable to all
others.

## 3. Sourcing gate (ABSOLUTE — this rule is career-critical for the user)

- **Nothing may be written or included that cannot be directly proven from a document
  available to you.** No inferred, guessed, or "plausible" content, ever — not in a
  box, not in a cell, not in a sentence. If you even consider writing something
  without a source in hand, STOP and raise it with the user first.
- Every value in the representation must trace to a verifiable source (paper with
  page, datasheet, standard, dated snapshot). Keep a claim→source ledger (notes file
  with a Source column); content without a filled source does not ship.
- **Every shipped representation gets an accompanying SOURCE MAP document**
  (e.g., `<artifact>-sources.md` next to it): one row per element — every box,
  field, cell, edge, label, legend entry, and exclusion — stating its exact
  source (doc + section/page, quote where useful). Pure layout/wording choices
  are marked DESIGN (they carry no factual claim). If an element has no row,
  it does not ship.
- When a needed fact has no available source, the options are exactly two: render it
  as "n/a", or DISCUSS with the user (fetch a new source? drop the field? accept
  n/a?). Choosing silently on the user's behalf is not an option.
- Secondary summaries (search-result snippets, abstracts, LLM memory) are not
  sources. Verify in the actual document before citing it — summaries have
  attributed facts to papers that do not contain them. When a collection
  contains a secondary/summary document, mark it "NOT citable" in the ledger so
  it is never picked up later.
- Citation metadata is a claim too: verify author names, venue, and year
  against the actual document before writing them anywhere (a from-memory
  "(Nash et al.)" for a paper actually by Nayak et al. is a fabrication).
- **Analogy/transfer statements have scope.** If a source declares a prototype
  "analogous to the flight articles" for named subsystems, only THOSE
  subsystems' values transfer (with the weaker-source marker); everything else
  from the prototype is excluded entirely — not marked, excluded.
- An honestly mostly-"n/a" representation is a FINDING about the state of the
  published record, not a failure — present it as such; never densify it with
  plausible values.
- Distinguish source classes visibly when they differ in reliability (e.g., an
  asterisk for design-phase-only sources vs. as-flown/post-hoc sources), and define
  the marker once.
- Category/class assignments (colors, groupings, grades) are claims too — each
  instance's class must be sourced, not pattern-matched. If the source says only
  "COTS", the label may say "COTS"; it may NOT say "consumer-grade".
- A checked gap is a result: state "not stated in available sources" (n/a). Never
  bridge it with something plausible.
- If you yourself flag a value as needing confirmation, that is a BLOCKING todo:
  confirm it before building anything on it, or stop and ask. Do not render
  known-unconfirmed data and annotate it "to verify later".
- **NON-NEGOTIABLE: read every cited source IN FULL before building on it.**
  Grep hits and skimmed paragraphs are not "having read the source" — unread
  sections routinely contain the per-item details (per-module timings, sensor
  part names, single-device statements) that change the representation's
  structure. Extract to the ledger while reading. A deliverable built on a
  source with unread relevant sections is a defect, not a draft. (Learned the
  hard way: an OBC drawn as two devices because one sentence was skimmed while
  a second paper stated the FPGA is on the same die; a camera boxed "part n/a"
  while the cited paper names the sensor and its baseline.)
- **A named part is a research obligation.** The moment any source names a
  concrete part (chip, sensor, module), obtain its manufacturer documentation
  and mine the part-level facts (architecture, core count, fabric family,
  grades offered). Part-level facts fill part-level fields; mission-config
  facts (flown clock, OS, flight-unit grade) stay n/a unless a mission source
  states them — keep the two layers distinct in the ledger. A box for a fully
  documented part must never look as empty as a box for an unnamed part. If a
  datasheet cannot be fetched, flag it for manual download — never proceed
  silently without it. Mind naming discrepancies between mission papers and
  datasheets (e.g., a paper calling a Kintex-7-fabric SoC "Artix-7"): render
  the neutral term, flag the conflict in the source map.
- **Datasheet values count as confirmed ONLY when the part number is
  deterministic.** Before transferring any datasheet value: (1) the source
  must name the exact model; (2) check the part number has no sub-models,
  speed grades, or revisions that differ IN THAT VALUE (a "Zynq-7045" clock
  spans 667 MHz–1 GHz by speed grade → clock NOT confirmed; its core count is
  invariant → confirmed; a "Snapdragon 801" clock varies by variant → n/a,
  but its core type is uniform → confirmed). Record the determinism check in
  the ledger per value, not per part.
- **Extract against the WHOLE schema, never against the current question.**
  Reading with a single question in mind is lossy: a sentence often carries
  facts for several boxes at once, and clauses that don't answer today's
  question get silently dropped (real failure: "Although the FPGA in the VCE
  runs portions of the image processing pipeline, the ENav functions are all
  implemented on the RAD750 CPU" — the second clause was extracted, the first
  clause, which answered a different element's field, was discarded, and that
  field later shipped as "not stated"). For every sentence read, ask: which
  schema fields — of ANY element — does this bear on? Log every hit.
- **"n/a" is a positive claim that requires its own verification pass.**
  Never declare a gap from your notes — notes are lossy; absence from notes
  is evidence of nothing. Before any field ships as n/a, run a dedicated
  search for THAT field across EVERY source in the ledger (keyword sweeps
  plus reading the sections where it would live) and record in the ledger
  which sources were checked. An n/a without a recorded gap-check does not
  ship.

## 4. Information architecture: plan comparison, then layout

Decide what the reader must be able to compare, and arrange so that comparison is a
straight visual scan:

- Group by category; same category on the same axis (same row band, same column).
- Align comparable items; give repeated annotations a shared position (e.g., all
  edge labels on one baseline; units in the table header, not in cells).
- One encoding carries ONE dimension (color = part class only; shape = element kind
  only; dashed = "unknown" only). Never reuse an encoding for a second meaning.
- Multiplicity/quantity is data: state exact counts ("(×6)"), never a vague visual
  suggestion (a double-stacked icon standing for six is a lie).

## 5. Labeling discipline

- Define one labeling rule per element class and apply it to EVERY instance
  ("edges carry protocol only; rates live in the boxes"). No selective annotation:
  if one edge is labeled, all edges are labeled — with "n/a" if unknown.
- Category names must be self-distinguishing: name the underlying dimension as a
  ladder or axis (e.g., COTS part → automotive-grade part → radiation-tolerant part
  → tolerance level n/a), not a mix of unrelated ideas (market, screening,
  provenance) that the reader cannot tell apart by definition.
- Abbreviations and invented shorthand must appear in a legend or be dropped.

## 6. Minimal on-artifact text

The artifact carries data + the minimum decoding key (legend, one defined marker).
Definitions, disclaimers, methodology, and caveats go to the caption / accompanying
description, not onto the artifact. Draft that caption text at the same time — it is
part of the representation, and it must carry everything removed from the artifact
(marker definitions, "n/a = not stated in sources", quantity notation, systemic
caveats).

## 7. Tables specifically

- Header defines field + unit; cells contain values only — no prose, no per-cell units.
- Consistent precision/format per column; "n/a" for unknowns; explicit source column
  (or per-row citation) for publication tables.
- Row order is a decision (by class, by date, by performance) — pick one and state it.
- If a table's columns differ per row, it is two tables.

## 8. Perfect one, then scale

For a series of parallel representations (five system diagrams, N result tables):
iterate ONE instance to flawless with the reviewer, extract the template/schema from
it, then stamp out the rest mechanically. Never produce all instances first and fix
in parallel. Budget several review rounds on the master instance — that is the plan,
not a failure.

## 9. Self-review checklist (run before showing anyone)

- [ ] Nothing included that isn't provable from a document in hand; anything
      unprovable was raised with the user BEFORE inclusion, not after
- [ ] Schema written down; every instance has every field; unknowns say "n/a"
- [ ] No element carries information of the wrong semantic kind
- [ ] Every value, class assignment, and marker traces to a source
- [ ] One encoding = one dimension; encodings defined in legend/caption
- [ ] Encoding↔meaning is BIJECTIVE: enumerate every visual signature actually
      rendered (composed looks count — body fill × header fill × border style);
      no two data types share a look, no type has two looks, and every legend
      swatch is built from the same style definition as the element it explains
- [ ] Every element class labeled by one rule, applied to all instances
- [ ] Category names self-distinguishing along one named dimension
- [ ] On-artifact text minimal; caption drafted with all removed definitions
- [ ] Look at the rendered result at final size and walk every element — do not
      review the source code and call it reviewed

For figures/diagrams specifically, continue with the companion skill:
publication-scientific-figures.
