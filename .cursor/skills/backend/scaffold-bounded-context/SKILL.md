---
name: scaffold-bounded-context
description: Gera a estrutura de pastas e arquivos base de um novo bounded context (DDD + Clean Architecture) em pacotes back-end. Use ao iniciar um novo contexto ou módulo de negócio.
disable-model-invocation: true
---

# Scaffold de Bounded Context (Back-end)

Cria a espinha dorsal de um novo bounded context em `package/<pacote>/src/contexts/<nome>/`.

## Entrada esperada
- Nome do pacote (ex.: `postolo-api`).
- Nome do contexto em kebab-case (ex.: `billing`, `identity`).
- Nome do primeiro aggregate root (ex.: `Account`, `User`).

## Estrutura a criar

```
package/<pacote>/src/contexts/<contexto>/
  domain/
    <aggregate>/
      <aggregate>.ts
      <aggregate>-id.ts
      events/
    errors/
  application/
    ports/
    use-cases/
    dtos/
  infra/
    persistence/
    http/
```

## Regras ao gerar
- `domain` e `application` NÃO importam framework/ORM/HTTP.
- Repositório: interface em `application/ports`, implementação em `infra/persistence`.
- Controllers/rotas HTTP em `infra/http/`; invocam use cases, não repos concretos.
- Use `Result<T, E>` para fluxos de negócio; erros de domínio como classes.
- Para cada use case, crie esqueleto de teste em `*.spec.ts`.

## Workflow

```
- [ ] 1. Confirmar pacote, contexto e aggregate root
- [ ] 2. Criar a árvore de pastas
- [ ] 3. Gerar Value Object de Id e Aggregate Root
- [ ] 4. Gerar port do repositório
- [ ] 5. Gerar use case inicial + DTOs
- [ ] 6. Gerar repositório in-memory para testes
- [ ] 7. Gerar teste do use case (TDD)
- [ ] 8. Rodar typecheck/test
```

Ao terminar, invoque `backend-architecture-guard` para validar fronteiras.
