enum Peligrosidad {
  saludable,
  inofensivo,
  precaucion,
  peligroso;

  //----------------------------------------------------------------------------
  static Peligrosidad? tryParse(String str) {
    switch (str.toLowerCase()) {
      case 'saludable':
        return Peligrosidad.saludable;
      case 'inofensivo':
        return Peligrosidad.inofensivo;
      case 'precaucion':
        return Peligrosidad.precaucion;
      case 'peligroso':
        return Peligrosidad.peligroso;
      default:
        return null;
    }
  }

  //----------------------------------------------------------------------------
  @override
  String toString() {
    switch (this) {
      case Peligrosidad.inofensivo:
        return "Inofensivo";
      case Peligrosidad.saludable:
        return "Saludable";
      case Peligrosidad.precaucion:
        return "Precaucion";
      case Peligrosidad.peligroso:
        return "Peligroso";
    }
  }
}
