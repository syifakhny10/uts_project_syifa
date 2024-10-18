import 'package:flutter/material.dart';
import 'package:uts_project_syifa/databases/user_database.dart';
import 'package:uts_project_syifa/models/validation_email.dart';

class LoginPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    bool loginSuccess = false;

    // Mencari email dan password yang cocok di database
    for (var data in databases) {
      if (data.email == email && data.password == password) {
        loginSuccess = true;
        break; // Berhenti jika ditemukan
      }
    }

    if (loginSuccess) {
      Navigator.pushNamed(context, '/Home'); // Navigasi ke Home jika login berhasil
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email atau Password salah!'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form( // Bungkus dalam Form
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 100, color: Colors.blueGrey),
              SizedBox(height: 20),

              // Kolom email
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  } else if (!isEmailValid(value)) {
                    return "Email tidak valid";
                  }
                  return null;
                },
              ),

              // Kolom password
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password harus di-isi';
                  } else if (value.length < 8) {
                    return 'Password harus 8 karakter';
                  }
                  return null;
                },
                obscureText: true,
              ),

              // Tombol Login
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    login(context); // Pass context ke fungsi login
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cek Inputan Anda!'))
                    );
                  }
                },
                child: Text('Login'),
              ),

              // Text "Register"
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Belum Punya Akun?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
