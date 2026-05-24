# F04 — Timer Visual (Componente Compartilhado)

## 1. Metadados
- **Feature:** `shared/widgets/timer` e lógica de timer (base para `focus`)
- **Stitch:** `timer_modo_foco/code.html` (referência para o círculo e progresso)
- **Dependências:** F00
- **Estimativa:** M

## 2. Escopo e Objetivos
Criar um componente de timer circular de alta performance e a sua lógica de controlo, orientado a sessões curtas (TDAH-friendly).
- **Controller:** `FocusTimerController` utilizando `ValueNotifier` para gerir estado (correr, pausado, parado) e tempo restante.
- **Widget:** `CircularFocusTimer` que escuta apenas as mudanças de tempo (tick) para animar o anel de progresso sem reconstruir a árvore de widgets inteira.
- **Presets:** Suporte nativo para 2, 5 e 10 minutos.
- **Interações:** Pausa rápida e feedback visual suave.

## 3. Fora do Escopo
- Tela fullscreen de Focus Mode (F05).
- Efeitos sonoros premium ou complexos (Fase 3).
- Notificações locais em background profundo (F16).

## 4. Arquitetura e Performance
- `lib/shared/widgets/timer/focus_timer_controller.dart`
- `lib/shared/widgets/timer/circular_focus_timer.dart`
- **Regra estrita:** O rebuild do tick do relógio deve acontecer **apenas** no componente que desenha o anel e o texto do tempo (`ValueListenableBuilder`). Proibido usar `setState` no nível superior da tela.

## 5. Critérios de Aceite
- [ ] O Controller gere o `Timer` de Dart de forma segura (cancelando na destruição).
- [ ] O anel circular de progresso atualiza suavemente.
- [ ] Mudar de estado (pausar/retomar) funciona sem delays.

**PIPELINE_STATUS: TASK_READY**