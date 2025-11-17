import 'package:flutter/material.dart';

enum Category {
  comida,
  gasolina,
  compras,
  hogar,
  cine,
  mascotas,
  eventos,
  regalos,
}

enum CategoryColor {
  azul,
  verde,
  naranja,
  morado,
  rojo,
  turquesa,
  amarillo,
  rosado,
}

extension CategoryX on Category {
  String get label {
    switch (this) {
      case Category.comida: return "Comida";
      case Category.gasolina: return "Gasolina";
      case Category.compras: return "Compras";
      case Category.hogar: return "Hogar";
      case Category.cine: return "Cine";
      case Category.mascotas: return "Mascotas";
      case Category.eventos: return "Eventos";
      case Category.regalos: return "Regalos";
    }
  }

  IconData get icon {
    switch (this) {
      case Category.comida: return Icons.fastfood;
      case Category.gasolina: return Icons.local_gas_station;
      case Category.compras: return Icons.shopping_bag;
      case Category.hogar: return Icons.home;
      case Category.cine: return Icons.local_movies;
      case Category.mascotas: return Icons.pets;
      case Category.eventos: return Icons.emoji_events;
      case Category.regalos: return Icons.card_giftcard;
    }
  }


}
extension CategoryColorX on CategoryColor {
  String get label {
    switch (this) {
      case CategoryColor.azul: return "Azul";
      case CategoryColor.verde: return "Verde";
      case CategoryColor.naranja: return "Naranja";
      case CategoryColor.morado: return "Morado";
      case CategoryColor.rojo: return "Rojo";
      case CategoryColor.turquesa: return "Turquesa";
      case CategoryColor.amarillo: return "Amarillo";
      case CategoryColor.rosado: return "Rosado";
    }
  }

  Color get color {
    switch (this) {
      case CategoryColor.azul: return Colors.blueAccent;
      case CategoryColor.verde: return Colors.greenAccent;
      case CategoryColor.naranja: return Colors.orangeAccent;
      case CategoryColor.morado: return Colors.purpleAccent;
      case CategoryColor.rojo: return Colors.redAccent;
      case CategoryColor.turquesa: return Colors.tealAccent;
      case CategoryColor.amarillo: return Colors.amberAccent;
      case CategoryColor.rosado: return Colors.pinkAccent;
    }
  }
}