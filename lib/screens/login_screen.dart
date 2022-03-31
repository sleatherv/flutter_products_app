import 'package:flutter/material.dart';
import 'package:products_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
   
  const LoginScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 10),
                    _LoginForm()
                  ],
                )
              ),
              const SizedBox(height: 50),
              const Text('Crear una nueva cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ],
          ),
        )
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        //Todo: Keep reference to KEY
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                  color: Colors.deepPurple
                  )
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2
                  )
                ),
                hintText: 'john.doe@example.com',
                labelText: 'Correo electrónico',
                labelStyle:  TextStyle(
                  color: Colors.grey
                ),
                prefixIcon: Icon(Icons.alternate_email_outlined, color: Colors.deepPurple)

              ),
            )
          ],
        )
      ),
    );
  }
}