import 'dart:io';

/// class for extends
class LoginEvent {}

class RegisterEvent extends LoginEvent {
  RegisterEvent({
    this.userName,
    this.userPassword,
    this.userAvatar,
  });

  final String userName;
  final String userPassword;
  final File userAvatar;
}

class AuthenticateEvent extends LoginEvent {
  AuthenticateEvent({
    this.userName,
    this.userPassword,
  });

  final String userName;
  final String userPassword;
}

/// class for extends
class UiEventLogin {}

class UiEventRegister extends UiEventLogin {}

class UiEventAuthenticate extends UiEventLogin {}

class UiEventUserAuthenticated extends UiEventLogin {}

/// while user loading
class UiEventLoadUser extends UiEventLogin {}
