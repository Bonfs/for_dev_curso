# Login Presenter

> ## Regras
1. ✅  Validar email com o Validation
2. ✅  Notificar o emailErrorStream com o resultado do Validation
3. ✅  Notificar o emailErrorStream com o uma String vazia  caso o Validation retorne erro
4. ✅  Notificar o isFormValidStream após validar o email
5. ✅  Validar senha com o Validation
6. ✅  Notificar o passwordErrorStream com o resultado do Validation
8. ✅  Notificar o isFormValidStream após validar a senha
9. ✅  Para o formulário estar válido todos os Streams de erro precisam estar vazios e todos os campos obrigatórios não podem estar vazios
10. ✅  Chamar o Authentication com email e senha corretos
11. ✅  Notificar o isLoadingStream como true antes de chamar o Authentication
12. ✅  Notificar o isLoadingStream como false no fim do Authentication
13. ✅  Notificar o mainErrorStream caso o Authentication retorne um DomainError
14. ✅  Fechar todos os Streams no dispose
15. ✅  Não notificar o emailErrorStream se o valor for igual ao último
16. ✅  Não notificar o isValidFormStream se o valor for igual ao último
17. ✅  Não notificar o passwordErrorStream se o valor for igual ao último
18. ✅  Gravar o Account no cache em caso de sucesso
19. ✅  Notificar o mainErrorStream caso o SaveCurrentAccount retorne erro
20. ✅  Levar o usuário para a tela de Enquetes em caso de sucesso