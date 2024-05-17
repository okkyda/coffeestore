import 'package:coffin/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_authentic.dart'; 

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuthentic _authentic = FirebaseAuthentic();

  void _register(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      User? user = await _authentic.registerWithEmailAndPassword(email, password);
      if (user != null) {
      
        print('User registered successfully: ${user.email}');
        _showSuccessDialog(context); 
      } else {
       
        print('Failed to register. Please try again.');
      }
    } catch (e) {
      print('Error registering user: $e');
    }
  }

  
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Registrasi berhasil"),
          content: Text("Selamat datang, enjoyyy"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text("OK"),
              
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.green,
                Colors.lightGreen,
                Colors.greenAccent,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Hello, Please register first",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      RegisterForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        onRegister: () => _register(context),
                      ),
                      TextButton(
                        child: Text(
                          'Udah punya akun kan? Coba Login',
                          style: TextStyle(color: Colors.green),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onRegister;

  const RegisterForm({
    required this.emailController,
    required this.passwordController,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Register',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Email",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: "Password",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
            obscureText: true,
          ),
        ),
        SizedBox(height: 20),
        MaterialButton(
          color: Colors.green,
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: onRegister,
        ),
      ],
    );
  }
}
