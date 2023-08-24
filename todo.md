### Lista de Tarefas DW11
---
## dia 1

- [x] Criar Backend e configurar 
- [x] Criar projeto e adicionar dependências do Riverpod 
- [x] Adicionar Package AsyncState
- [x] Construir SplashPage
  - [x] Animação
  - [x] Redirect
- [x] Construir página de login 
- [x] Implementando RestClient 
- [x] Criar Application Providers
  - [x] Adicionar Dio 
- [x] Criar Funcional Return (Either) 
- [x] UserRepository.login 
- [x] User Login Service 
  - [x] SharedPreferences 

---
## dia 2

- [x] Refactoring
  - [x] Constants de imagens
  - [x] User login service provider
- [x] Implementar Login
  - [x] Form e validações
  - [x] VM e State
  - [x] Integrar com Service
  - [x] Criar "me provider" provider
    - [x] Modelo
    - [x] Auth Interceptor
      - [x] Add Token "onRequest" 
    - [x] Repository
    - [x] Provider
  - [x] Criar "my barbershop" provider
    - [x] Modelo
    - [x] Barbershop Repository
    - [x] Provider
  - [x] Invalidar cache de me e barbershop

---
## dia 3

- [x] Auth Interceptor
  - [x] Criar global nav key
  - [x] Expire token "OnError" 
- [x] Criar tela "Criar conta" usuário       
- [x] Implementar tela "criar conta" usuário
  - [x] UserRepository.registerAdm
  - [x] UserRegisterService
  - [x] VM e State 
- [x] Refactoring 
  - [x] Mover cadastro de usuário para a pasta Register/User    
- [x] Criar tela "criar conta" barbearia 
  - [x] Layout da tela
  - [x] WeekdaysPanel
  - [x] HoursPanel
- [x]Implementar tela "criar conta" barbearia    
  - [x] Repository
  - [x] VM e State
- [x] Refactoring SplashPage
  - [x] Identificar usuário logado
  - [x] Ajustar visualização da animação

---
## dia 4

- [x] Criar tela "Home ADM" 
  - [x] Header
  - [x] Employee Tile
- [x] Implementar tela "Home ADM"
  - [x] VM e State
  - [x] Implementar UserRepository.getEmployees
  - [x] Logout     
- [ ] Criar tela "Adicionar colaborador"
  - [ ] Criar componente AvatarWidget
  - [ ] Alterar componente de WeekdaysPanel, adicionando disabledDay
  - [ ] Alterar componente de HoursPanel, adicionando disabledHour
- [ ] Implementar tela "Adicionar colaborador"
  - [ ] VM e State
  - [ ] Implementar UserRepository.registerAdmAsEmployee
  - [ ] Implementar UserRepository.registerEmployee
  - [ ] VM.register
- [ ] Criar tela "Agendar cliente"
  - [ ]  Montar layout
  - [ ]  Criar componente "ScheduleCalendar"
    - [ ] Package table_calendar
    - [ ] Customizar layout  
  - [ ]  Customizar o HoursPanel permitindo única seleção


## Ideias para implementar:

- [ ] Se o usuário criou conta, mas não finalizou o cadastro do estabelecimento, ao fazer login, mandar direto para "Cadastrar estabelecimento"
- [ ] Incrementar formulários
  - [ ] Submit button = next para todos os fields menos o último
  - [ ] Submit button = save para o último field
  - [ ] Botão para trocar o obscureText em fields de senha
  - [ ] trocar o keyboard type para email e outros respectivos
  - [ ] Não deixar colocar espaço em fields de email
  - [ ] Retirar espaços em branco do começo e fim do campo de nome antes de enviar requisição (.trim())