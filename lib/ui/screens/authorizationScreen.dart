import 'package:blog_frontend/bloc/loginBloc.dart';
import 'package:blog_frontend/events/loginEvents.dart';
import 'package:blog_frontend/utils/validators.dart';
import 'package:flutter/material.dart';

class AuthorizationScreen extends StatefulWidget {
  AuthorizationScreen(this.loginBloc);

  final LoginBloc loginBloc;

  @override
  _AuthorizationScreenState createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  BuildContext _context;
  final _authScreenValidator = AuthScreenValidator();
  final _form = GlobalKey<FormState>();

  void _listenEvent(UiEventLogin event) {
    switch (event.runtimeType) {
      case UiEventAuthenticateError:
        _showAlert((event as UiEventAuthenticateError).errorMessage);
        break;
    }
  }

  void _showAlert(String message) => showDialog(
      context: _context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
            title: Text('Что то пошло не так'),
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Ok'),
              )
            ],
          ));

  @override
  Widget build(BuildContext context) {
    _context = context;
    Future.delayed(Duration(seconds: 0))
        .then((_) => widget.loginBloc.uiEvents.listen(_listenEvent));
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: CircleAvatar(
                  radius: 75,
                  child: Text('App logo', style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    hintText: "Введите ваше имя",
                  ),
                  validator: _authScreenValidator.nameValidator,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(9))),
                    hintText: "Введите ваш пароль",
                  ),
                  validator: _authScreenValidator.passwordValidator,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text("Авторизоваться", style: TextStyle(color: Colors.white, fontSize: 19),),
                  onPressed: () {
                    if (_form.currentState.validate()) {
                      final userName = _authScreenValidator.userName;
                      final userPassword = _authScreenValidator.userPassword;
                      widget.loginBloc.authEvents.add(AuthenticateEvent(
                        userPassword: userPassword,
                        userName: userName,
                      ));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
