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
          textColor = newColor;
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
          MaterialPageRoute(builder: (context) => ItensPage()),
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
                Image.network("https://images.freeimages.com/vhq/images/previews/214/generic-logo-140952.png", height: 100, width: 200,),
                //const SizedBox(height: 100.0), // um retângulo para separar widgets
                const Text(
                  // label (texto)
                  'Login',
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

class ItensPage extends StatefulWidget {
  const ItensPage({super.key});

  @override
  ItensPageState createState() => ItensPageState();
}

class ItensPageState extends State<ItensPage> {
  final List<String> items = ["produto 1", "Produto 2", "Produto 3"];
  String _result = "";
  String _selectedItem = "";
  bool envio = false;
  Color textColor = Colors.red;

  void enviar() {
    String selecionado = _selectedItem;

    setState(() {
      if (selecionado == "") {
        _result = "Selecione um item";
      }
    });
  }

  void changeSelectedItem(String e) {
    setState(() {
      _selectedItem = e;
      _result = _selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text("Podutos",
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
              ),
               const Divider(),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(items[index]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductPage(title: items[index])));
                        },
                      );
                    }),
              ),
            ],
          )),
    );
  }
}

class ProductPage extends StatefulWidget {
  final String title;
  const ProductPage({
    super.key,
    required this.title,
  });

  @override
  // ignore: no_logic_in_create_state
  ProductPageState createState() => ProductPageState(title: title);
}

class ProductPageState extends State<ProductPage> {
  final TextEditingController _quantidade = TextEditingController();
  Color textColor = Colors.black; // default color
  Color borderColor = Colors.grey;
  final String title;
  String _result = "";
  bool envio = false;

  ProductPageState({required this.title});

  void _enviar() {
    String quantidade = _quantidade.text;

    // altera state textColor
    void changeTextColor(Color newColor) {
      setState(() {
        borderColor = newColor;
      });
    }

    void changeBorderColor(Color newColor) {
      setState(() {
        borderColor = newColor;
      });
    }

    void changeEnvio(bool e) {
      setState(() {
        envio = e;
      });
    }

    setState(() {
      changeBorderColor(Colors.grey);
      if (quantidade == "") {
        _result = "Dados invalidos.";
        changeTextColor(Colors.red);
        changeBorderColor(Colors.red);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EndPage()),
        );
      }
    });

    // altera cor da borda
  }

  void _cancelar() {
    _quantidade.text = "";
    String quantidade = _quantidade.text;
    setState(() {
      _result = quantidade;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
      ),
      body: Center(
          child: Column(children: [
        Text(
          'Produto: ${widget.title}',
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10.0), // um retângulo contendo widget de entrada
        SizedBox(
            // label para primeiro número
            width: 300,
            child: TextField(
              controller: _quantidade, // associa controle ao widget
              keyboardType: TextInputType.text, // tipo de entrada
              decoration: InputDecoration(
                // customização
                hintText: 'Entre com a quantidade que deseja', //hint
                enabledBorder: OutlineInputBorder(
                  //borda ao redor da entrada
                  borderSide: BorderSide(color: borderColor), //cor da borda
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
      ])),
    );
  }
}

class EndPage extends StatelessWidget {
  const EndPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagina final"),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network("https://freesvg.org/img/logo-generic.png", height: 300, width: 600,),
            const Text(
              "Pedido confirmado!",
              style: TextStyle(fontSize: 24.0, color: Colors.blue),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ItensPage()),
                );
              }, // executa _enviar
              child: const Text('Voltar'),
            )
          ],
        ),
      ),
    );
  }
}
