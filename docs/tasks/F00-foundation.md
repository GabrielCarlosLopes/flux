# Task: F00 — Fundação do app

> Gerado por: flutter-task-writer  
> Data: 2026-05-24

---

## Referência visual (Stitch)

| Item | Caminho |
|------|---------|
| Design system | `/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/serene_focus/DESIGN.md` |
| Tela(s) HTML | N/A — F00 não implementa telas de produto; apenas tokens globais e shells de navegação |

**Tokens obrigatórios a espelhar em `lib/core/theme/`:**

| Token (DESIGN.md) | Uso em Flutter |
|-------------------|----------------|
| `colors.*` (surface, primary `#4a654e`, secondary, tertiary, error, etc.) | `ColorScheme` light + dark |
| `typography.*` (headline-xl/lg, body-lg/md, label-md) | `TextTheme` via Hanken Grotesk |
| `rounded.*` (sm → full) | `BorderRadius` constants |
| `spacing.*` (unit 8px, margins, gutter, section-gap) | `AppSpacing` |
| Touch 48×48 dp, botões primários ~56 dp | `ThemeData` / `FilledButtonTheme` |
| Cards ≥ 24 px radius, pills nos CTAs | `CardTheme`, `ButtonStyle` |

**Dark mode:** seguir nota do DESIGN.md (base charcoal, acentos dessaturados ~15%). Não inventar paleta fora do YAML.

---

## Contexto

O projeto Flux está em estado inicial: `lib/main.dart` contém o template counter do Flutter (com erros de sintaxe no estado atual), `pubspec.yaml` só declara `flutter` e `cupertino_icons`, e existem apenas READMEs placeholder em `lib/core/`, `lib/features/` e `lib/shared/`.

A task **F00** (ROADMAP — Fase 0) é pré-requisito de todas as features (F01–F09+). Sem tema Serene Focus, roteamento centralizado, bootstrap Isar e estrutura de pastas alinhada à arquitetura do pipeline, nenhuma feature de negócio pode ser implementada de forma consistente.

---

## Objetivo

Entregar o **shell executável** do app Flux: tema Material 3 espelhando Serene Focus, `MaterialApp.router` com `go_router`, rotas stub por feature, Isar inicializado com schema mínimo, e remoção completa do demo counter — com `flutter analyze` limpo e navegação manual entre stubs verificável.

---

## Escopo

1. **Dependências (`pubspec.yaml`)**
   - Adicionar: `go_router`, `isar`, `isar_flutter_libs`, `path_provider`, **`google_fonts`** (autorizado — ver Análise complementar → Dependências).
   - Dev: `isar_generator`, `build_runner`.
   - Manter `cupertino_icons` se já usado; não adicionar outros packages sem autorização.

2. **Tema (`lib/core/theme/`)**
   - `app_colors.dart` — cores do DESIGN.md como `Color` constants (hex do YAML).
   - `app_spacing.dart` — unit 8, margins 24/80, gutter 24, section-gap 64.
   - `app_radius.dart` — sm (8), default (16), md (24), lg (32), xl (48), full.
   - `app_typography.dart` — mapeamento headline-xl/lg/lg-mobile, body-lg/md, label-md → estilos Flutter; família **Hanken Grotesk** via `GoogleFonts.hankenGrotesk()` (ou `textTheme` aplicado no `ThemeData`).
   - `app_theme.dart` — `ThemeData` light + dark (`brightness`), `ColorScheme.fromSeed` **não** usar seed genérico; aplicar cores explícitas do design system; `useMaterial3: true`; temas de botão/card/input alinhados às notas de componentes (altura primária ~56, `minimumSize` touch 48×48).

3. **Navegação (`lib/core/navigation/`)**
   - `route_paths.dart` — constantes de path (deep-link ready).
   - `app_router.dart` — `GoRouter` central, `initialLocation` em `/tasks`, redirect/guards **não** implementar (F01).
   - Rotas stub para: onboarding, tasks (home), focus, routines, insights, settings, premium.

