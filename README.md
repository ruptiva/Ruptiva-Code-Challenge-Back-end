# Ruptiva - Code Challenge Back-end

## Introdução

Este é um desafio utilizado como teste de desenvolvimento Back-end pela Ruptiva.

Na empresa, desenvolvemos diversos projetos de aplicativos e sistemas web, portanto, algumas ferramentas são necessárias para manter o desenvolvimento sadio do projeto desde sua fase de planejamento até sua fase de implementação em produção.

Das ferramentas que costumamos utilizar:

- Ruby on Rails
- Postgresql
- git
- Heroku
- docker-compose

O pessoal do front-end utiliza React e ReactNative.

Neste teste serão avaliados:

- Funcionalidade - todas especificações atendidas
- Código - o código limpo utilizando boas práticas de desenvolvimento e [estilo](https://github.com/github/rubocop-github/blob/master/STYLEGUIDE.md)
- Tratamento de exceção - erros retornados pela aplicação estão formatados
- Commits - realização constante de commits com descrições significativas
- Documentação
 

## Requisitos Técnicos
`Gems` que serão usadas:

- [rails](https://github.com/rails/rails)
- [devise_token_auth](https://github.com/lynndylanhurley/devise_token_auth)
- [pundit](https://github.com/varvet/pundit)
- [rspec](https://github.com/rspec/rspec-rails)

Fique à vontade para escolher qualquer versão das gems.

Caso inclua mais gems no seu projeto, deve ser acompanhada de descrição do que a `gem` faz.


## Requisitos Funcionais
Será desenvolvida uma RESTful JSON API em Ruby on Rails com CRUD de usuários, permissões e testes.

#### Usuários
- Permitir cadastro de usuário (não há necessidade de criação de um usuário por outro usuário)
- Permitir login através de `email` e `password`
- Permitir visualização de usuário
- Permitir update de usuários
- Permitir listar usuários
- Permitir exclusão de usuário por soft-delete

##### Observações
- O model `User` deve conter um campo `role`, com opções `user` e `admin`, default `user`.
- Considerar a seguinte estrutura JSON abaixo: 
```
{
  "first_name": "João",
  "last_name": "da Silva",
  "email": "joao@email.com",
  "password": "12345678",
  "password_confirmation": "12345678"
}
```

#### Permissões
- Impedir que usuários não autenticados acessem qualquer informação
- Usuários `admin` tem acesso a todos registros
- Usuários `user` tem acesso somente ao seu próprio registro

#### Testes
Os testes devem ser executados utilizando [rspec](https://github.com/rspec/rspec-rails) e devem compreender:

- Testes de model
- Testes de request
- O que julgar necessário

#### Seed
Popular os dados do usuário administrador usando `db/seeds.rb`
```
{
  "first_name": "Maikel",
  "last_name": "Bald",
  "email": "maikel@ruptiva.com",
  "password": "ilikeruptiva",
  "role": "admin"
}
```

#### Documentação
O sistema de login e os demais endpoints devem ser documentados.

Utilize postman, apiary, swagger, blueprint ou alguma ferramenta para te auxiliar nesta tarefa.


## Entrega
- Criar um repositório público ou privado para avaliação do time Ruptiva
- Criar um `README.md` no repositório com informações de como rodar a aplicação desenvolvida
- A partir do momento que você recebeu este teste, tem 7 dias corridos para execução do teste. Caso não consiga entregar no prazo, avise com antecedência
- O contato deve ser feito pelo do e-mail maikel@ruptiva.com

