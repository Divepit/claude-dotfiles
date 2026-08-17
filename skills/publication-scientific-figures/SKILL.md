---
name: publication-scientific-figures
description: Build publication-grade schematic figures - system/architecture diagrams, block diagrams, signal-flow and structural schemas (TikZ/LaTeX) - to journal standards. Use when creating or revising any DIAGRAM-type figure for a paper/report - triggers include "make a figure", "diagram of the system", "architecture figure", "block diagram", "schema". For data plots/charts use chart-specific guidance (e.g. a dataviz skill) - sections 0, 3, 4, 7, 8 here still apply to those. Companion to publication-data-representation (apply that skill's schema + sourcing gates FIRST).
---

# Publication-Grade Scientific Figures & Schemas

Hard-won procedure for figures that survive peer review AND an A4 grayscale
printout. First drafts fail in predictable ways: unreadable print sizes, lines
through boxes, floating arrowheads, inconsistent box contents, decorative color,
unlabeled or selectively labeled edges. Fix by procedure. Follow in order.

## 0. Gates before drawing anything

1. **Sourcing gate** (see publication-data-representation, career-critical):
   every box, value, and class assignment must be provable from a document in
   hand; unknowns render as "n/a"; anything unprovable is discussed with the
   user BEFORE it appears. Self-flagged "needs confirmation" = blocking todo.
   Where sources differ in reliability (as-built vs. design-phase, measured vs.
   simulated, primary vs. secondary), prefer the stronger class and mark values
   that rest only on the weaker one with a defined marker (e.g., *).
2. **Data notes first**: compile a notes file (fact + source + page) for the
   subject; the figure is a *rendering of the notes*, never of memory.
   Additionally ship a per-figure SOURCE MAP (`fig-<x>-sources.md`): one row per
   box/field/edge/label/legend-entry/exclusion with its exact source; layout
   decisions marked DESIGN (see companion skill).
   **NON-NEGOTIABLE — full-read gate:** every source the notes cite must be
   read IN FULL before the figure is drawn; grep hits are not reading. And
   every part NAMED in a source obliges you to obtain its manufacturer
   documentation and fill part-level fields from it (flown-config values stay
   n/a; datasheet values transfer only after a per-value determinism check —
   no sub-model/speed-grade may differ in that value) — a documented part's
   box must never be as empty as an unnamed part's. Datasheet unfetchable →
   flag for manual download, never proceed silently.
   **Extract against the whole schema** (every sentence may fill fields of
   several boxes — mining only for the current question drops the rest), and
   **verify every "n/a" with a dedicated per-field search across ALL sources
   before it ships** — an n/a declared from lossy notes instead of from the
   sources is how career-ending misses happen.
3. **Schema**: fix field sets per element type (see companion skill). Each
   sub-element kind carries ONE semantic kind of information (e.g., tags on a
   device = functions only; properties are body fields); quantity is "(×N)" in
   the title — never fake stacked-icon counts.
4. **Research conventions** for the figure type before inventing one (e.g.,
   UML-class compartments for device boxes; layered dataflow layouts). Check
   the venue's figure rules (IEEE: color free online, auto-grayscale in print).

## 1. Visual grammar (define once, reuse across every figure in the document)

Define ONE grammar for the whole document and instantiate it per figure — the
reader learns it once. The grammar below is a proven default for device/system
diagrams; adapt the *content* of each rule to the domain, keep the *rules*:

- **Compartmented boxes** (UML-class style: tinted title compartment + body
  fields below a rule) whenever boxes carry structured fields — including small
  sub-element tags. For domains where boxes carry a single name, a plain box is
  fine, but pick one style and use it everywhere.
- **Fill encodes exactly one dimension**, chosen from the domain and named as an
  ordinal ladder or clean categorical axis (example from an avionics paper:
  COTS part / automotive-grade part / radiation-tolerant part / level n/a; in
  another domain it might be maturity, ownership, or trust level). Dashed
  border = the "unknown/unclassified" case. Sub-element tags: neutral gray —
  never a class color, never plain white if white means "unknown".
- **Encoding↔meaning must be BIJECTIVE across the whole figure set.** Enumerate
  every visual signature actually rendered — composed looks count: body fill ×
  header/title fill × border style is ONE signature wherever it appears — and
  verify each signature has exactly one meaning and each meaning exactly one
  signature. A tone consumed by one element type (even a neutral gray used for
  sub-element headers) is unavailable to every other element type: a neutral
  grouping container must NOT get a gray header bar if gray headers mean
  "algorithm"; give it a plain/white header instead. Legend swatches must be
  built from the same style macros as the elements they explain — a swatch that
  differs from the rendered element means the figure or the legend is lying.
- **Title compartments must be optically centered**: whatever paints a header
  bar must leave equal space above and below the title text (if the container
  fit leaves 2.5 mm above the title node, the bar must extend 2.5 mm below
  title.south, and content anchored to title.south must clear the bar). After
  any change to a shared header macro, re-measure top/bottom padding in px for
  every container and re-space dependent nodes — a shared-macro asymmetry is a
  defect in every figure at once.
- **Edges**: one labeling rule for all (decide WHAT an edge label states — e.g.,
  interface/protocol, flow type, dependency kind — and where quantities live);
  EVERY edge labeled, "n/a" if unknown.
- **Legend** carries ONLY encodings that actually appear in THIS figure — an
  unused class color in a legend is an error, even if sibling figures use it
  (per-figure legends may differ; the document-level grammar stays shared).
  It includes samples for the element kinds present AND a decode for every
  encoding channel used — including a line sample explaining what edge labels
  state (e.g., "interface protocol"): a reader seeing "n/a" on a line must know
  what would be there if it were known. ONE defined marker note (e.g., an
  asterisk for weaker sources) may sit under it. Every other definition ((×N),
  n/a, systemic caveats) belongs in the figure caption, not on the graphic.

## 2. Layout

- **Horizontal layers, flow top→bottom** (or left→right): one row/band per
  category of the domain (e.g., inputs / processing / outputs; or sensors /
  compute / actuators). Category bands + consistent flow direction are the
  generalizable rule; the categories come from the domain.
- **Center-anchored stacks**: build each container as title/body/chips all
  `anchor=north` on one x — the container `fit`s the content and is symmetric
  by construction. Containers FIT their content; no forced-width spacers that
  create empty colored area. Stack chips vertically if that reduces emptiness.
- Place connected boxes so edges become **short straight verticals/horizontals**;
  where a source column sits outside its target box, use a short Z-route with
  the turn band between rows. Put all row-transition labels on one shared
  baseline.
- **Fan-in pattern** (N sources → one container): entries as container-RELATIVE
  offsets from a corner anchor (`($(box.north west)+(k mm,0)$)`), entry order =
  source order, and NESTED turn bands (shorter runs on the higher band, longer
  runs lower). Before compiling, check every final drop against every lower
  band on paper — a drop may only cross bands that end above it.
- **Side-by-side containers of different heights**: vertically center the
  smaller on the larger and run their connecting edge on the shared centerline.
  Set by measurement, not by eye (see the pixel-measure step in §7).
- **Multi-device unit (assembly) pattern**: one-device-one-box is invariant. A
  unit containing several devices (e.g., a CPU + FPGA board) becomes an outer
  ASSEMBLY container (white fill, neutral gray title, legend entry "device
  assembly") holding one device box per device; functions attach to the device
  that hosts them per the source, unit-level functions with unstated host
  attach at assembly level; draw NO edge between sibling devices unless the
  internal interconnect is published.
- Grid all coordinates in explicit mm; document the column centers in comments.

## 3. Size & typography (the print test)

- **Design at final size; never scale down.** Look up the target venue's column
  widths (for IEEE journals: single column 8.85 cm, double-column \textwidth
  ≈ 18.2 cm — other venues differ, check theirs) and keep total content width
  within it; the figure is inserted at scale 1.0.
- Font floor **7 pt (\scriptsize) at final size**; body text 8 pt. If it doesn't
  fit, cut content or gaps — not font size.
- Figure font matches venue practice (Helvetica via `\usepackage[scaled]{helvet}`
  for IEEE); the manuscript must load the same package.
- Measure width exactly: `standalone` page = content + 2×border; check
  `pdfinfo` page size, don't estimate.

## 4. Color (compute, don't eyeball)

- Light class fills with black text, distinct in HUE and stepped in LIGHTNESS
  so automatic grayscale print conversion keeps them apart (most journals print
  grayscale unless paid). Validate CVD separation with a checker (target
  adjacent-pair ΔE ≥ 8; identity never rests on color alone because every box
  is text-labeled).
- Reusable starter palette for any 3-class + unknown scheme (validated: worst
  pair ΔE 15.3 deutan / 13.9 tritan): fills #CDE2FB / #F3C37C / #A9A3E0
  (~L90/84/70), title-bar steps of the SAME hues #9EC5F4 / #E5A44E / #8B84CE;
  unknown class = white + dashed. More classes → re-validate, don't improvise.

## 5. Routing rules (where first drafts die)

- Orthogonal edges only; zero crossings of boxes or other labels; arrowheads
  land perpendicular ON the border.
- **Anchor edge endpoints RELATIVE to boxes** (`fpga.south east +(0,6mm)`,
  `(x,0 |- box.north)`), never at absolute coordinates near a box edge — boxes
  resize and absolute endpoints end up floating.
- Never attach next to a corner; if a bottom-attach is squeezed by a neighbor,
  exit the SIDE and S-route through a free corridor.
- Label placement geometry: a label next to a HORIZONTAL line must be offset in
  y (a rotated label's text column still crosses the line if only x-shifted);
  narrow-gap labels go rotated in the gap or beside the line in white space.
- Bus fan-outs: one stub, one junction coordinate, branches entering box tops —
  junction x chosen BETWEEN the target boxes.

## 6. TikZ mechanics & known traps

- Libraries: `positioning, fit, arrows.meta, calc, backgrounds, shapes.multipart`.
- Compartments: `rectangle split parts=2` with
  `rectangle split part fill={titleColor, bodyColor}`.
- Containers: place children first, then on the `background layer`
  `\node[container, fill=..., fit=(a)(b)(c)]` + paint the title bar with a
  helper macro after the container node (later background draws sit above it;
  main-layer text stays on top).
- **Trap**: a `fit` list containing coordinates with commas must be braced:
  `fit={(a)(b)(10mm,-5mm)}` — unbraced it aborts pgfkeys ("extra }") and can
  hang the compile.
- **Trap**: pgf-calc precedence — `($(A)!0.5!(B)+(C)$)` adds C to B *before*
  the midpoint (half effect). Use `([xshift=…]$(A)!0.5!(B)$)`.
- **Trap**: standalone `\quad` swallowing / label `pos` on multi-segment paths
  counts the WHOLE path — attach the label node to the intended segment.
- **Trap**: bare or calc coordinates inside `fit` lists behave unreliably as
  spacers — use zero-size NODES instead
  (`\node[inner sep=0, minimum size=0] (pad) at (x,y) {};` then `fit=(...)(pad)`),
  and verify resulting padding by pixel measurement.
- **Trap**: an edge built as two `\draw[->]` segments leaves a stray arrowhead
  at the junction — the bus/first segment must be arrowless (`link`), only the
  final segment into the box carries the arrow. Add junction arrowheads to the
  pixel-walk.
- **Trap**: nested background-layer scopes draw in CODE order — an outer
  filled container written AFTER an inner one paints OVER it. Draw outer
  assembly containers first, inner device containers after, in ONE scope.
- **Trap**: a calc expression inside a perpendicular coordinate
  (`($(A)+(0,0)$ |- 0,-50mm)`) can silently collapse to A itself (edge turns at
  the box-center height instead of the intended y). Write side-entries as plain
  two-segment paths: `(a) -- (a |- 0,Ymm) -- (box.east |- 0,Ymm)`.
- Compile with `-interaction=batchmode -halt-on-error` and a timeout; a pgfkeys
  error can otherwise hang forever.
- An overlay `\fill` painted up to a node's anchors ERASES the node's border
  (anchors sit on the stroke's center line; the paint covers the inner half,
  and antialiasing kills the leftover hairline — a dashed border disappears
  entirely). Inset overlay fills beyond the stroke half-width: ≥0.5pt for a
  semithick (0.6pt) border. Crop-verify the border after adding any fill.

## 7. The loop: compile → render → pixel-walk (every iteration)

Use a pinned LaTeX environment (e.g., docker `texlive` container) so results
reproduce. Then:

1. `pdflatex` (halt-on-error, timeout) → `pdfinfo` width check.
2. `pdftoppm -png -r 150` (overview) and `-r 300` (inspection); crop hot spots.
3. **Pixel-measure** any alignment/centering claim: `pdftoppm -gray` produces a
   PGM parseable with stdlib Python; scan a column/row for fill or border pixels
   (WINDOW the scan to exclude legend/adjacent rows) and compare extents/centers
   in mm. Never assert "centered/aligned" from looking.
4. **Pixel-walk checklist** — walk EVERY edge and box in the render (not the
   source code) before showing the user:
   - [ ] each edge: start anchor on border, end anchor on border, perpendicular
   - [ ] each label: clear of every line and border; consistent baseline group
   - [ ] each box: schema fields complete, "n/a" present, class fill sourced
   - [ ] box-type field sets IDENTICAL across every figure of the series
         (e.g., compute = part / cores @ clock / OS, n/a where unknown) — open
         the sibling figures and compare
   - [ ] no stray arrowheads at bus junctions; assembly inner boxes have
         visible padding to the outer border (measure, don't glance)
   - [ ] no line passes through/behind any box; no floating arrowheads
   - [ ] rows/tops aligned as designed; legend swatches vertically centered,
         legend centered under the figure
   - [ ] every title/header text optically centered in its compartment (top pad
         = bottom pad, measured in px, boxes AND containers)
   - [ ] encoding↔meaning bijective: no two element types share a visual
         signature; every legend swatch matches its rendered element exactly
   - [ ] content width ≤ venue width; grayscale-readable; fonts ≥ floor
5. Also self-review the code: no dead fragments, no leftover experiment lines.
6. Expect several rounds with the user on the FIRST figure of a series; then
   template it (shared style file) and stamp out the rest — the second figure
   of a series should take ~1 session, not 15 rounds.

## 8. Caption contract

The caption carries everything removed from the graphic: source list, marker
definitions ("* = design-phase source only …"), "(×N) = quantity",
"n/a = not stated in available sources", and systemic caveats (e.g., "all COTS
parts SEL-screened at system level per [X]"). Draft it WITH the figure.

## 9. Shared style file

Keep one `*-figs.tex` style file per document: class colors + validation
numbers, box/chip/container/link styles, the schema in a header comment, and
the title-bar macro. All figures `\input` it; a style change updates every
figure. Template: see `template-figstyle.tex` next to this skill.