4. **Persistência / Isar (`lib/core/`)**
   - `lib/core/services/database_service.dart` — singleton ou factory: `init()` abre Isar com `path_provider`, `close()` no dispose do app se aplicável.
   - Schema mínimo: collection `FluxMeta` (ex.: `id`, `schemaVersion`, `createdAt`) para validar geração Isar e migrações futuras — sem entidades de negócio.
   - Executar `build_runner` para gerar `*.g.dart`.

5. **App root**
   - `lib/app.dart` — widget raiz com `MaterialApp.router`, `theme` / `darkTheme` / `themeMode: ThemeMode.system`, `routerConfig`.
   - `lib/main.dart` — `WidgetsFlutterBinding.ensureInitialized()`, `await DatabaseService.init()`, `runApp(const FluxApp())`; **remover** `MyApp`, `MyHomePage`, counter e imports mortos.

6. **Stubs por feature (`lib/features/<name>/presentation/screens/`)**
   - Uma tela stub por feature listada na arquitetura, usando widget compartilhado.
   - Cada stub exibe: nome da feature, path atual, tema aplicado (amostra visual mínima: `primary` swatch ou texto com `Theme.of(context).colorScheme.primary`), e menu de navegação para as demais rotas.

7. **Shared (`lib/shared/widgets/`)**
   - `feature_stub_screen.dart` — layout simples, acessível, sem lógica de negócio.
   - `stub_navigation_menu.dart` — lista de `TextButton`/`ListTile` que chamam `context.go(path)` para todas as rotas stub.

8. **Testes**
   - Substituir `test/widget_test.dart` (counter) por testes alinhados ao novo shell.
   - Adicionar testes em `test/core/` conforme seção Testes obrigatórios.

9. **Limpeza**
   - Remover código e comentários do template counter.
   - Garantir `flutter analyze` sem issues.

---

## Fora do escopo

- Qualquer feature de negócio (onboarding real, tarefas, timer, rotinas, insights, paywall, settings funcionais).
- UI fiel aos `code.html` do Stitch (apenas tokens globais).
- ViewModels, UseCases, Repositories por feature.
- Guards de rota (ex.: redirecionar se onboarding incompleto) — F01.
- Shell navigation (bottom bar, drawer) — task futura.
- Sync cloud, auth, analytics.
- Packages além dos autorizados nesta task (`go_router`, `isar`, `isar_flutter_libs`, `path_provider`, `google_fonts`, dev `isar_generator`, `build_runner`).
- Fontes bundled em `assets/fonts/` (alternativa documentada, não implementar em F00 salvo falha de `google_fonts`).
- Golden tests contra HTML.
- `lib/core/config/` avançado, injeção de dependências global, flavors.

---

## Arquivos afetados

| Ação | Caminho |
|------|---------|
| Modificar | `pubspec.yaml` |
| Modificar | `lib/main.dart` |
| Criar | `lib/app.dart` |
| Criar | `lib/core/constants/app_constants.dart` |
| Criar | `lib/core/theme/app_colors.dart` |
| Criar | `lib/core/theme/app_spacing.dart` |
| Criar | `lib/core/theme/app_radius.dart` |
| Criar | `lib/core/theme/app_typography.dart` |
| Criar | `lib/core/theme/app_theme.dart` |
| Criar | `lib/core/navigation/route_paths.dart` |
| Criar | `lib/core/navigation/app_router.dart` |
| Criar | `lib/core/services/database_service.dart` |
| Criar | `lib/core/data/models/flux_meta.dart` |
| Criar | `lib/core/data/models/flux_meta.g.dart` (gerado) |
| Criar | `lib/shared/widgets/feature_stub_screen.dart` |
| Criar | `lib/shared/widgets/stub_navigation_menu.dart` |
| Criar | `lib/features/onboarding/presentation/screens/onboarding_stub_screen.dart` |
| Criar | `lib/features/tasks/presentation/screens/tasks_stub_screen.dart` |
| Criar | `lib/features/focus/presentation/screens/focus_stub_screen.dart` |
| Criar | `lib/features/routines/presentation/screens/routines_stub_screen.dart` |
| Criar | `lib/features/insights/presentation/screens/insights_stub_screen.dart` |
| Criar | `lib/features/settings/presentation/screens/settings_stub_screen.dart` |
| Criar | `lib/features/premium/presentation/screens/premium_stub_screen.dart` |
| Modificar | `test/widget_test.dart` |
| Criar | `test/core/services/database_service_test.dart` |
| Criar | `test/core/navigation/app_router_test.dart` |
| Criar | `test/widget/app_smoke_test.dart` |
| Manter (conteúdo informativo) | `lib/core/README.md`, `lib/features/README.md`, `lib/shared/README.md` |
| Atualizar (opcional, pós-implementação) | `docs/tasks/README.md` — linha F00 → `F00-foundation.md` / concluído |

