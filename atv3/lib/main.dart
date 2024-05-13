import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _rg = TextEditingController();
  final TextEditingController _senha = TextEditingController();
  Color buttonSave = Color.fromARGB(255, 227, 222, 252);
  Color buttonNext = const Color.fromARGB(255, 227, 222, 252);

  void changeButtonColor() {
    setState(() {
      buttonSave = Color.fromARGB(255, 91, 208, 56);
    });
  }

  @override
  void dispose() {
    _nome.dispose();
    _cpf.dispose();
    _rg.dispose();
    _senha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nome,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _cpf,
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _rg,
              decoration: const InputDecoration(labelText: 'RG'),
            ),
            TextField(
              controller: _senha,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final nome = _nome.text;
                final senha = _senha.text;
                final cpf = _cpf.text;
                final rg = _rg.text;

                final prefs = await SharedPreferences.getInstance();
                final nomeSaved = await prefs.setString("nome", nome);
                final senhaSaved = await prefs.setString("senha", senha);
                final cpfSaved = await prefs.setString("cpf", cpf);
                final rgSaved = await prefs.setString("rg", rg);
                changeButtonColor();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonSave,
              ),
              child: const Text('Salvar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => View()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonNext,
              ),
              child: const Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}

class View extends StatefulWidget {
  @override
  ViewData createState() => ViewData();
}

class ViewData extends State<View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        const SizedBox(height: 120,),
        FutureBuilder<Map<String, String>>(
          future: SharedPreferencesHelper.getCredentials(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final nome = snapshot.data!['nome'];
              final senha = snapshot.data!['senha'];
              final cpf = snapshot.data!['cpf'];
              final rg = snapshot.data!['rg'];
              return Text('Nome: $nome \nCPF: $cpf \nRG: $rg \nSenha: $senha');
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
          },
           child: const Text('Voltar'))
      ],
    )));
  }
}

class SharedPreferencesHelper {
  static const String _kNomeKey = 'nome';
  static const String _kSenhaKey = 'senha';
  static const String _kCpfKey = 'cpf';
  static const String _kRgKey = 'rg';

  // Retrieve username and password
  static Future<Map<String, String>> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final nome = prefs.getString(_kNomeKey);
    final senha = prefs.getString(_kSenhaKey);
    final cpf = prefs.getString(_kCpfKey);
    final rg = prefs.getString(_kRgKey);
    return {
      'nome': nome.toString(),
      'senha': senha.toString(),
      'cpf': cpf.toString(),
      'rg': rg.toString()
    };
  }
}
