---
name: scaffold-feature
description: Gera a estrutura de pastas e arquivos base de uma nova feature em pacotes front-end. Use ao iniciar uma funcionalidade de UI.
disable-model-invocation: true
---

# Scaffold de Feature (Front-end)

Cria a espinha dorsal de uma feature em `package/<pacote>/src/features/<nome>/`.

## Entrada esperada
- Nome do pacote (ex.: `postolo-client`).
- Nome da feature em kebab-case (ex.: `billing`, `auth`).
- Tela ou fluxo principal (ex.: `InvoiceList`, `LoginForm`).

## Estrutura a criar

```
package/<pacote>/src/features/<feature>/
  components/
  hooks/
  api/
  types/
  index.ts
```

Se for rota nova, registrar em `src/app/`.

## Regras ao gerar
- Lógica de negócio permanece no back-end; front orquestra UI e consome API.
- Componentes de apresentação não acessam fetch/axios diretamente — use `api/`.
- Tipos espelham contratos do back-end; não duplique regras de domínio.
- Para componentes interativos, crie teste em `*.spec.tsx` ou `*.test.tsx`.

## Workflow

```
- [ ] 1. Confirmar pacote, feature e tela principal
- [ ] 2. Criar a árvore de pastas
- [ ] 3. Gerar tipos/DTOs em types/
- [ ] 4. Gerar funções em api/
- [ ] 5. Gerar componente principal em components/
- [ ] 6. Gerar hook se houver estado compartilhado
- [ ] 7. Exportar via index.ts
- [ ] 8. Registrar rota em src/app/ se aplicável
- [ ] 9. Gerar teste do componente/hook
```

Ao terminar, invoque `frontend-architecture-guard` para validar fronteiras.
