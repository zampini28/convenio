class AuthExceptions implements Exception {
  static const Map<String, String> _errors = {
    'EMAIL_EXISTS': 'O endereço de e-mail já está sendo usado por outra conta',
    'OPERATION_NOT_ALLOWED': 'O login por senha está desativado para este projeto',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Bloqueamos todas as solicitações deste dispositivo devido a atividades incomuns. Tente mais tarde',
    'EMAIL_NOT_FOUND': 'E-mail não cadastrado',
    'INVALID_PASSWORD': 'Senha inválida',
    'USER_DISABLED': 'a conta de usuário foi desativada por um administrador.',
    'INVALID_LOGIN_CREDENTIALS': 'E-mail ou senha inválidos.',
  };
  final String error;

  const AuthExceptions({required this.error});

  @override
  String toString() {
    // TODO: implement toString
    return _errors[error] ?? 'Ocorreu um erro na autenticação';
  }
}