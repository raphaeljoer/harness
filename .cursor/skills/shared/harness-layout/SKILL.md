---
name: harness-layout
description: Documenta a estrutura de pastas do monorepo harness — camada meta (.cursor) com skills/rules/agents separados por back-end e front-end, e pacotes livres em package/. Use ao navegar o repositório, criar arquivos ou quando não souber onde colocar código ou artefatos do harness.
---

# Estrutura de Pastas do Harness

Monorepo harness: configuração que orienta agentes de IA **e** pacotes de aplicação.

A separação back-end/front-end existe **apenas no harness** (skills, rules, agents) — não na pasta `package/`.

## Visão geral

```
harness/
├── AGENTS.md
├── .cursor/
│   ├── rules/                    # shared + regras back-end e front-end
│   ├── agents/
│   │   ├── backend/              # subagentes back-end
│   │   └── frontend/             # subagentes front-end
│   ├── skills/
│   │   ├── shared/
│   │   ├── backend/
│   │   └── frontend/
│   └── hooks/
└── package/
    └── <nome-do-pacote>/         # pacotes livres (ex.: postolo-client, postolo-api)
        └── src/
```

## O que vai onde

| O que | Onde |
| --- | --- |
| Regras transversais | `.cursor/rules/` (ex.: `00-core-principles.mdc`) |
| Regras de back-end | `.cursor/rules/clean-architecture.mdc`, `ddd-*.mdc` |
| Regras de front-end | `.cursor/rules/frontend-architecture.mdc` |
| Subagentes back-end | `.cursor/agents/backend/` |
| Subagentes front-end | `.cursor/agents/frontend/` |
| Skills transversais | `.cursor/skills/shared/` |
| Skills back-end | `.cursor/skills/backend/` |
| Skills front-end | `.cursor/skills/frontend/` |
| Código de aplicação | `package/<nome>/` |

## Antes de agir: identifique o tipo de trabalho

Pacotes em `package/` são **livres** — não há subpasta backend/frontend. Identifique o tipo pelo **contexto da tarefa** e pela **estrutura interna do pacote**:

| Sinal | Tipo | Use |
| --- | --- | --- |
| Bounded context, use cases, domínio | back-end | subagentes `backend-*`, skills em `backend/` |
| Features, componentes, UI, rotas | front-end | subagentes `frontend-*`, skills em `frontend/` |

Artefatos do harness (rules, agents, skills) ficam sempre em `.cursor/`.

## Estrutura interna — back-end

```
package/<pacote>/
  src/
    contexts/<bounded-context>/
      domain/
      application/
      infrastructure/
      presentation/
    shared/
```

Dependências: `presentation → application → domain ← infrastructure`

## Estrutura interna — front-end

```
package/<pacote>/
  src/
    app/
    features/<feature>/
      components/
      hooks/
      api/
      types/
    shared/
```

Regras: lógica de negócio no back-end; front consome contratos da API.

## Pacotes conhecidos

| Pacote | Tipo | Caminho |
| --- | --- | --- |
| `postolo-client` | front-end | `package/postolo-client/` |

Novos pacotes: kebab-case, diretamente em `package/<nome>/`.

## Checklist ao criar arquivos

1. **Back-end ou front-end?** → escolha subagentes e skills do tipo correto
2. **Bounded context?** → skill `scaffold-bounded-context`
3. **Feature de UI?** → skill `scaffold-feature`
4. **Regra/convenção?** → `.cursor/rules/`
5. **Subagente?** → `.cursor/agents/backend/` ou `frontend/`
6. **Workflow repetível?** → `.cursor/skills/<tipo>/`

## Referências

- [AGENTS.md](../../../../AGENTS.md)
- Back-end: `.cursor/rules/clean-architecture.mdc`
- Front-end: `.cursor/rules/frontend-architecture.mdc`
