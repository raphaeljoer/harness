# Harness — Sistema de Trabalho com Agentes de IA (DDD + Clean Architecture + TypeScript)

Este repositório é um *harness*: regras, subagentes, skills e hooks que orientam
agentes de IA (Cursor) a construir software TypeScript com qualidade verificável.

A separação **back-end / front-end** existe no harness (skills, rules, agents).
Os **pacotes** em `package/` são livres — sem subpastas por tipo.

## Como o sistema está organizado

| Camada do harness | Onde vive | Para que serve |
| --- | --- | --- |
| **Rules** | `.cursor/rules/*.mdc` | Conhecimento persistente (shared, back-end, front-end) |
| **Subagentes back-end** | `.cursor/agents/backend/*.md` | DDD, use cases, Clean Architecture |
| **Subagentes front-end** | `.cursor/agents/frontend/*.md` | Features, componentes, integração com API |
| **Skills shared** | `.cursor/skills/shared/*/SKILL.md` | Transversal (layout do monorepo) |
| **Skills back-end** | `.cursor/skills/backend/*/SKILL.md` | Scaffolding de bounded context, etc. |
| **Skills front-end** | `.cursor/skills/frontend/*/SKILL.md` | Scaffolding de feature, etc. |
| **Hooks** | `.cursor/hooks.json` + `.cursor/hooks/*` | Automação em eventos |
| **Pacotes** | `package/<nome>/` | Código de aplicação (livres, sem divisão por tipo) |

## Pacotes de aplicação

```
package/
  postolo-client/       # front-end
  postolo-api/          # back-end (futuro)
  ...
```

Identifique back-end vs front-end pelo **contexto da tarefa** e pela **estrutura interna do pacote**, não pelo caminho em `package/`.

## Arquitetura back-end (Clean Architecture)

```
package/<pacote>/src/
  contexts/<bounded-context>/
    domain/
    application/
    infra/
  shared/
```

```
infra ─▶ application ─▶ domain
```

Três camadas back-end: `domain`, `application` e `infra` (controllers/HTTP ficam em `infra/`).

## Arquitetura front-end (por features)

```
package/<pacote>/src/
  app/
  features/<feature>/
    components/
    hooks/
    api/
    types/
  shared/
```

Lógica de negócio fica no back-end; front consome contratos da API.

## Fluxo de trabalho — back-end

1. **Modelar** → `backend-domain-modeler`
2. **Planejar** → use cases e ports
3. **TDD** → `backend-test-runner`
4. **Implementar** → `backend-implementer`
5. **Guardar arquitetura** → `backend-architecture-guard`
6. **Verificar** → `backend-verifier`
7. **Segurança** → `backend-security-reviewer` (quando aplicável)

## Fluxo de trabalho — front-end

1. **Modelar** → `frontend-feature-modeler`
2. **Planejar** → componentes, hooks, contratos de API
3. **TDD** → `frontend-test-runner`
4. **Implementar** → `frontend-implementer`
5. **Guardar arquitetura** → `frontend-architecture-guard`
6. **Verificar** → `frontend-verifier`
7. **Segurança** → `frontend-security-reviewer` (quando aplicável)

## Convenções rápidas

- TypeScript estrito; sem `any` implícito; erros como tipos/`Result`, não strings cruas.
- Back-end: domínio puro, testável sem mocks de infra.
- Front-end: sem domínio rico no client; HTTP apenas na camada `api/`.
- Um conceito por arquivo; nomes refletem a linguagem ubíqua do contexto.

> Detalhes em `.cursor/rules/`. Mapa de pastas na skill `harness-layout`.
