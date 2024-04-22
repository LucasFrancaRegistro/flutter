import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); //cria e executa instância
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample Input',
      home: Forms(),
    );
  }
}

// classe formulário para entrada de dados
class Forms extends StatefulWidget {
  @override
  Login createState() => Login(); //instância
}

bool envio = false;

class Enviado extends StatelessWidget {
  final String title;

  const Enviado({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Pedido Confirmado!', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 18.0),
            !envio
                ? SizedBox(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                        child: Text('Voltar',
                            style: TextStyle(
                              color: Colors
                                  .black, // Altera a cor do texto para preto
                            )),
                      )
                    ],
                  ))
                : const SizedBox.shrink(),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

class Dels extends StatefulWidget {
  final String item;

  const Dels({super.key, required this.item});

  @override
  Detalhes createState() => Detalhes(item: item);
}

class Detalhes extends State<Dels> {
  final String item;
  final TextEditingController _item = TextEditingController();
  final TextEditingController _quantidade = TextEditingController();
  String _result = "";
  Color borderColorItem = Color.fromARGB(255, 0, 0, 0);
  Color borderColorQuantidade = Color.fromARGB(255, 0, 0, 0);

  void _enviar() {
    int quantidade = int.tryParse(_quantidade.text) ?? 0;

    void changeBorderColor(Color newColor) {
      setState(() {
        borderColorItem = newColor;
        borderColorQuantidade = newColor;
      });
    }

    // define resposta
    setState(() {
      if (quantidade == 0) {
        setState(() {
          borderColorQuantidade = Colors.red;
        });
        _result = "Quantidade deve ser peenchida!";
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Enviado(title: item)),
        );
      }
    });
  }

  Detalhes({Key? key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da compra'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Produto: ${item}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              // label para primeiro número
              width: 300,
              child: TextField(
                controller: _quantidade,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Quantidade',
                  prefixIcon: const Icon(Icons.format_list_numbered),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColorQuantidade),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            !envio
                ? SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _enviar,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                          child: const Text(
                            'Enviar',
                            style: TextStyle(
                              color: Colors
                                  .black, // Altera a cor do texto para preto
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 16.0),
            Text(
              _result,
              style: TextStyle(fontSize: 16.0, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class Login extends State<Forms> {
  final TextEditingController _nome = TextEditingController();
  Color textColor = Colors.black;
  Color borderColorNome = Color.fromARGB(255, 0, 0, 0);
  Color borderColorSenha = Color.fromARGB(255, 0, 0, 0);
  Color textColorWarning = Colors.grey; // default color
  Color borderColor = Colors.grey;
  // informações de envio
  String _result = "";
  String _selectItem = "";
  bool envio = false;

  // obtém item selecionado e armazena
  void changeSelectedItem(String e) {
    setState(() {
      _selectItem = e;
      _result = _selectItem;
    });
  }

  // botão de envio
  void _enviar() {
    //obtém informações do usuário

    String nome = _nome.text;

    // altera cor da borda
    void changeBorderColor(Color newColor) {
      setState(() {
        borderColorNome = Colors.red;
        borderColor = newColor;
      });
    }

    void changeEnvio(bool e) {
      setState(() {
        envio = e;
      });
    }

    // define resposta
    setState(() {
      if (nome == "") {
        _result = "Preencha seu nome!";
        setState(() {
          borderColorNome = Colors.red;
          borderColorSenha = Colors.red;
        });
      } else {
        changeBorderColor(Color.fromARGB(255, 0, 0, 0));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Q(nome: nome)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                // label para primeiro número
                width: 300,
                child: TextField(
                  controller: _nome,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Nome',
                    prefixIcon: const Icon(Icons.account_circle_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColorNome),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                )),
            const SizedBox(height: 25.0),
            !envio
                ? SizedBox(
                    // label para primeiro número
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _enviar,
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                          child: const Text(
                            'Enviar',
                            style: TextStyle(
                              color: Colors
                                  .black, // Altera a cor do texto para preto
                            ),
                          ),
                        )
                      ],
                    ))
                : const SizedBox.shrink(),
            const SizedBox(height: 16.0),
            Text(
              _result,
              style: TextStyle(fontSize: 16.0, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class Q extends StatefulWidget {
  final String nome;

  const Q({super.key, required this.nome});

  @override
  Quiz createState() => Quiz(nome: nome);
}

class Quiz extends State<Q> {
  final String nome;
  final TextEditingController _q1 = TextEditingController();
  final TextEditingController _q2 = TextEditingController();
  final TextEditingController _q3 = TextEditingController();
  final TextEditingController _q4 = TextEditingController();
  String _result = "";
  String _resultQ1 = "";
  String _resultQ2 = "";
  String _resultQ3 = "";
  String _resultQ4 = "";
  bool envio = false;
  int? selectedOption03;
  int? selectedOption04;

  String? selectedValue3;
  String? selectedValue4;

  List<bool> selectedOptions01 = [false, false, false, false];
  List<bool> selectedOptions02 = [false, false, false, false];

  Quiz({Key? key, required this.nome});

  
  Color borderColorResult = Color.fromARGB(255, 0, 0, 0);
  Color borderColorQ1 = Color.fromARGB(255, 0, 0, 0);
  Color borderColorQ2 = Color.fromARGB(255, 0, 0, 0);
  Color borderColorQ3 = Color.fromARGB(255, 0, 0, 0);
  Color borderColorQ4 = Color.fromARGB(255, 0, 0, 0);

  // Método para alterar a cor da borda
  void changeBorderColor(Color newColor, String question) {
    setState(() {
      if (question == "Q1") {
        borderColorQ1 = newColor;
      } else if (question == "Q2") {
        borderColorQ2 = newColor;
      } else if (question == "Q3") {
        borderColorQ3 = newColor;
      } else if (question == "Q4") {
        borderColorQ4 = newColor;
      }else if (question == "result") {
        borderColorResult = newColor;
      }
    });
  }

  void _enviar() {
    bool isQ1Filled = selectedOptions01.any((element) => element);
    bool isQ2Filled = selectedOptions02.any((element) => element);
    bool isQ3Filled = selectedOption03 != null;
    bool isQ4Filled = selectedOption04 != null;

    // Resetar mensagens de erro e cores das bordas antes de verificar novamente
    _result = "";
    _resultQ1 = "";
    _resultQ2 = "";
    _resultQ3 = "";
    _resultQ4 = "";
    changeBorderColor(Colors.black, "Q1");
    changeBorderColor(Colors.black, "Q2");
    changeBorderColor(Colors.black, "Q3");
    changeBorderColor(Colors.black, "Q4");

    if (!isQ1Filled || !isQ2Filled || !isQ3Filled || !isQ4Filled) {
      
        changeBorderColor(Colors.red, "result");
      _result = "Preencha os campos em vermelho!";

      if (!isQ1Filled) {
        changeBorderColor(Colors.red, "Q1");
        _resultQ1 = "Escolha uma opção";
      }
      if (!isQ2Filled) {
        changeBorderColor(Colors.red, "Q2");
        _resultQ2 = "Escolha uma opção";
      }
      if (!isQ3Filled) {
        changeBorderColor(Colors.red, "Q3");
        _resultQ3 = "Escolha uma opção";
      }
      if (!isQ4Filled) {
        changeBorderColor(Colors.red, "Q4");
        _resultQ4 = "Escolha uma opção";
      }
    } else {
      
        changeBorderColor(Colors.black, "result");
      _result = "Obrigado por responder às questões!\n";
      _result += "Suas escolhas foram:\n";
      _result += "Q1: " + _selectedOptionsToString(selectedOptions01) + "\n";
      _result += "Q2: " + _selectedOptionsToString(selectedOptions02) + "\n";
      _result += "Q3: Opção ${selectedOption03}\n";
      _result += "Q4: Opção ${selectedOption04}";
    }
  }

  String _selectedOptionsToString(List<bool> selectedOptions) {
    List<String> choices = [];
    for (int i = 0; i < selectedOptions.length; i++) {
      if (selectedOptions[i]) {
        int optionNumber = i + 1;
        choices.add("Opção $optionNumber");
      }
    }
    return choices.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: ConstrainedBox(

            constraints: const BoxConstraints(maxWidth:300),
            child: Column(
              
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0),
              Text('Aluno: $nome', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20.0),
              Text('Q01. Quais desses paises fazem parte da america do sul?', style: const TextStyle(fontSize: 18)),
              Text('$_resultQ1',
                  style: const TextStyle(fontSize: 10, color: Colors.red)),
              const SizedBox(height: 18.0),
              CheckboxListTile(
                  title: Text('Brasil'),
                  value: selectedOptions01[0],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions01[0] = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading),
              CheckboxListTile(
                  title: Text('Mexico'),
                  value: selectedOptions01[1],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions01[1] = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading),
              CheckboxListTile(
                  title: Text('Argetina'),
                  value: selectedOptions01[2],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions01[2] = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading),
              CheckboxListTile(
                title: Text('Cuba'),
                value: selectedOptions01[3],
                onChanged: (bool? value) {
                  setState(() {
                    selectedOptions01[3] = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 30),
              Text('Q02. Quais desses paises tem como idioma principal o espanhol?', style: const TextStyle(fontSize: 18)),
              Text('$_resultQ2',
                  style: const TextStyle(fontSize: 10, color: Colors.red)),
              const SizedBox(height: 18.0),
              CheckboxListTile(
                  title: Text('Chile'),
                  value: selectedOptions02[0],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions02[0] = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading),
              CheckboxListTile(
                  title: Text('Brasil'),
                  value: selectedOptions02[1],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions02[1] = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading),
              CheckboxListTile(
                  title: Text('Venezuela'),
                  value: selectedOptions02[2],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedOptions02[2] = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading),
              CheckboxListTile(
                title: Text('Uruguai'),
                value: selectedOptions02[3],
                onChanged: (bool? value) {
                  setState(() {
                    selectedOptions02[3] = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(height: 30),
              Text('Q03. Qual é o maior rio do mundo em volume de água??', style: const TextStyle(fontSize: 18)),
              Text('$_resultQ3',
                  style: const TextStyle(fontSize: 10, color: Colors.red)),
              SizedBox(height: 25),
              RadioListTile<int>(
                title: Text('Rio Nilo'),
                value: 1,
                groupValue: selectedOption03,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption03 = value;
                  });
                },
              ),
              RadioListTile<int>(
                title: Text('Rio Amazonas'),
                value: 2,
                groupValue: selectedOption03,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption03 = value;
                  });
                },
              ),
              RadioListTile<int>(
                title: Text('Rio Yangtze'),
                value: 3,
                groupValue: selectedOption03,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption03 = value;
                  });
                },
              ),
              RadioListTile<int>(
                title: Text('Rio Mississipi'),
                value: 4,
                groupValue: selectedOption03,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption03 = value;
                  });
                },
              ),
              SizedBox(height: 25),
              SizedBox(height: 30),
              Text('Q04. Qual desses países possui o menor território em área total?', style: const TextStyle(fontSize: 18)),
              Text('$_resultQ4',
                  style: const TextStyle(fontSize: 10, color: Colors.red)),
              SizedBox(height: 25),
              RadioListTile<int>(
                title: Text("Brasil"),
                value: 1,
                groupValue: selectedOption04,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption04 = value;
                  });
                },
              ),
              RadioListTile<int>(
                title: Text("Rússia"),
                value: 2,
                groupValue: selectedOption04,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption04 = value;
                  });
                },
              ),
              RadioListTile<int>(
                title: Text("Índia"),
                value: 3,
                groupValue: selectedOption04,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption04 = value;
                  });
                },
              ),
              RadioListTile<int>(
                title: Text("Vaticano"),
                value: 4,
                groupValue: selectedOption04,
                onChanged: (int? value) {
                  setState(() {
                    selectedOption04 = value;
                  });
                },
              ),
              SizedBox(height: 25),
              !envio
                  ? SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _enviar,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Enviar',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 16.0),
              Text(
                _result,
                style: TextStyle(fontSize: 16.0, color: borderColorResult),
              ),
            ],
          ),
        ),
          ),
        )
      ),
    );
  }
}
