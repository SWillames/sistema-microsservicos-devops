# Sistema microsservicos devops

Laboratório prático para estudo de arquitetura de microsserviços, DevOps,
comunicação entre serviços e resiliência.

O projeto evolui de forma incremental. Novos serviços, padrões e componentes
de infraestrutura são adicionados conforme surgem necessidades que justifiquem
seu uso.

## Estrutura do projeto

Este projeto utiliza uma estrutura de monorepo, mantendo os serviços,
infraestrutura e documentação no mesmo repositório.

```text
sistema-microsservicos-devops/
├── .github/
│   └── workflows/
│       └── ci.yml
├── docs/
│   └── adr/
│       └── 001-estrategia-monorepo.md
├── service-orders/
├── docker-compose.yml
└── README.md
```
A decisão pela utilização de monorepo está documentada nos ADRs do projeto.

## Estado atual

O primeiro serviço implementado é o **Order Service**, desenvolvido como
uma API utilizando Ruby on Rails.

Atualmente o serviço possui:

- criação de pedidos;
- listagem de pedidos;
- consulta de pedido por identificador;
- persistência em PostgreSQL;
- validações das regras de domínio;
- testes automatizados com RSpec;
- cobertura de testes monitorada com SimpleCov;
- cobertura mínima definida em 90%.

No estado atual do projeto, a suíte possui **13 testes**, todos passando,
e apresenta **100% de cobertura de linhas**.

## Integração Contínua

O projeto possui uma pipeline inicial utilizando GitHub Actions.

A pipeline é executada automaticamente em:

- pushes para a branch `main`;
- pull requests direcionados para a branch `main`.

Atualmente a pipeline valida a configuração da infraestrutura definida no
arquivo `docker-compose.yml`.

Os testes automatizados e a validação da cobertura ainda são executados
localmente.

A próxima evolução da pipeline será incorporar a execução dos testes e
utilizar a cobertura mínima de 90% como critério de qualidade para integração
de código.

## Próximas etapas

Entre as próximas evoluções previstas para o laboratório estão:

- integrar os testes automatizados à pipeline de CI;
- utilizar a cobertura mínima de testes como quality gate;
- implementar o Payment Service utilizando Java e Spring Boot;
- iniciar a comunicação entre os serviços;
- evoluir a arquitetura conforme novos problemas e necessidades surgirem.

As decisões arquiteturais relevantes serão registradas em ADRs conforme
o projeto evoluir.