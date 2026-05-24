---
name: flutter-pipeline
description: Multi-agent Flutter development pipeline for Flux app. MVVM, feature-first, offline-first, ChangeNotifier/ValueNotifier only. Use for feature work, /flux workflow, or when orchestrating task-writer → implementation → review → QA.
when_to_use: "When building or modifying Flux Flutter features, running the multi-agent pipeline, or enforcing MVVM/listenable architecture without Riverpod/Bloc."
allowed-tools: Read, Grep, Glob, Bash, Write, Edit, Agent
---

# Flux Flutter Pipeline

Predictable multi-agent development for the Flux app.

## Pipeline (never skip steps)

```
USER → task-writer → implementation → code-review → qa-test → DONE
                              ↑_______________|  (on FAILED / CHANGES_REQUIRED)
```

## Agents

| Order | Agent | Output status |
|-------|--------|----------------|
| 1 | `flutter-task-writer` | `TASK_READY` |
| 2 | `flutter-implementation` | `IMPLEMENTATION_COMPLETE` |
| 3 | `flutter-code-review` | `REVIEW_APPROVED` or `CHANGES_REQUIRED` |
| 4 | `flutter-qa-test` | `QA_PASSED` or `QA_FAILED` |

Orchestrator: `flutter-pipeline-orchestrator`

## Layout source (mandatory)

**All UI/layout lives outside the repo:**

`/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/`

See [design-reference.md](design-reference.md) for screen map and [serene_focus/DESIGN.md](/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/serene_focus/DESIGN.md) for tokens.

## Architecture (summary)

See [architecture.md](architecture.md) for full structure.

- **State:** `ChangeNotifier`, `ValueNotifier`, `ListenableBuilder`, `ValueListenableBuilder`
- **Forbidden:** Provider, Riverpod, Bloc, MobX, GetX
- **Nav:** `go_router`
- **DB:** Isar
- **Layers:** UI → ViewModel → UseCase → Repository → LocalDataSource → Isar

## Task template

Use [task-template.md](task-template.md) for all Task Writer output.

## Global rules

1. Never generate code without a `TASK_READY` document
2. Never implement without architecture defined in task
3. Never skip review or QA
4. Never modify `lib/core/` or global structure without explicit authorization
5. Never add dependencies without justification in task
6. Prioritize: readability → performance → accessibility → anti-paralysis UX

## Commands (QA)

```bash
flutter analyze
flutter test
flutter test test/features/<feature>/
```

## Invoke orchestrator

```
Use flutter-pipeline-orchestrator to: <user request>
```

Or workflow: `/flux <request>`
