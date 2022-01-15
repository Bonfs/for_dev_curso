import 'package:flutter/material.dart';

import '../login_presenter.dart';

class PasswordInput extends StatelessWidget {
  final LoginPresenter presenter;

  PasswordInput(this.presenter);

  @override
  Widget build(BuildContext context) {
    // final presenter = context.watch<LoginPresenter>();
    return StreamBuilder<String>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Senha',
            icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
            errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
          ),
          obscureText: true,
          onChanged: presenter.validatePassword,
        );
      }
    );
  }
}