import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isRegister = false;
  final nameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.restaurant, size: 72, color: Colors.orange),
                  SizedBox(height: 8),
                  Text('Culinaria', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 32),
                  if (isRegister)
                    TextField(controller: nameC, decoration: InputDecoration(labelText: 'Nama', border: OutlineInputBorder())),
                  if (isRegister) SizedBox(height: 12),
                  TextField(controller: emailC, decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
                  SizedBox(height: 12),
                  TextField(controller: passC, decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()), obscureText: true),
                  SizedBox(height: 20),
                  if (state is AuthLoading)
                    CircularProgressIndicator()
                  else ...[
                    ElevatedButton(
                      onPressed: () {
                        if (isRegister) {
                          context.read<AuthBloc>().add(RegisterEvent(name: nameC.text, email: emailC.text, password: passC.text));
                        } else {
                          context.read<AuthBloc>().add(LoginEvent(email: emailC.text, password: passC.text));
                        }
                      },
                      child: Text(isRegister ? 'Daftar' : 'Masuk'),
                      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 48)),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () => setState(() { isRegister = !isRegister; nameC.clear(); emailC.clear(); passC.clear(); }),
                      child: Text(isRegister ? 'Sudah punya akun? Masuk' : 'Belum punya akun? Daftar'),
                    ),
                  ],
                  if (state is AuthError) ...[SizedBox(height: 8), Text(state.message, style: TextStyle(color: Colors.red))],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
