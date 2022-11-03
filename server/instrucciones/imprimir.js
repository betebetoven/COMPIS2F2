const { Instruccion } = require("../abstract/instruccion.js");
const {consola} = require("../patron_singleton/singleton.js");

class imprimir extends Instruccion
{
    constructor(expresion, line, column)
    {
        super(line,column);
        this.expresion = expresion;


    }
    executar(env)
    {
        var salida = (this.expresion.executar(env)).value;
        consola.cons += "\n"+salida
        
    }

}
module.exports = {imprimir}