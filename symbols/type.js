class Type {
    // Create new instances of the same class as static attributes
    static NUMBER = new Type("NUMBER")//0
    static STRING = new Type("STRING")//1
    static BOOLEAN = new Type("BOOLEAN")//2
    static VARIABLE = new Type("VARIABLE")// hacer el get variable para subir por el ast
    static error = new Type("error")//3
  
    constructor(name) {
      this.name = name
    }
  }
  module.exports = {Type};
  