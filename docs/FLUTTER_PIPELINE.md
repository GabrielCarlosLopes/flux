# Pipeline Multi-Agentes — Flux (Cursor)

Sistema de desenvolvimento automatizado para o app **Flux** com agentes especializados no Cursor.

## Objetivo

1. Escrever tasks técnicas  
2. Implementar tasks  
3. Revisar implementação  
4. Executar testes  
5. Reexecutar implementação se testes falharem  

**Arquitetura:** MVVM · feature-first · offline-first · `ChangeNotifier` / `ValueNotifier` / `ListenableBuilder` · Clean Architecture leve · sem frameworks externos de estado.

## Fluxo

```
USER TASK
    ↓
flutter-task-writer
    ↓
flutter-implementation
    ↓
flutter-code-review
    ↓
flutter-qa-test
    ↓
PASS? ── YES → DONE
      └── NO  → flutter-implementation (loop)
```

## Como usar

### Workflow (recomendado)

No chat do Cursor:

```
/flux Criar tela de focus mode com timer visual
```

### Orquestrador manual

```
Use flutter-pipeline-orchestrator para: <sua solicitação>
```

### Agente individual

Use apenas em debug do pipeline — em produção, sempre o fluxo completo.

| Agente | Arquivo |
|--------|---------|
| Task Writer | `.cursor/agents/flutter-task-writer.md` |
| Implementation | `.cursor/agents/flutter-implementation.md` |
| Code Review | `.cursor/agents/flutter-code-review.md` |
| QA Test | `.cursor/agents/flutter-qa-test.md` |
| Orchestrator | `.cursor/agents/flutter-pipeline-orchestrator.md` |

## Artefatos do projeto

| Recurso | Caminho |
|---------|---------|
| Skill do pipeline | `.cursor/skills/flutter-pipeline/SKILL.md` |
| Arquitetura | `.cursor/skills/flutter-pipeline/architecture.md` |
| Template de task | `.cursor/skills/flutter-pipeline/task-template.md` |
| Regra global | `.cursor/rules/flutter-pipeline.mdc` |
| Workflow `/flux` | `.cursor/workflows/flux.md` |

## Layout (Stitch — fonte visual)

**Todo o layout do app está em:**

```
/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/
```

| Recurso | Caminho |
|---------|---------|
| Design system Serene Focus | `serene_focus/DESIGN.md` |
| Telas (HTML) | `<feature_folder>/code.html` |
| Mapa tela → feature | `.cursor/skills/flutter-pipeline/design-reference.md` |

Agentes devem abrir o `code.html` da tela antes de implementar ou revisar UI.

## Estrutura `lib/`

Ver [architecture.md](../.cursor/skills/flutter-pipeline/architecture.md).

## Estado permitido vs proibido

| Permitido | Proibido |
|-----------|----------|
| ChangeNotifier | Provider |
| ValueNotifier | Riverpod |
| ListenableBuilder | Bloc |
| ValueListenableBuilder | MobX, GetX |

## Regras globais

- Nunca gerar código sem task  
- Nunca implementar sem arquitetura definida na task  
- Nunca ignorar review ou testes  
- Nunca alterar estrutura global sem autorização  
- Nunca adicionar dependências sem justificativa na task  

## Loop de correção

```
QA FAILED → implementation → code-review → qa-test → (repeat até PASSED)
```
