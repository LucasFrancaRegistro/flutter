// import 'package:flutter/material.dart';

// class CheckBox extends StatefulWidget {
//   @override
//   CheckBoxState createState() => CheckBoxState();
// }

// class CheckBoxState extends State<CheckBox> {
//   List<Widget> _buildCheckboxes(checked) {
//     List<Widget> checkboxes = [];
//     // percorre todos os itens armazendos na estrutura
//     // Map (chave, valor), obtendo os valores
//     checked.forEach((String key, bool value) {
//       checkboxes.add(
//         // adiciona um item ao checkbox
//         CheckboxListTile(
//           title: Text(key), //adiciona título
//           value: value, // define valor
//           // implementa evento onChage para gerenciar
//           // valor do checkbox
//           onChanged: (newValue) {
//             //recebe valor atual
//             setState(() {
//               //altera o estado da variável
//               newValue != null
//                   ? //se diferente de null
//                   //alterna valor entre verdadeiro e falso
//                   checked[key] == true
//                       ? checked[key] = false
//                       : checked[key] = true
//                   : checked[key] = false;
//             });
//           },
//         ),
//       );
//     });
//   }
// }
