import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _info = "Informe seus dados";

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields(){
    setState((  ) {
      weightController.text = "";
      heightController.text = "";
      _info = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc = (weight / (height * height)) * 10000;
      print(imc);
      if(imc <18.6){
        _info = "Abaixo do Peso {${imc.toStringAsPrecision(4)}}";
      }else if( imc>= 18.6 && imc < 24.9){
        _info = "Peso Ideal {${imc.toStringAsPrecision(4)}}";
      }else if( imc>= 24.9 && imc < 29.9){
        _info = "Levemente Acima do Peso {${imc.toStringAsPrecision(4)}}";
      }else if( imc>= 29.9 && imc < 34.9){
        _info = "Obesidade Grau I {${imc.toStringAsPrecision(4)}}";
      }else if( imc>= 34.9 && imc < 40){
        _info = "Obesidade Grau II {${imc.toStringAsPrecision(4)}}";
      }else if( imc>= 40){
        _info = "Obesidade Grau III {${imc.toStringAsPrecision(4)}}";
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: weightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu peso";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25),
                controller: heightController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira sua altura";
                  }
                },
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(80, 10, 80, 10),
                child: Container(
                  height: 50,
                  width: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, //background
                      onPrimary: Colors.white, // letras
                    ),
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: (){
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
