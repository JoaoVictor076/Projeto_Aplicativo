import 'package:flutter/material.dart';

import '../models/task_item.dart';
import 'calendar_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLogin = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submitAuth() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty ||
        (!_isLogin && _nameController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos para continuar.'),
        ),
      );
      return;
    }

    final userName =
        _isLogin ? _emailController.text.split('@').first : _nameController.text;

    Navigator.of(context).pushNamed(
      CalendarScreen.routeName,
      arguments: {
        'userName': userName,
        'tasks': <TaskItem>[],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF42047E), Color(0xFF07F49E), Color(0xFFFF6EC7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: 360,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                color: const Color(0xFF1E0A3C).withValues(alpha: 0.86),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.task_alt_rounded,
                      size: 70, color: Colors.cyanAccent),
                  const SizedBox(height: 12),
                  Text(
                    _isLogin ? 'Login futurista' : 'Crie sua conta',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (!_isLogin)
                    _buildTextField(
                      controller: _nameController,
                      icon: Icons.person,
                      hint: 'Nome completo',
                    ),
                  _buildTextField(
                    controller: _emailController,
                    icon: Icons.mail,
                    hint: 'E-mail',
                  ),
                  _buildTextField(
                    controller: _passwordController,
                    icon: Icons.lock,
                    hint: 'Senha',
                    obscureText: true,
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _submitAuth,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF00F5D4),
                        foregroundColor: const Color(0xFF180339),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        _isLogin ? 'Entrar' : 'Cadastrar',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin
                          ? 'Não tem conta? Cadastre-se agora'
                          : 'Já tem conta? Voltar para login',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white60),
          filled: true,
          fillColor: const Color(0xFF3C1361),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
