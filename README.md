# Freelancer Platform (TreinaDev 7)

Projeto final da 1ª etapa do TreinaDev - Feito em Rails

## Diagrama de classe sem cargos de Usuários

Diagrama feito com: [Visual Paradigm Online](https://online.visual-paradigm.com/)
![](public/readme/class-diagram-without-roles.png)

Também tenho a versão do diagrama [com Roles de usuário](public/readme/class-diagram-with-roles.png), porém será ignorado.

## Project Started

```sh
# Don't run this command
╰─❯ rails new freelancer-platform --skip-action-mailbox --skip-active-storage --skip-action-cable
# Disabled Gems: 'rack-mini-profiler', 'web-console', 'selenium-webdriver' and 'webdriver'
```

## Ruby version

- Ruby v3.0.2 | Rails >= 6.1.4.1

## System dependencies

- Make sure [_NodeJS_](https://nodejs.org/en/) and [_Yarn_](https://classic.yarnpkg.com/lang/en/docs/install) is installed:
- All Rails stuff;
- Devise - Login & Auth manager;
- Rspec-Rails - Unit & Web UI tests;
- Capybara - Web UI tests;
- SimpleCov - Cover better all validation tests

## Configuration

```sh
bundle install
```

## Database creation

```sh
rails db:migrate
```

## Database initialization

```sh
rails db:seed
```

## How to run the test suite

```sh
rspec
```

## Services (job queues, cache servers, search engines, etc.)

> ...

## Deployment instructions

```sh
rails server
```

Access the server via browser on: _localhost:3000_

### Logins

#### Login as User

| E-mail        | Password |
| ------------- | -------- |
| user@test.com | 123456   |
| test@test.com | 123456   |

#### Login as Freelancer

| E-mail              | Password |
| ------------------- | -------- |
| freelancer@test.com | 123456   |
| test@test.com       | 123456   |
| test2@test.com      | 123456   |
