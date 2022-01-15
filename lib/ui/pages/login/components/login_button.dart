import 'package:flutter/material.dart';

import '../login_presenter.dart';

class LoginButton extends StatelessWidget {
  final LoginPresenter presenter;

  LoginButton(this.presenter);

  @override
  Widget build(BuildContext context) {
    // final presenter = context.watch<LoginPresenter>();
    return StreamBuilder<bool>(
      stream: presenter.isFormValidStream,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.data == true ? presenter.auth : null,
          child: Text(
            'Entrar'.toUpperCase(), 
            style: const TextStyle(color: Colors.white),
          ),
        );
      }
    );
  }
}