**Remover implicitamente de `lib/main.dart`:** classes `MyApp`, `MyHomePage`, `_MyHomePageState` e todo o fluxo counter.

---

## Fluxo de dados

F00 não implementa fluxo ViewModel → UseCase → Repository. Apenas bootstrap e navegação declarativa:

```
main()
  → WidgetsFlutterBinding.ensureInitialized()
  → DatabaseService.init()
       → path_provider: application documents directory
       → Isar.open([FluxMetaSchema], name: app_constants.isarName)
  → runApp(FluxApp)
       → MaterialApp.router(routerConfig: AppRouter.create())
            → GoRoute → *StubScreen (StatelessWidget)
                 → StubNavigationMenu → context.go(otherPath)
```

**Leitura futura (fora de F00):** features passarão a injetar repositórios que usam `DatabaseService.instance.isar` (ou getter equivalente), nunca `Isar.open` na UI.

---

## Estados

| Estado | Tipo listenable | Campos | Quem observa |
|--------|-----------------|--------|--------------|
| N/A | — | F00 não introduz estado reativo de feature; stubs são `StatelessWidget`; tema segue `ThemeMode.system` do SO via `MaterialApp`. | — |

**Nota:** Não usar `setState` para estado de negócio. Se necessário loading durante `DatabaseService.init()`, usar `Future` em `main` antes de `runApp` (sem ChangeNotifier em F00).

---

## Widgets

| Widget | Responsabilidade | const? |
|--------|------------------|--------|
| `FluxApp` | Root: `MaterialApp.router`, temas light/dark | Sim |
| `FeatureStubScreen` | Scaffold stub: título feature, path, amostra de tema | Parâmetros const onde possível |
| `StubNavigationMenu` | Lista de destinos com `go()` para testar rotas | Preferir const children |
| `OnboardingStubScreen` | Wrapper fino → `FeatureStubScreen` | Sim |
| `TasksStubScreen` | Home stub (`/tasks`) | Sim |
| `FocusStubScreen` | Stub focus | Sim |
| `RoutinesStubScreen` | Stub routines | Sim |
| `InsightsStubScreen` | Stub insights | Sim |
| `SettingsStubScreen` | Stub settings | Sim |
| `PremiumStubScreen` | Stub premium | Sim |

**Regras:** sem lógica de negócio em `build()`; navegação apenas via callbacks/`context.go` no menu.

---

## ViewModels

| ViewModel | Responsabilidade | Dependências (UseCases) |
|-----------|------------------|-------------------------|
| N/A | F00 não cria ViewModels | — |

---

## Casos de uso

| UseCase | Input | Output | Erros |
|---------|-------|--------|-------|
| N/A | F00 não define casos de uso de domínio | — | — |

---

## Persistência

| Entidade | Collection Isar | Operações |
|----------|-----------------|-----------|
| `FluxMeta` | `FluxMeta` | Schema placeholder: CRUD mínimo em teste (put + get) para validar DB; app em runtime pode apenas abrir DB sem writes obrigatórios na UI |

