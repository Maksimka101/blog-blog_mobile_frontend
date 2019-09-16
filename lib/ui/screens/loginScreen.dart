import 'package:blog_frontend/bloc/loginBloc.dart';
import 'package:blog_frontend/events/loginEvents.dart';
import 'package:blog_frontend/utils/validators.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen(this.loginBloc);
  final LoginBloc loginBloc;
  final _form = GlobalKey<FormState>();
  final _loginScreenValidator = LoginScreenValidator();

  // todo добавить выбор фото
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 75,
                child: Text("Выберите фото", style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic, fontWeight: FontWeight.w700),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(9))
                    ),
                    hintText: "Введите ваше имя",
                  ),
                  validator: _loginScreenValidator.nameValidator,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(9))
                    ),
                    hintText: "Введите ваш пароль",
                  ),
                  validator: _loginScreenValidator.firstPasswordValidator,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(9))
                    ),
                    hintText: "Подтвердите пароль",
                  ),
                  validator: _loginScreenValidator.secondPasswordValidator,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text("Зарегистрироваться", style: TextStyle(color: Colors.white, fontSize: 19),),
                  onPressed: () {
                    if (_form.currentState.validate()) {
                      final userName = _loginScreenValidator.userName;
                      final userPassword = _loginScreenValidator.userPassword;
                      // todo: add user avatar
                      loginBloc.authEvents.add(RegisterEvent(
                            userName: userName,
                            userPassword: userPassword,
//                    userAvatar: userAvatar
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
