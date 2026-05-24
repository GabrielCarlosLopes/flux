# F02 — Domínio e Persistência de Tarefas

## 1. Metadados
- **Feature:** `tasks` (Camadas de Domínio e Dados)
- **Stitch:** N/A (Apenas camada de dados e lógica)
- **Dependências:** F00
- **Estimativa:** M

## 2. Escopo e Objetivos
Criar a fundação de dados para gerir tarefas, garantindo a regra de negócio central: **apenas uma tarefa "ativa" por vez (One Task Mode)**.
- Entidades: `Task`, `Microtask`.
- Propriedades: título, status (enum), microtasks (lista), prioridade humana (enum), energia sugerida (enum), timestamps.
- Repositório e UseCases para: criar, listar inbox, obter "tarefa atual", concluir, arquivar.
- Implementação local usando **Isar**.

## 3. Fora do Escopo
- UI/Ecrãs de listas ou detalhes de tarefas.
- Sincronização com a Cloud (Cloud sync).
- Integração com IA.

## 4. Arquitetura (MVVM / Clean Architecture leve)
- `lib/features/tasks/domain/entities/task.dart`
- `lib/features/tasks/domain/entities/microtask.dart`
- `lib/features/tasks/domain/repositories/task_repository.dart`
- `lib/features/tasks/data/models/task_model.dart` (Isar Collection)
- `lib/features/tasks/data/datasources/task_local_data_source.dart`
- `lib/features/tasks/data/repositories/task_repository_impl.dart`

## 5. Critérios de Aceite
- [ ] As entidades `Task` e `Microtask` existem.
- [ ] O `TaskModel` está decorado com anotações do Isar.
- [ ] O repositório impõe a regra de que só pode haver uma tarefa `active`.
- [ ] Os UseCases estão testados e operacionais.

**PIPELINE_STATUS: TASK_READY**