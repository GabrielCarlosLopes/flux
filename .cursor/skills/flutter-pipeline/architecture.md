# Flux — Arquitetura do Projeto

Referência obrigatória para todos os agentes do pipeline.

## Layout e design (fonte externa)

**Todo o layout está em:**

```
/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/
```

Detalhes, mapa tela→feature e regras de fidelidade visual: [design-reference.md](design-reference.md).

- Design system: `serene_focus/DESIGN.md` (Serene Focus — Hanken Grotesk, tokens M3)
- Telas: cada subpasta tem `code.html` (HTML/Tailwind do Stitch)

Implementação Flutter deve espelhar esses arquivos; tokens vivem em `lib/core/theme/`.

## Estrutura de diretórios

```
lib/
├── core/
│   ├── config/
│   ├── constants/
│   ├── theme/
│   ├── navigation/      # go_router setup, guards
│   ├── services/
│   ├── utils/
│   └── extensions/
├── shared/
│   ├── widgets/
│   ├── layouts/
│   ├── components/
│   ├── dialogs/
│   └── animations/
└── features/
    ├── onboarding/
    ├── tasks/
    ├── focus/
    ├── routines/
    ├── insights/
    ├── premium/
    └── settings/

# Cada feature:
features/<name>/
├── data/
│   ├── datasources/     # LocalDataSource (Isar)
│   ├── models/
│   └── repositories/    # Repository impl
├── domain/
│   ├── entities/
│   ├── repositories/    # abstract
│   └── usecases/
└── presentation/
    ├── viewmodels/
    ├── screens/
    └── widgets/
```

## Fluxo de dados (offline-first)

```
UI (Widget)
  ↓ user action
ViewModel (ChangeNotifier / ValueNotifier)
  ↓
UseCase
  ↓
Repository (interface in domain)
  ↓
RepositoryImpl (data)
  ↓
LocalDataSource
  ↓
Isar
```

Reads flow upward via Futures/Streams exposed by ViewModel.

## Estado permitido

| Tipo | Quando usar |
|------|-------------|
| `ChangeNotifier` | Estado de feature com múltiplos campos |
| `ValueNotifier<T>` | Valor único (timer, toggle, seleção) |
| `ListenableBuilder` | Rebuild parcial em ChangeNotifier |
| `ValueListenableBuilder` | Rebuild parcial em ValueNotifier |

## Navegação

- `go_router` central em `lib/core/navigation/`
- Cada feature exporta rotas (`<Feature>Routes`)
- Paths deep-link ready: `/focus`, `/tasks/:id`, etc.

## Persistência

- **Isar** para storage local
- Models em `data/models/` com schemas Isar
- UI **nunca** acessa Isar diretamente

## Performance

- Rebuilds granulares (builders no menor subtree possível)
- `const` widgets
- Listas: `ListView.builder` / slivers
- Timers e animações com `dispose()` obrigatório

## Testes (por feature)

```
test/features/<name>/
├── domain/
├── data/
└── presentation/
```

- Fake repositories para unit tests
- `WidgetTester` para widget tests
- Casos: happy path, edge cases, empty, error

## Packages planejados (adicionar só com autorização na task)

| Package | Uso |
|---------|-----|
| go_router | Navegação |
| isar, isar_flutter_libs | Persistência |
| path_provider | Paths Isar |

## Anti-patterns proibidos

- `setState` para estado de negócio em features
- Lógica de negócio em `build()`
- ViewModel importando `material.dart` por widgets
- Rebuild da tela inteira em tick de timer
- Listeners sem `removeListener` / dispose
