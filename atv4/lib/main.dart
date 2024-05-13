import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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
   List<dynamic> dataList = [];
  // método assíncrono para consumir informações de uma api
  Future<void> fetchData() async {
    // realiza a requisição
    final response =
        await http.get(Uri.parse('http://demo6394100.mockable.io/usuarios'));
    // verifica êxito da requisição
    if (response.statusCode == 200) {
      // converte resposta em objeto json
      final jsonResponse = json.decode(response.body);
      // atualiza state
      setState(() {
        dataList = jsonResponse['data'];
      });
    } else {
      // erro na requisição
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('API Response Demo'),
        ),
        body: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            final item = dataList[index];
            return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.blue, // Cor de fundo do retângulo
                  borderRadius: BorderRadius.circular(10.0), // Raio 
                ),
                child: ListTile(
                  title: Text('Name: ${item['name']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age: ${item['age']}'),
                      Text('State: ${item['state']}'),
                      Text('Adress: ${item['adress']}'),
                      Text('Cpf: ${item['cpf']}'),
                      Text('RG: ${item['rg']}'),
                      Text('E-mail: ${item['email']}'),
                      Text('Id: ${item['id']}'),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}

