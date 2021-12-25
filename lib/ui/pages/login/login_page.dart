import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/components.dart';
import 'components/components.dart';
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
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if (error != '') {
              showErrorMessage(context, error);
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
            child: Provider(
              create: (_) => presenter,
              child: Form(
                child: Column(
                  children: [
                    EmailInput(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: PasswordInput(),
                    ),
                    LoginButton(),
                    TextButton.icon(
                      onPressed: () {},
                      label: const Text('Criar conta'),
                      icon: const Icon(Icons.person),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


