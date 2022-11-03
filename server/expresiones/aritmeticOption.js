class AritmeticOption {
    // Create new instances of the same class as static attributes
    static MAS = new AritmeticOption("MAS")//0
    static MENOS = new AritmeticOption("MENOS")//1
    static MULTIPLICACION = new AritmeticOption("MULTIPLICACION")//2
    static DIVISION = new AritmeticOption("DIVISION")//0
    static MODULO = new AritmeticOption("MODULO")//1
    static POTENCIA = new AritmeticOption("POTENCIA")//2
    static NEGACION = new AritmeticOption("NEGACION")//2
    static SOBRESUMA = new AritmeticOption("SOBRESUMA")//2
    static SOBRERESTA = new AritmeticOption("SOBRERESTA")//2
    static error = new AritmeticOption("error")//3
  
    constructor(name) {
      this.name = name
    }
  }
  module.exports = {AritmeticOption};
  