**`DatabaseService` contrato esperado:**

- `static Future<void> init()` — idempotente ou falha clara se já aberto.
- `static Isar get instance` (ou `isar`) — lança `StateError` se não inicializado.
- `static Future<void> close()` — para testes.
- Nome do banco via `AppConstants.isarName` (ex. `flux_db`).

**Geração:** `@collection` em `flux_meta.dart`; `part 'flux_meta.g.dart';`; comando documentado: `dart run build_runner build --delete-conflicting-outputs`.

---

## Navegação

| Rota | Path | Parâmetros | Origem |
|------|------|------------|--------|
| Tasks (home inicial) | `/tasks` | — | `initialLocation` do `GoRouter` |
| Onboarding | `/onboarding` | — | Stub menu / deep link |
| Focus | `/focus` | — | Stub menu |
| Routines | `/routines` | — | Stub menu |
| Insights | `/insights` | — | Stub menu |
| Settings | `/settings` | — | Stub menu |
| Premium | `/premium` | — | Stub menu |

**Implementação:**

- Constantes em `RoutePaths` (ex. `static const tasks = '/tasks'`).
- `GoRouter` em `app_router.dart` com um `GoRoute` por path → builder retorna stub correspondente.
- `debugLogDiagnostics: kDebugMode` opcional.
- Sem rotas aninhadas/shell nesta task.
- Preparar comentário/TODO para rotas com parâmetro (`/tasks/:id`) em F02 — não implementar agora.

**Export pattern (futuro):** cada feature poderá exportar `List<RouteBase> get routes`; em F00 todas as rotas podem viver em `app_router.dart` com comentário para extrair por feature depois.

---

## Acessibilidade

- **Semantics / labels:** cada item do `StubNavigationMenu` com `Semantics(label: 'Ir para …')` ou `tooltip` descritivo em pt-BR.
- **Contraste:** cores do `ColorScheme` devem respeitar pares on-surface/on-primary do DESIGN.md (meta AAA para texto principal).
- **Tamanho de toque:** `minimumSize: Size(48, 48)` em botões do menu stub; alinhar com design system.
- **Screen reader:** título da feature no `AppBar` ou `Semantics(header: true)`; anunciar rota atual no stub body de forma legível.

---

## Performance

- **Escopo de rebuild:** stubs stateless; navegação via `go_router` não rebuilda app inteiro desnecessariamente.
- **Listas / animações:** menu stub com poucos itens (`Column` fixa OK); sem animações pesadas em F00.
- **Timers:** N/A.

**Isar:** abrir uma única instância no startup; não reabrir por navegação.

---

## Testes obrigatórios

### Unit

- [ ] `DatabaseService.init()` abre Isar e `FluxMeta` schema está registrado (usar diretório temporário / `Isar.initializeIsarCore` se necessário no ambiente de teste).
- [ ] `DatabaseService.close()` permite re-init em teste sequencial.
- [ ] Put/get de `FluxMeta` em teste isolado.

### Widget

- [ ] `FluxApp` pump sem exceção; encontra texto indicando home/tasks stub.
- [ ] Tema light: `Theme.of(context).colorScheme.primary` corresponde a `#4a654e` (ou `AppColors.primary`).
- [ ] Tap em item do menu navega para outra rota (ex. onboarding → texto "Onboarding" ou título equivalente).
- [ ] `flutter analyze` limpo (verificação CI local).

### Edge cases

- [ ] `DatabaseService.instance` antes de `init` — comportamento definido (throw `StateError`).
- [ ] Navegação para path inválido — `GoRouter` error page ou comportamento padrão aceitável (documentar se usar `errorBuilder` simples).
- [ ] Dark mode: pump com `platformDispatcher` / `themeMode` dark e verificar `brightness == Brightness.dark` no `MaterialApp`.

---

## Critérios de aceite

