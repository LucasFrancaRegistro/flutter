import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  QuestionsPageSate createState() => QuestionsPageSate();
}

class QuestionsPageSate extends State<QuestionsPage> {
  
  Map<String, bool> checked = {
    'Checkbox 1': false,
    'Checkbox 2': false,
    'Checkbox 3': false,
  };

  Map<String, bool> checked2 = {
    'Checkbox 1': false,
    'Checkbox 2': false,
    'Checkbox 3': false,
  };

  Map<String, List<Widget>> respostas = {
    'questao 1': checkboxes
  };

  void _showSelected() {
    List<String> selected = [];
    checked.forEach((String key, bool value) {
      if (value) {
        selected.add(key);
      }
     });
  }

  List<Widget> _buildCheckboxes() {
    List<Widget> checkboxes = [];
    // percorre todos os itens armazendos na estrutura
    // Map (chave, valor), obtendo os valores
    checked.forEach((String key, bool value) {
      checkboxes.add(
        // adiciona um item ao checkbox
        CheckboxListTile(
          title: Text(key), //adiciona título
          value: value, // define valor
          // implementa evento onChage para gerenciar
          // valor do checkbox
          onChanged: (newValue) {
            //recebe valor atual
            setState(() {
              //altera o estado da variável
              newValue != null
                  ? //se diferente de null
                  //alterna valor entre verdadeiro e falso
                  checked[key] == true
                      ? checked[key] = false
                      : checked[key] = true
                  : checked[key] = false;
            });
          },
        ),
      );
    });
    return checkboxes;
  }

  List<Widget> _buildCheckboxes2() {
    List<Widget> checkboxes = [];
    // percorre todos os itens armazendos na estrutura
    // Map (chave, valor), obtendo os valores
    checked2.forEach((String key, bool value) {
      checkboxes.add(
        // adiciona um item ao checkbox
        CheckboxListTile(
          title: Text(key), //adiciona título
          value: value, // define valor
          // implementa evento onChage para gerenciar
          // valor do checkbox
          onChanged: (newValue) {
            //recebe valor atual
            setState(() {
              //altera o estado da variável
              newValue != null
                  ? //se diferente de null
                  //alterna valor entre verdadeiro e falso
                  checked2[key] == true
                      ? checked2[key] = false
                      : checked2[key] = true
                  : checked2[key] = false;
            });
          },
        ),
      );
    });
    return checkboxes;
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              child: Text("Questão 1"),
            ),
            SizedBox(
                child: Column(
              children: _buildCheckboxes(),
            )),
            SizedBox(
              child: Column(
                children: _buildCheckboxes2(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
