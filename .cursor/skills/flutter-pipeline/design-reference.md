# Referência de layout — Stitch Focus Flow ADHD

> **Fonte única de verdade visual.** Todo layout, cores, tipografia e composição de telas devem seguir estes arquivos — não inventar UI fora deste pacote.

## Caminho raiz

```
/Users/gabriellopes/Downloads/stitch_focus_flow_adhd/
```

No workspace multi-root do Cursor, a pasta também aparece como `stitch_focus_flow_adhd/` na raiz do workspace.

## Design system (tokens globais)

| Recurso | Caminho |
|---------|---------|
| Cores, tipografia, spacing, brand | `serene_focus/DESIGN.md` |
| Nome do tema | **Serene Focus** |
| Fonte | Hanken Grotesk |
| Filosofia | Executive Function Support — minimalismo + glassmorphism, baixa carga cognitiva |

Implementar tokens em `lib/core/theme/` espelhando os valores de `DESIGN.md` (Material 3 + cores customizadas).

## Mapa tela → feature → HTML

| Pasta Stitch | Feature Flux | Tela / fluxo |
|--------------|--------------|--------------|
| `onboarding_bem_vindo/` | `onboarding` | Boas-vindas |
| `onboarding_triagem/` | `onboarding` | Triagem inicial |
| `home_one_task_mode/` | `tasks` | Home — One Task Mode |
| `timer_modo_foco/` | `focus` | Timer / modo foco |
| `estou_travado_micro_passos/` | `tasks` ou `focus` | Micro-passos (“estou travado”) |
| `brain_dump_captura_r_pida/` | `tasks` | Brain dump / captura rápida |
| `insights_estat_sticas_amig_veis/` | `insights` | Estatísticas amigáveis |

Cada pasta contém `code.html` — **referência visual obrigatória** para implementação Flutter (estrutura, hierarquia, espaçamentos, copy em pt-BR).

## Regras para agentes

### Task Writer

- Listar qual(is) `code.html` e `DESIGN.md` aplicam à task
- Critérios de aceite devem incluir fidelidade visual ao HTML de referência

### Implementation

- **Ler** o `code.html` correspondente antes de codificar widgets
- **Ler** `serene_focus/DESIGN.md` para cores, radius, spacing, tipografia
- Não alterar copy, hierarquia ou densidade visual sem task explícita
- Touch targets mínimos 48×48 dp; botões primários ~56 dp altura
- Cantos arredondados generosos (cards ≥ 24 px; pills nos CTAs)

### Code Review

- Verificar aderência ao HTML de referência e ao design system
- Rejeitar paletas/tipografia inventadas fora de `DESIGN.md`

### QA Test

- Widget/golden tests quando possível contra estrutura da tela de referência
- Dark mode: seguir `darkMode: "class"` dos HTMLs (Tailwind)

## O que NÃO fazer

- Inventar layouts sem abrir o `code.html` da feature
- Usar cores/fontes fora de `serene_focus/DESIGN.md`
- Copiar Tailwind literalmente — traduzir para Flutter (`ThemeData`, `TextTheme`, `BoxDecoration`)

## Exemplo de citação na task

```markdown
## Referência visual
- Design system: `stitch_focus_flow_adhd/serene_focus/DESIGN.md`
- Tela: `stitch_focus_flow_adhd/timer_modo_foco/code.html`
```
