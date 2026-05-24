# Task: F01 — Onboarding

> Gerado por: flutter-task-writer  
> Data: 2026-05-24

---

## Referência visual (Stitch)

| Item | Caminho |
|------|---------|
| Design system | `/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/serene_focus/DESIGN.md` |
| Boas-vindas | `/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/onboarding_bem_vindo/code.html` |
| Triagem | `/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/onboarding_triagem/code.html` |

### Boas-vindas (`onboarding_bem_vindo/code.html`)

| Elemento | Especificação Stitch |
|----------|----------------------|
| Fundo | `background` (#f7fafb), overflow hidden |
| Orbes decorativos | Dois círculos blur: topo-esquerda `primary-container/40` blur ~100px, animação `breathe` 8s; baixo-direita `secondary-container/30` blur ~120px, animação `float` 12s (delay -4s) |
| Layout | Coluna centralizada, `max-w-2xl`, padding horizontal 24 (mobile) |
| Headline | **"Vamos desacelerar a sua mente?"** — `headline-xl` (40/52, w700), `on-surface`, tracking tight |
| Subtitle | **"Um espaço seguro para você realizar o que importa, um passo de cada vez."** — `body-lg` (20/32), `on-surface-variant`, max-width ~md |
| CTA | **"Começar"** — largura total, altura **56 dp**, `rounded-full`, `bg-primary` / `on-primary`, `label-md` (14/20, w600, letter-spacing 0.05em), sombra suave verde |
| Hierarquia | Conteúdo centralizado verticalmente; CTA fixo na base com `section-gap` (64) acima |

**Adição obrigatória (ROADMAP, ausente no HTML):** controle **"Pular"** sempre visível — `TextButton` no canto superior direito (SafeArea), copy **"Pular"**, estilo discreto (`on-surface-variant`), área de toque ≥ 48×48 dp.

### Triagem (`onboarding_triagem/code.html`)

| Elemento | Especificação Stitch |
|----------|----------------------|
| Header | Linha: botão voltar (48×48, círculo, `surface-container-lowest`, sombra ambient) + anel de progresso 48×48 (~**40%** preenchido — passo 2 de 2) |
| Headline | **"O que mais te atrapalha hoje?"** — `headline-lg-mobile` (28/36) / `headline-xl` em telas largas, centralizado |
| Cards (5) | Multi-select, `rounded-[32px]`, padding 24, `surface-container-lowest`, sombra ambient; gap 16 entre cards |
| Opções (copy exata) | Procrastinação · Esquecer tarefas · Dificuldade de foco · Ansiedade · Começar algo novo |
| Ícones Material | `hourglass_empty`, `event_busy`, `center_focus_strong`, `blur_on`, `rocket_launch` (28px no círculo 56×56) |
| Estado selecionado | Fundo `primary-container`, texto `on-primary-container`, ícone `primary`, check `check_circle` visível |
| CTA | **"Continuar"** — 56 dp, pill; **desabilitado** até ≥1 opção (estilo `surface-container-highest` + opacidade); habilitado → `primary` / `on-primary` |
| Voltar | Navega para boas-vindas |

**Adição obrigatória (ROADMAP):** **"Pular"** no header (lado oposto ao progresso ou abaixo do anel), mesmo comportamento que concluir sem seleção obrigatória — ver Fluxo de dados.

**Tokens:** usar `AppColors`, `AppSpacing`, `AppRadius`, `AppTypography`, `Theme.of(context)` — não hardcodar hex fora do tema F00.

---

## Contexto

F00 entregou tema Serene Focus, `go_router` com rota stub `/onboarding`, Isar com `FluxMeta`, e `initialLocation` em `/tasks` **sem** guards. O ROADMAP define F01 como primeiro fluxo de produto: boas-vindas acolhedoras + triagem leve de desafios (sem culpa), persistência de conclusão e redirecionamento para a home de tarefas (`/tasks`).

A triagem alimenta personalização futura (ex. F09 insights); os dados devem ser persistidos de forma estruturada, não apenas um boolean em memória.

---

## Objetivo

Implementar o fluxo completo de onboarding (boas-vindas → triagem → home), com copy e layout fiéis ao Stitch, skip sempre disponível, persistência offline do status e respostas de triagem em Isar, e guard de navegação que impede reexibir onboarding após conclusão.

---

## Escopo

1. **Camadas feature-first** em `lib/features/onboarding/` (data → domain → presentation).
2. **Tela de boas-vindas** conforme `onboarding_bem_vindo/code.html` + botão **Pular**.
3. **Tela de triagem** conforme `onboarding_triagem/code.html` + botão **Pular** no header.
4. **Animação de fundo** (orbes blur breathe/float) na welcome — widget dedicado com `AnimationController` e `dispose()`.
5. **Multi-select** nas 5 opções de triagem; Continuar habilitado somente com ≥1 seleção.
6. **Persistência Isar:** collection `OnboardingProfile` na feature (decisão abaixo) — `isComplete`, `completedAt`, `selectedChallenges` (lista de enums/strings estáveis).
7. **Use cases:** verificar conclusão, salvar triagem + marcar completo, completar via skip (sem seleções ou com seleções parciais já escolhidas).
8. **Navegação:** sub-rotas `/onboarding` (welcome) e `/onboarding/triage`; máquina de estados welcome → triage → `/tasks`.
9. **Redirect guard** no `GoRouter`: incompleto → forçar fluxo onboarding; completo → bloquear `/onboarding*` e manter `/tasks` como destino pós-fluxo.
10. **Remover** uso de `OnboardingStubScreen` na rota de produção (substituir por telas reais; arquivo stub pode ser removido ou mantido apenas se referenciado em testes — preferir remoção).
11. **Composição manual** de repositório/use cases nas telas ou factory leve na feature (F00 não tem DI global — não introduzir `get_it`/`provider`).
12. **Testes** unitários (domain/data), widget (welcome + triage), redirect do router quando viável.

---

## Fora do escopo

- Login, conta, OAuth, perfil remoto.
- Paywall / premium.
- Telas ou sliders extras de “energia” não presentes no Stitch (a triagem de 5 cards cobre objetivos leves do ROADMAP).
- Shell navigation (bottom bar), deep links além dos paths definidos.
- Analytics / telemetria.
- Reset de onboarding nas settings (F07+).
- Sincronização cloud das respostas.
- Novos packages além dos já autorizados em F00 (`go_router`, `isar`, `isar_flutter_libs`, `path_provider`, `google_fonts`).
- Alterar `FluxMeta` para armazenar estado de onboarding (ver decisão de persistência).
- UI fiel a features fora de onboarding (tasks home real — permanece stub).

---

## Arquivos afetados

| Ação | Caminho |
|------|---------|
| Criar | `lib/features/onboarding/domain/entities/triage_challenge.dart` |
| Criar | `lib/features/onboarding/domain/entities/onboarding_profile.dart` |
| Criar | `lib/features/onboarding/domain/repositories/onboarding_repository.dart` |
| Criar | `lib/features/onboarding/domain/usecases/is_onboarding_complete_use_case.dart` |
| Criar | `lib/features/onboarding/domain/usecases/get_onboarding_profile_use_case.dart` |
| Criar | `lib/features/onboarding/domain/usecases/complete_onboarding_use_case.dart` |
| Criar | `lib/features/onboarding/data/models/onboarding_profile_model.dart` (+ `part` + codegen `.g.dart`) |
| Criar | `lib/features/onboarding/data/datasources/onboarding_local_data_source.dart` |
| Criar | `lib/features/onboarding/data/repositories/onboarding_repository_impl.dart` |
| Criar | `lib/features/onboarding/presentation/viewmodels/onboarding_welcome_view_model.dart` |
| Criar | `lib/features/onboarding/presentation/viewmodels/onboarding_triage_view_model.dart` |
| Criar | `lib/features/onboarding/presentation/screens/onboarding_welcome_screen.dart` |
| Criar | `lib/features/onboarding/presentation/screens/onboarding_triage_screen.dart` |
| Criar | `lib/features/onboarding/presentation/widgets/onboarding_blur_orbs_background.dart` |
| Criar | `lib/features/onboarding/presentation/widgets/onboarding_progress_ring.dart` |
| Criar | `lib/features/onboarding/presentation/widgets/triage_option_card.dart` |
| Criar | `lib/features/onboarding/presentation/widgets/onboarding_skip_button.dart` |
| Criar | `lib/features/onboarding/onboarding_routes.dart` (paths filhos + builders) |
| Criar | `lib/core/navigation/onboarding_redirect_notifier.dart` |
| Modificar | `lib/core/navigation/app_router.dart` — nested routes, `redirect`, `refreshListenable` |
| Modificar | `lib/core/navigation/route_paths.dart` — `onboardingTriage = '/onboarding/triage'` |
| Modificar | `lib/core/services/database_service.dart` — registrar `OnboardingProfileSchema` em `Isar.open` |
| Modificar | `lib/app.dart` ou `lib/main.dart` — instanciar e carregar `OnboardingRedirectNotifier` antes do router (se necessário) |
| Remover / substituir | `lib/features/onboarding/presentation/screens/onboarding_stub_screen.dart` |
| Criar | `test/features/onboarding/domain/...` |
| Criar | `test/features/onboarding/data/...` |
| Criar | `test/features/onboarding/presentation/...` |
| Modificar | `test/core/navigation/app_router_test.dart` — cenários de redirect |
| Modificar | `test/core/services/database_service_test.dart` — schema `OnboardingProfile` registrado |
| Modificar | `docs/tasks/README.md` — linha F01 → link para este arquivo |

---

## Fluxo de dados

```
[App start]
  main() → DatabaseService.init()
  → OnboardingRedirectNotifier.load()  // lê IsOnboardingCompleteUseCase
  → FluxApp → GoRouter(refreshListenable: notifier)

[Welcome Screen]
  OnboardingWelcomeViewModel
    onStart → context.go(/onboarding/triage)
    onSkip  → CompleteOnboardingUseCase(challenges: []) → notifier.refresh() → context.go(/tasks)

[Triage Screen]
  OnboardingTriageViewModel (ChangeNotifier)
    toggleChallenge(id)
    onContinue → CompleteOnboardingUseCase(challenges: selected) → notifier.refresh() → context.go(/tasks)
    onSkip     → CompleteOnboardingUseCase(challenges: selected ou []) → notifier.refresh() → context.go(/tasks)
    onBack     → context.pop() ou go(/onboarding)

[Redirect guard — toda navegação]
  IsOnboardingCompleteUseCase()
    se false e path ∉ /onboarding* → redirect /onboarding
    se true  e path ∈ /onboarding* → redirect /tasks
    senão → null
```

**Regras de negócio (skip sem culpa):**

| Ação | `isComplete` | `selectedChallenges` |
|------|--------------|----------------------|
| Pular na welcome | `true` | `[]` (lista vazia) |
| Pular na triage (0 seleções) | `true` | `[]` |
| Pular na triage (com seleções) | `true` | IDs selecionados (persistir escolha parcial) |
| Continuar (≥1 seleção) | `true` | IDs selecionados |

Nunca exibir mensagens de erro por lista vazia ao pular. Copy sempre acolhedor; sem “você precisa escolher”.

---

## Estados

| Estado | Tipo listenable | Campos / comportamento | Quem observa |
|--------|-----------------|------------------------|--------------|
| Welcome UI | Stateless + callbacks no VM leve | Sem estado de negócio persistente | Tela chama VM métodos |
| Seleção triagem | `ChangeNotifier` (`OnboardingTriageViewModel`) | `Set<TriageChallenge> selected`, `bool get canContinue => selected.isNotEmpty` | `ListenableBuilder` apenas no botão Continuar + lista de cards (cada card pode usar `ListenableBuilder` local ou rebuild do subset via keys) |
| Redirect global | `ChangeNotifier` (`OnboardingRedirectNotifier`) | `bool? isComplete` (null = loading), `Future<void> refresh()` | `GoRouter(refreshListenable: ...)` |
| Persistência (leitura inicial) | Future no notifier | Erro → tratar como incompleto (fail-safe para mostrar onboarding) | Router redirect |

**Proibido:** `setState` para seleção de cards ou flag de completo.

---

## Widgets

| Widget | Responsabilidade | const? |
|--------|------------------|--------|
| `OnboardingBlurOrbsBackground` | Stack com 2 `Container` circulares + `BackdropFilter` ou blur via decoração; animações breathe/float | não (AnimationController) |
| `OnboardingWelcomeScreen` | Scaffold sem AppBar; SafeArea; orbes + headline + subtitle + CTA + skip | parcial |
| `OnboardingSkipButton` | TextButton "Pular", semantics, min 48×48 | sim |
| `OnboardingTriageScreen` | Header + headline + lista + Continuar | não |
| `OnboardingProgressRing` | `CustomPaint` ou `CircularProgressIndicator` custom — ~40% (passo 2/2), 48×48 | sim |
| `TriageOptionCard` | Card individual; recebe `selected`, `onTap`, ícone, label | sim quando possível |
| Header triagem (inline ou widget) | Back 48×48 + progress ring + skip | parcial |

**Rebuild:** animações de orbes não devem rebuildar headline/CTA — usar `AnimatedBuilder` apenas no layer de fundo.

---

## ViewModels

| ViewModel | Responsabilidade | Dependências (UseCases) |
|-----------|------------------|-------------------------|
| `OnboardingWelcomeViewModel` | Encapsular `onStart` / `onSkip` (async complete + callback navegação) | `CompleteOnboardingUseCase` |
| `OnboardingTriageViewModel` | `toggle(TriageChallenge)`, `canContinue`, `onContinue`, `onSkip` | `CompleteOnboardingUseCase` |

**Regras:** sem `import 'package:flutter/material.dart'`; sem `BuildContext` nos VMs — telas passam callbacks `VoidCallback` / `Future<void> Function()` após `go_router` na camada presentation.

`dispose()` obrigatório nos VMs que estendem `ChangeNotifier`.

---

## Casos de uso

| UseCase | Input | Output | Erros |
|---------|-------|--------|-------|
| `IsOnboardingCompleteUseCase` | — | `Future<bool>` | Falha Isar → propagar; caller (redirect) trata como `false` |
| `GetOnboardingProfileUseCase` | — | `Future<OnboardingProfile?>` | idem |
| `CompleteOnboardingUseCase` | `List<TriageChallenge> challenges` | `Future<void>` | Falha de escrita → exibir estado de erro mínimo na tela (Snackbar opcional) sem bloquear skip futuro |

---

## Persistência

### Decisão: collection `OnboardingProfile` (feature data layer)

**Não estender `FluxMeta`.** `FluxMeta` permanece exclusivo para versionamento de schema/migrações (F00). Dados de produto do onboarding ficam na feature.

| Entidade | Collection Isar | Campos | Operações |
|----------|-----------------|--------|-----------|
| `OnboardingProfileModel` | `OnboardingProfile` | `Id id` fixo singleton **`1`**; `bool isComplete`; `DateTime? completedAt`; `List<String> challengeIds` (valores estáveis do enum) | `getProfile()`, `upsertProfile()` |

**Singleton:** sempre `id = 1`; primeira gravação cria o documento.

**Enum `TriageChallenge`** (domain) — valores estáveis alinhados ao HTML `data-value`:

| UI (pt-BR) | `id` / `data-value` |
|------------|---------------------|
| Procrastinação | `procrastination` |
| Esquecer tarefas | `forgetting` |
| Dificuldade de foco | `focus` |
| Ansiedade | `anxiety` |
| Começar algo novo | `starting` |

Após alterar schemas: `dart run build_runner build`, atualizar `DatabaseService` com `[FluxMetaSchema, OnboardingProfileSchema]`, incrementar `AppConstants.schemaVersion` se política do projeto exigir (documentar no PR).

---

## Navegação

| Rota | Path | Parâmetros | Origem |
|------|------|------------|--------|
| Welcome | `/onboarding` | — | Redirect guard (incompleto), deep link |
| Triagem | `/onboarding/triage` | — | CTA "Começar", redirect manual |
| Home (stub) | `/tasks` | — | Pós-complete, skip, redirect guard (completo) |

### Configuração `go_router`

- Manter `initialLocation: RoutePaths.tasks` (comportamento F00 para usuários que já completaram).
- `redirect` global (async permitido) usando `IsOnboardingCompleteUseCase`.
- `refreshListenable: onboardingRedirectNotifier` — chamar `notifier.refresh()` após `CompleteOnboardingUseCase`.
- Nested routes sob `GoRoute(path: '/onboarding', routes: [GoRoute(path: 'triage', ...)])` **ou** paths absolutos em `route_paths.dart` — preferir nested para hierarquia clara.

### Máquina de estados

```
        ┌─────────────┐
        │  /onboarding │  Welcome
        └──────┬──────┘
   Começar     │     Pular ──────────────┐
               ▼                         │
        ┌─────────────┐                  │
        │   /triage    │                  │
        └──────┬──────┘                  │
  Continuar    │  Pular                   │
  (≥1 sel)     │  (0+ sel)                │
               └──────────┬───────────────┘
                          ▼
                   persist isComplete
                          ▼
                     go(/tasks)
```

- **Voltar** na triagem: `context.pop()` para welcome (não limpar persistência).
- Usuário completo que digita `/onboarding` → redirect imediato para `/tasks`.

### Testabilidade do router

- Extrair factory `AppRouter.create({OnboardingRepository? repo, OnboardingRedirectNotifier? notifier})` ou injetar use case fake via parâmetro opcional **somente em `@visibleForTesting`** — espelhar padrão existente `AppRouter.create()`.

---

## Acessibilidade

- **Semantics:** headline como header (`header: true`); botões com label explícito ("Começar", "Continuar", "Pular", "Voltar").
- **Triage cards:** `button: true`, estado selecionado anunciado (`selected: true/false`), label = texto da opção.
- **Progress ring:** `Semantics(label: 'Passo 2 de 2')` ou valor percentual ~40%.
- **Contraste:** tokens `on-surface` / `on-primary` do tema; estado desabilitado do Continuar ainda legível (não depender só de opacidade 60% sem label).
- **Toque:** mínimo 48×48 dp em back, skip, cards (altura do card já > 48 com padding 24).
- **Screen reader:** ordem de foco: skip → conteúdo → ação primária; na triagem: voltar → progresso → skip → opções → continuar.
- **Motion:** respeitar `MediaQuery.disableAnimations` — orbes estáticos ou animação reduzida.

---

## Performance

- **Rebuild:** `ListenableBuilder` no CTA Continuar e por card se possível; evitar rebuild da tela inteira a cada toggle.
- **Animações:** 2 controllers no background welcome; `dispose()` no State do background ou screen.
- **Listas:** 5 itens fixos — `Column` aceitável; sem `ListView` pesado.
- **Redirect:** cache do bool `isComplete` no `OnboardingRedirectNotifier` após primeira leitura; refresh só após mutação.
- **Isar:** leituras no redirect devem ser O(1) por id fixo — não scan full collection.

---

## Testes obrigatórios

### Unit

- [ ] `IsOnboardingCompleteUseCase` — retorna `false` sem registro; `true` após upsert com `isComplete: true`.
- [ ] `CompleteOnboardingUseCase` — persiste challenges ordenados/estáveis; define `completedAt`; idempotente (segunda chamada mantém completo).
- [ ] `OnboardingRepositoryImpl` + fake/in-memory Isar (diretório temp como `database_service_test`) — get/upsert singleton id=1.
- [ ] Mapeamento enum ↔ strings Isar — round-trip dos 5 IDs.

### Widget

- [ ] **Welcome:** encontra headline e subtitle exatos; botão "Começar"; "Pular" visível; tap Começar invoca callback (mock VM).
- [ ] **Welcome:** tap Pular invoca skip callback.
- [ ] **Triage:** 5 labels presentes; Continuar desabilitado sem seleção; habilitado após 1 tap; desabilita se desselecionar tudo.
- [ ] **Triage:** card selecionado altera estilo (find by semantics selected ou key).
- [ ] **Triage:** "Pular" visível e tapável.
- [ ] **Triage:** botão voltar presente (48×48).

### Edge cases

- [ ] Redirect: perfil incompleto + `go(/tasks)` → acaba em `/onboarding`.
- [ ] Redirect: perfil completo + `go(/onboarding)` → `/tasks`.
- [ ] Skip welcome com DB vazio → `isComplete true`, challenges `[]`.
- [ ] Falha simulada de Isar no complete → app não entra em loop de redirect (estado fail-safe documentado).
- [ ] `refreshListenable` dispara novo redirect após complete (widget test com `AppRouter.create` + fake repo).

### Router (se viável)

- [ ] `initialLocation` permanece `/tasks` quando completo.
- [ ] Quando incompleto, navegação inicial efetiva para onboarding via redirect.

---

## Critérios de aceite

- [ ] Copy pt-BR **exata** do Stitch nas headlines, subtítulo, botões e 5 opções de triagem.
- [ ] Welcome: CTA 56 dp, pill, cor primary; fundo com 2 orbes animados (breathe/float).
- [ ] Welcome e triagem: **"Pular"** sempre visível e funcional.
- [ ] Triagem: back 48×48; anel de progresso ~40%; 5 cards multi-select com ícones corretos; estados visual selected conforme HTML.
- [ ] Continuar desabilitado até ≥1 seleção; habilitado com estilo primary.
- [ ] Fluxo: Começar → triagem → Continuar → `/tasks`; voltar retorna à welcome.
- [ ] Skip em qualquer etapa marca onboarding completo e vai para `/tasks` sem mensagem de culpa.
- [ ] Dados persistidos em Isar (`OnboardingProfile`); sobrevivem restart do app (teste manual ou unit).
- [ ] Guard: usuário completo não vê onboarding ao abrir app nem ao navegar para `/onboarding`.
- [ ] Guard: usuário novo é redirecionado de `/tasks` para `/onboarding`.
- [ ] `OnboardingStubScreen` não é mais a tela de produção.
- [ ] `flutter analyze` sem issues; testes listados passam.
- [ ] ViewModels sem imports de widgets; `dispose()` implementado.
- [ ] Nenhum package de estado proibido (Provider, Riverpod, Bloc, etc.).

---

## Análise complementar

### Dependências

Apenas packages já presentes após F00: `go_router`, `isar`, `isar_flutter_libs`, `path_provider`, `google_fonts`, dev `isar_generator`, `build_runner`. **Nenhum package novo.**

### Edge cases

- Primeiro launch: DB sem `OnboardingProfile` → incompleto.
- Reinstalação: DB limpo → onboarding reaparece (esperado).
- Deep link `/onboarding/triage` sem welcome: permitir se incompleto; se completo → redirect `/tasks`.
- Rotação / tamanho grande: headline welcome pode usar estilo `headline-xl` em width ≥ 600 (como HTML md breakpoint).
- Teclado: triagem sem campos de texto — sem overlap relevante.

### Analytics

N/A — sem instrumentação nesta task. Reservar hooks futuros em `CompleteOnboardingUseCase` (comentário `// TODO(analytics)` permitido, sem implementar).

### Riscos

| Risco | Mitigação |
|-------|-----------|
| Redirect async lento / flash de `/tasks` | `OnboardingRedirectNotifier` carrega antes do primeiro frame; considerar splash mínimo se flash persistir |
| Schema Isar novo quebra testes | Atualizar `database_service_test` e diretório temp |
| Loop redirect | Regras mutuamente exclusivas; testes de router |
| VM com `BuildContext` | Code review rejeita — callbacks na screen |

### Impacto em performance

Baixo: 2 animações contínuas apenas na welcome; redirect com 1 leitura Isar cached. Sem impacto mensurável esperado em cold start além de +1 query Isar.

### UX anti-paralisia

- Apenas **2 passos** (+ skip instantâneo para home).
- Copy acolhedor fixo do Stitch; **sem** contadores de erro, sem validação bloqueante no skip.
- Triagem opcional via skip; seleção múltipla sem limite máximo.
- Linguagem neutra (“o que mais te atrapalha **hoje**”) — sem julgamento.
- Botão Continuar claramente desabilitado vs habilitado (evita taps frustrados sem feedback).

---

```
---
PIPELINE_STATUS: TASK_READY
NEXT_AGENT: flutter-implementation
---
```
