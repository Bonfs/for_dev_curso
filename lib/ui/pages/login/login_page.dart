import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.isLoadingStream.listen((isLoading) {
            if(isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return SimpleDialog(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(height: 10),
                          Text('Aguarde...', textAlign: TextAlign.center)
                        ],
                      ),
                    ],
                  );
                }
              );
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if (error != '') {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red[900],
                  content: Text(error, textAlign: TextAlign.center),
                )
              );
            }
          });

          return LoginContent(widget.presenter);
        }
      ),
    );
  }
}

class LoginContent extends StatelessWidget {
  final LoginPresenter presenter;

  LoginContent(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoginHeader(),
          const Headline1(text: 'Login'),
          Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              child: Column(
                children: [
                  StreamBuilder<String>(
                    stream: presenter.emailErrorStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                          errorText: snapshot.data?.isEmpty == true ? null : snapshot.data,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: presenter.validateEmail,
                      );
                    }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 32),
                    child: StreamBuilder<String>(
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
                    ),
                  ),
                  StreamBuilder<bool>(
                    stream: presenter.isFormValidStream,
                    builder: (context, snapshot) {
                      return ElevatedButton(
                        onPressed: snapshot.data == true ? presenter.auth : null,
                        child: Text('Entrar'.toUpperCase()),
                      );
                    }
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: const Text('Criar conta'),
                    icon: const Icon(Icons.person),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}