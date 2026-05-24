---
description: Run the Flux multi-agent Flutter pipeline (task → implement → review → QA). Use for any feature or significant change under lib/.
---

# Flux Pipeline

You are running the **Flux multi-agent development pipeline**.

## User request

$ARGUMENTS

---

## Instructions

1. Invoke **`flutter-pipeline-orchestrator`** with the user request above.
2. The orchestrator must run all four stages in order without skipping.
3. Report progress after each stage gate (`TASK_READY`, `IMPLEMENTATION_COMPLETE`, `REVIEW_APPROVED`, `QA_PASSED`).
4. On `QA_PASSED`, summarize what was built, files changed, and test results.

## Layout source

All UI is defined in:

`/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/`

Read `.cursor/skills/flutter-pipeline/design-reference.md` and the relevant `code.html` before implementation.

## Architecture constraints

Read `.cursor/skills/flutter-pipeline/architecture.md` before any code stage.

## Do not

- Implement directly in this workflow without going through the pipeline
- Skip code review or QA
- Add Riverpod, Bloc, Provider, MobX, or GetX

---

**Start now:** Use `flutter-pipeline-orchestrator` agent.
