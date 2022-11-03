const { Expression } = require("../abstract/express.js")
const { Retorno } = require("../abstract/retorno.js")
const { Type } = require("../symbols/type.js")
const { Instruccion } = require( "../abstract/instruccion.js");


class Literal extends Expression {

    constructor( value, type,line,column) {
        
        super(line, column);
        this.value= value;
        this.type = type;
    }

     executar(env){
         var rtn = new Retorno(null, null);
        
        if (this.type == Type.NUMBER)
        {
            //return { value: Number(this.value), type: Type.NUMBER }
            rtn.value = Number(this.value);
            rtn.type = Type.NUMBER;
        }
        else if (this.type == Type.STRING){
            this.value = (this.value).replaceAll("\"","")
            //return { value: this.value, type: Type.STRING }
            rtn.value = this.value;
            rtn.type = Type.STRING;
        }
        else if (this.type == Type.BOOLEAN) {
            if (this.value == "true") 
            {
            //return { value: Boolean(true), type: Type.BOOLEAN }
            rtn.value = Boolean(true);
            rtn.type = Type.BOOLEAN;
            }
            else 
            {
                //return { value: Boolean(false), type: Type.BOOLEAN }
                rtn.value = Boolean(false);
                rtn.type = Type.BOOLEAN;
        }
        }
        else if (this.type == Type.VARIABLE){
            this.value = this.value
            //return { value: this.value, type: Type.STRING }
            rtn.value = this.value;
            rtn.type = Type.VARIABLE;
        }
        else 
        {
            //return { value: this.value, type: Type.error }
            rtn.value = this.value;
            rtn.type = Type.error;
        }
        return rtn;

    }
}
module.exports = {Literal};