# 1. Adocao de Monorepo para a Jornada Pratica

## Contexto

O projeto é um laboratório para estudo prático de arquitetura de
microserviços e será composto inicialmente por dois serviços
independentes, implementados com tecnologias diferentes:

- Order Service — Ruby on Rails;
- Payment Service — Java / Spring Boot.

Durante a evolução do projeto, novos serviços e componentes de
infraestrutura poderão ser adicionados.

Era necessário definir se cada serviço seria mantido em um
repositório Git independente ou se os componentes seriam organizados
em um único repositório.

## Decisão

Foi adotada uma estratégia de monorepo, mantendo os serviços,
infraestrutura local e documentação no mesmo repositório.

Cada serviço continuará possuindo ciclo próprio de desenvolvimento,
build e testes, apesar de compartilhar o mesmo repositório.

## Consequências

### Positivas

- visão centralizada do projeto;
- facilidade para reproduzir o ambiente completo;
- documentação arquitetural próxima ao código;
- alterações que envolvam mais de um componente podem ser
  rastreadas no mesmo repositório.

### Negativas

- crescimento do repositório conforme novos serviços forem adicionados;
- necessidade de pipelines capazes de identificar quais serviços
  foram alterados;
- maior cuidado para preservar a independência entre os serviços;
- mudanças em um serviço não devem exigir desnecessariamente
  build ou deploy dos demais.