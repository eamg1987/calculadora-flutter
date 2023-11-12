import 'package:flutter/material.dart';
import 'dart:core';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(CalculadoraApp());
}

class CalculadoraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      home: CalculadoraScreen(),
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String displayText = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              displayText,
              style: TextStyle(fontSize: 32.0),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton('0'),
              buildButton('C'),
              buildButton('='),
              buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text) {
    return ElevatedButton(
      onPressed: () {
        onButtonPress(text);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  void onButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Limpiar la pantalla
        displayText = '0';
      } else if (buttonText == '=') {
        // Calcular el resultado
        displayText = calcularResultado(displayText);
      } else {
        // Agregar el número u operador al texto actual
        displayText = (displayText == '0') ? buttonText : displayText + buttonText;
      }
    });
  }

  String calcularResultado(String input) {
  try {
    // Crea un analizador de expresiones matemáticas
    Parser p = Parser();
    Expression exp = p.parse(input);

    // Crea un evaluador de expresiones matemáticas
    ContextModel cm = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, cm);

    // Formatea el resultado según sea necesario
    return result.toString();
  } catch (e) {
    return 'Error';
  }
}







  dynamic eval(String expression) {
  try {
    // Separamos los operandos y operadores
    var parts = expression.split(RegExp(r'(\+|\-|\*|\/)'));

    // Filtramos las partes válidas (números y operadores)
    var validParts = parts.where((part) => part.isNotEmpty).toList();

    // Inicializamos la lista final
    var finalList = <dynamic>[];

    // Iteramos sobre las partes válidas
    for (var part in validParts) {
      // Intentamos convertir la parte a un número
      var number = double.tryParse(part);

      // Si es un número, lo agregamos a la lista final
      if (number != null) {
        finalList.add(number);
      }
      // Si es un operador válido, lo agregamos a la lista final
      else if (['+', '-', '*', '/'].contains(part)) {
        finalList.add(part);
      }
    }

    // Imprimimos la lista final (solo para propósitos de depuración)
    print('Lista final: $finalList');

    // Devolvemos el resultado final
   return Function.apply(
      (a, b, op) {
        if (op == '/' && b == 0) {
          throw Exception('División por cero no permitida');
        }
        return op == '+' ? a + b : op == '-' ? a - b : op == '*' ? a * b : op == '/' ? a / b : null;
      },
      finalList,
    );
  } catch (e) {
    print('Error durante la evaluación: $e');
    return 'ERROR';
  }
}

}
