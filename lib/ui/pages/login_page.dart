import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: const Image(image: AssetImage('lib/ui/assets/logo.png')),
            ),
            Text('Login'.toUpperCase()),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email)
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      icon: Icon(Icons.lock)
                    ),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Entrar'.toUpperCase()),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text('Criar conta'),
                    icon: Icon(Icons.person),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}