- [ ] App inicia sem crash após `flutter pub get` + `build_runner` + `flutter run`.
- [ ] `MaterialApp.router` ativo; counter demo **ausente** do codebase.
- [ ] Tema Serene Focus: primary sage `#4a654e`, background/surface alinhados ao DESIGN.md em light; dark theme presente e coerente com nota de dark mode.
- [ ] Tipografia Hanken Grotesk aplicada no `TextTheme` (verificável visualmente ou via `GoogleFonts` no widget tree).
- [ ] Navegação entre **todas** as 7 rotas stub via menu funciona.
- [ ] `initialLocation` é `/tasks`.
- [ ] Isar inicializa no startup; collection `FluxMeta` gerada e testada.
- [ ] `flutter analyze` — zero issues.
- [ ] Testes listados acima passam com `flutter test`.
- [ ] Nenhum package proibido (Provider, Riverpod, Bloc, etc.) adicionado.

---

## Análise complementar

### Dependências

| Package | Tipo | Justificativa |
|---------|------|---------------|
| `go_router` | dep | Navegação central (ROADMAP F00) |
| `isar` | dep | Persistência local |
| `isar_flutter_libs` | dep | Binários Isar Flutter |
| `path_provider` | dep | Diretório para arquivo Isar |
| `google_fonts` | dep | **Autorizado nesta task.** DESIGN.md exige Hanken Grotesk; ROADMAP F00 lista apenas 4 packages, mas tipografia é requisito de aceite do design system. `google_fonts` evita bundling de múltiplos pesos TTF em F00, é padrão Flutter, e permite iteração rápida. **Alternativa futura (fora de F00):** `assets/fonts/` + `pubspec` `fonts:` para offline estrito. |
| `isar_generator` | dev | Gera `flux_meta.g.dart` |
| `build_runner` | dev | Runner para Isar |
| `flutter`, `cupertino_icons` | existentes | Manter |

**Versões:** usar versões compatíveis com SDK `^3.11.5`; resolver conflitos com `flutter pub outdated` se necessário.

### Edge cases

- Primeiro launch sem rede: `google_fonts` pode cachear após primeiro fetch; documentar que primeiro frame pode usar fallback até fonte carregar (aceitável em F00; mitigação futura = bundle local).
- Hot restart após `DatabaseService.init()` — garantir não duplicar instância Isar (singleton ou guard).
- Testes em CI sem path_provider real — usar `Directory.systemTemp` ou API de teste Isar.

### Analytics

N/A — sem telemetria em F00.

### Riscos

| Risco | Mitigação |
|-------|-----------|
| Conflito de versão Isar / SDK | Fixar versões no `pubspec` após primeiro `pub get` bem-sucedido |
| `build_runner` não executado | Documentar no PR/commit; CI pode falhar analyze se `.g.dart` ausente |
| Desvio de cores vs DESIGN.md | Usar hex literal do YAML; review visual na QA |
| ROADMAP proíbe packages extras | `google_fonts` explicitamente autorizado neste documento |

### Impacto em performance

- Startup: +1 async `DatabaseService.init()` antes de `runApp` — aceitável; manter mínimo.
- `google_fonts`: download assíncrono na primeira execução — impacto baixo pós-cache.
- Isar open: típico <100ms em dispositivo moderno para schema vazio.

### UX anti-paralisia

- Stubs devem ser **visualmente calmos**: fundo surface do tema, sem listas densas, copy pt-BR simples (“Área: Tarefas — em construção”).
- Menu de navegação claro, sem mais de 7 itens, ordem alfabética ou ordem do ROADMAP — evitar sobrecarga.
- Não exibir erros técnicos ao usuário em caso de falha de DB no startup — em produção F00 pode usar `FlutterError`/`runZonedGuarded` mínimo; preferir falha fast em debug apenas.

---

```
---
PIPELINE_STATUS: TASK_READY
NEXT_AGENT: flutter-implementation
---
```
