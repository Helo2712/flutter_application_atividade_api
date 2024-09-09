import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApi extends StatefulWidget {
  const MyApi({super.key});

  @override
  State<MyApi> createState() => _MyApiState();
}

class _MyApiState extends State<MyApi> {
  TextEditingController cont = TextEditingController();
  String opcao = "";
  var resultado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Star Wars ",
          style: TextStyle(
            color: Colors.yellowAccent, 
            fontSize: 32, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            // Campo de texto com estilização
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: cont,
                decoration: InputDecoration(
                  labelText: "Informe o ID que deseja buscar",
                  labelStyle: TextStyle(color: Colors.yellowAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.yellowAccent,
                      width: 2.0,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                cursorColor: Colors.yellowAccent,
              ),
            ),
            SizedBox(height: 20),
            // Radio buttons com estilização
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRadioOption("Pessoa", Icons.person),
                _buildRadioOption("Planeta", Icons.public),
                _buildRadioOption("Nave", Icons.airplanemode_active),
              ],
            ),
            SizedBox(height: 20),
            // Botão estilizado
            ElevatedButton(
              onPressed: () async {
                if (cont.text.isNotEmpty) {
                  if (opcao == "Pessoa") {
                    await fazerReqPessoa(cont.text);
                  } else if (opcao == "Planeta") {
                    await fazerReqPlaneta(cont.text);
                  } else if (opcao == "Nave") {
                    await fazerReqStarships(cont.text);
                  }
                } else {
                  setState(() {
                    resultado = "Por favor, insira um ID válido";
                  });
                }
              },
              child: Text(
                "Mostrar",
                style: TextStyle(color: Colors.yellowAccent, fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Exibição dos resultados em um Card estilizado
            if (resultado != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.black,
                  elevation: 8,
                  shadowColor: Colors.yellowAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      resultado,
                      style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }

  // Função auxiliar para construir opções de Radio Button
  Widget _buildRadioOption(String label, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.yellowAccent),
          Radio(
            value: label,
            groupValue: opcao,
            onChanged: (value) {
              setState(() {
                opcao = value!;
              });
            },
            activeColor: Colors.yellowAccent,
          ),
          Text(
            label,
            style: TextStyle(color: Colors.yellowAccent),
          ),
        ],
      ),
    );
  }

  Future<void> fazerReqPessoa(String x) async {
    var url = Uri.parse('https://swapi.dev/api/people/${x}/');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> dadosFormatados = jsonDecode(response.body);
      var nome = dadosFormatados['name'];
      var altura = dadosFormatados['height'];
      var genero = dadosFormatados['gender'];
      var corOlhos = dadosFormatados['eye_color'];
      var corCabelo = dadosFormatados['hair_color'];

      setState(() {
        resultado =
            'Nome: $nome\nAltura: $altura\nGênero: $genero\nCor dos Olhos: $corOlhos\nCor do Cabelo: $corCabelo';
      });
    } else {
      setState(() {
        resultado = 'Erro ao buscar dados da pessoa';
      });
    }
  }

  Future<void> fazerReqPlaneta(String x) async {
    var url = Uri.parse('https://swapi.dev/api/planets/${x}/');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> dadosFormatados = jsonDecode(response.body);
      var nome = dadosFormatados['name'];
      var clima = dadosFormatados['climate'];
      var terreno = dadosFormatados['terrain'];
      var diametro = dadosFormatados['diameter'];
      var populacao = dadosFormatados['population'];

      setState(() {
        resultado =
            'Nome: $nome\nClima: $clima\nTerreno: $terreno\nDiâmetro: $diametro\nPopulação: $populacao';
      });
    } else {
      setState(() {
        resultado = 'Erro ao buscar dados do planeta';
      });
    }
  }

  Future<void> fazerReqStarships(String x) async {
    var url = Uri.parse('https://swapi.dev/api/starships/${x}/');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> dadosFormatados = jsonDecode(response.body);
      var nome = dadosFormatados['name'];
      var modelo = dadosFormatados['model'];
      var tamanho = dadosFormatados['length'];
      var capacidade = dadosFormatados['cargo_capacity'];
      var nPassageiros = dadosFormatados['passengers'];

      setState(() {
        resultado =
            'Nome: $nome\nModelo: $modelo\nTamanho: $tamanho\nCapacidade: $capacidade\nPassageiros: $nPassageiros';
      });
    } else {
      setState(() {
        resultado = 'Erro ao buscar dados da nave';
      });
    }
  }
}
