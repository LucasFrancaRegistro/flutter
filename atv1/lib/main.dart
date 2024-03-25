import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Navegação',
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Navegação',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();
  Color borderColorEmail = Colors.grey;
  Color borderColorSenha = Colors.grey;
  Color textColorEmail = Colors.black; // default color
  Color textColorSenha = Colors.black; // default color
  Color textColor = Colors.black; // default color
  Color borderColor = Colors.grey;
  String _result = "";
  bool envio = false;
  bool preenchido = true;

  @override
  void initState() {
    super.initState();

    //textEditingController.text = widget.inputValue;
  }

  void _enviar() {
    String email = _email.text;
    String senha = _senha.text;

    // altera state textColor
    void changeTextColor(Color newColor, String input) {
      setState(() {
        if (input == "email") {
          textColorEmail = newColor;
        }
        if (input == "senha") {
          textColorSenha = newColor;
        } else {
          borderColor = newColor;
        }
      });
    }

    void changeBorderColor(Color newColor, String input) {
      setState(() {
        if (input == "email") {
          borderColorEmail = newColor;
        }
        if (input == "senha") {
          borderColorSenha = newColor;
        }
        if (input == "todos") {
          borderColorEmail = newColor;
          borderColorSenha = newColor;
        } else {
          borderColor = newColor;
        }
      });
    }

    void changeEnvio(bool e) {
      setState(() {
        envio = e;
      });
    }

    setState(() {
      preenchido = true;
      changeBorderColor(Colors.grey, "todos");
      if (email == "") {
        preenchido = false;
        changeTextColor(Colors.red, "email");
        changeBorderColor(Colors.red, "email");
      }
      if (senha == "") {
        preenchido = false;
        changeTextColor(Colors.red, "senha");
        changeBorderColor(Colors.red, "senha");
      }
      if (preenchido) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ThirdPage()),
        );
      } else {
        _result = "Dados invalidos.";
      }
    });

    // altera cor da borda
  }

  void _cancelar() {
    _email.text = "";
    String email = _email.text;
    _senha.text = "";
    String senha = _senha.text;
    setState(() {
      _result = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Align(
          // corpo do aplicativo
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //const SizedBox(height: 100.0), // um retângulo para separar widgets
                const Text(
                  // label (texto)
                  'Sample Input',
                  style: TextStyle(fontSize: 24.0, color: Colors.blue),
                ),
                const SizedBox(
                    height: 10.0), // um retângulo contendo widget de entrada
                SizedBox(
                    // label para primeiro número
                    width: 300,
                    child: TextField(
                      controller: _email, // associa controle ao widget
                      keyboardType: TextInputType.text, // tipo de entrada
                      decoration: InputDecoration(
                        // customização
                        hintText: 'Entre com email', //hint
                        enabledBorder: OutlineInputBorder(
                          //borda ao redor da entrada
                          borderSide: BorderSide(
                              color: borderColorEmail), //cor da borda
                        ), //quando receber o foco, altera cor da borda
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    )),
                const SizedBox(
                    height: 10.0), // um retângulo contendo widget de entrada
                SizedBox(
                    // label para primeiro número
                    width: 300,
                    child: TextField(
                      controller: _senha, // associa controle ao widget
                      keyboardType: TextInputType.text, // tipo de entrada
                      decoration: InputDecoration(
                        // customização
                        hintText: 'Entre com senha', //hint
                        enabledBorder: OutlineInputBorder(
                          //borda ao redor da entrada
                          borderSide: BorderSide(
                              color: borderColorSenha), //cor da borda
                        ), //quando receber o foco, altera cor da borda
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                    )),
                const SizedBox(height: 10.0),
                // if ternário que controla exibição da resposta.
                // senão foi enviado, então apresenta botões
                // enviar e cancelar
                !envio
                    ? SizedBox(
                        // botões
                        width: 300,
                        // Row determina que os widgets serão acrescentados
                        // lado a lado
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: _enviar, // executa _enviar
                              child: const Text('Enviar'),
                            ),
                            ElevatedButton(
                              onPressed: _cancelar, // executa _cancelar
                              child: const Text('Cancelar'),
                            ),
                          ],
                        ))
                    : const SizedBox.shrink(), // espaço vazio
                const SizedBox(height: 10.0),
              ],
            ),
          )),
    );
  }
}

class ThirdPage extends StatelessWidget {
  final List<String> items = ["Item 1", "Item 2", "Item 3"];

  ThirdPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: const Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            
          ],
        )
        ),
    );
  }
}
