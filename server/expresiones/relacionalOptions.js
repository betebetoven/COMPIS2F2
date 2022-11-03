class RelacionalOption {
    static MAYOR = new RelacionalOption("MAYOR")//0
    static MENOR = new RelacionalOption("MENOR")//1
    static MAYORIGUAL = new RelacionalOption("MAYORIGUAL")//2
    static MENORIGUAL = new RelacionalOption("MENORIGUAL")//0
    static IGUAL = new RelacionalOption("IGUAL")//1
    static NOIGUAL = new RelacionalOption("NOIGUAL")//2
    static NEGACION = new RelacionalOption("NEGACION")//2
    static AND = new RelacionalOption("AND")//2
    static OR = new RelacionalOption("OR")//2
    static error = new RelacionalOption("error")//3
  
    constructor(name) {
      this.name = name
    }
}
module.exports = {RelacionalOption};