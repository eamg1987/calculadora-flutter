import 'dart:io';

void main() {
  print("Calculadora Básica");
  print("1. Suma");
  print("2. Resta");
  print("3. Multiplicación");
  print("4. División");

  stdout.write("Seleccione una operación (1-4): ");
  String operacion = stdin.readLineSync()!;

  if (operacion == "1" || operacion == "2" || operacion == "3" || operacion == "4") {
    stdout.write("Ingrese el primer número: ");
    double num1 = double.parse(stdin.readLineSync()!);

    stdout.write("Ingrese el segundo número: ");
    double num2 = double.parse(stdin.readLineSync()!);

    switch (operacion) {
      case "1":
        print("Resultado: ${num1 + num2}");
        break;
      case "2":
        print("Resultado: ${num1 - num2}");
        break;
      case "3":
        print("Resultado: ${num1 * num2}");
        break;
      case "4":
        if (num2 != 0) {
          print("Resultado: ${num1 / num2}");
        } else {
          print("Error: División por cero.");
        }
        break;
      default:
        print("Operación no válida.");
    }
  } else {
    print("Operación no válida.");
  }
}
