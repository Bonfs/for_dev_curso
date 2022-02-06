import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/components.dart';
import './components/components.dart';
import './login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream?.listen((isLoading) {
            if(isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          presenter.mainErrorStream?.listen((error) {
            if (error != '') {
              showErrorMessage(context, error);
            }
          });

          presenter.navigateToStream?.listen((page) {
            if (page != '') {
              Get.offAllNamed(page);
            }
          });

          return GestureDetector(
            onTap: () => _hideKeyboard(context),
            child: SingleChildScrollView(
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
                          EmailInput(presenter),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 32),
                            child: PasswordInput(presenter),
                          ),
                          LoginButton(presenter),
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
            ),
          );
        }
      ),
    );
  }

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

class LoginContent extends StatelessWidget {
  final LoginPresenter presenter;

  LoginContent(this.presenter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _hideKeyboard(context),
      child: SingleChildScrollView(
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
                    EmailInput(presenter),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: PasswordInput(presenter),
                    ),
                    LoginButton(presenter),
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
      ),
    );
  }

  void _hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}


