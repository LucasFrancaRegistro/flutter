import 'package:atv2/QuestionsPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _nome = TextEditingController();
  Color textColor = Colors.black; // default color
  Color borderColor = Colors.grey;
  bool envio = false;
  String _result = "";

  void _enviar() {
    String nome = _nome.text;

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
      if (nome == "") {
        _result = "Inisra o seu nome";
        changeTextColor(Colors.red);
        changeBorderColor(Colors.red);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuestionsPage()),
        );
      }
    });
  }

  void _cancelar() {
    _nome.text = "";
    String nome = _nome.text;
    setState(() {
      _result = nome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(height: 10.0), // um retângulo contendo widget de entrada
          SizedBox(
              // label para primeiro número
              width: 300,
              child: TextField(
                controller: _nome, // associa controle ao widget
                keyboardType: TextInputType.text, // tipo de entrada
                decoration: InputDecoration(
                  // customização
                  hintText: 'Entre com o seu nome', //hint
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
          !envio
              ? SizedBox(
                  width: 300,
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
    ));
  }
}
