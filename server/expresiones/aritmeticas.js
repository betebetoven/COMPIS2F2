const { Expression }= require ("../abstract/express.js")
const { Retorno } = require ("../abstract/Retorno.js")
//import { Environment } from "../symbols/enviroment.js"
const { Type } = require("../symbols/type.js")
const {Literal} = require("../expresiones/literal.js")
const { AritmeticOption }= require ("./aritmeticOption.js")
const { Symbol }= require ("../symbols/symbols.js");

class Arithmetic extends Expression {

    constructor( left, right, type,line,column) {
        super(line, column)
        this.left = left;
        this.right = right;
        this.type = type;
        
    }
     // el env queda para los accesos a las variables se use o no pero si lo pide chingadamadre
     executar(env){

        var result = new Retorno(null,Type.error)
        

        
        var nodoDer = null;
       
        var nodoIzq = this.left.executar(env)
        if(this.right != null)
        {
            console.log("POR QUE NO LLEGA HASTA ACAAAAAAA 1");
        console.log("type del this"+this.type.name);
        console.log(this.type == AritmeticOption.MULTIPLICACION);
        
        console.log(this.right.executar(env))
         nodoDer = this.right.executar(env);
        console.log("aca deberia de salir el nodo der ya siendo retorno")
        console.log(nodoDer)
        
        
            if(nodoDer.type == Type.VARIABLE)
            {
                nodoDer.type = env.getTipo_variable(nodoDer.value);
                nodoDer.value = env.get_variable(nodoDer.value).value;
            }
            if(nodoIzq.type == Type.VARIABLE)
            {
                nodoIzq.type = env.getTipo_variable(nodoIzq.value);
                nodoIzq.value = env.get_variable(nodoIzq.value).value;
            }
        console.log("POR QUE NO LLEGA HASTA ACAAAAAAA")
        console.log("type del this"+this.type.name)
        console.log(this.type == AritmeticOption.MULTIPLICACION)

        if (this.type == AritmeticOption.MAS) {
            console.log("DEBERIA ENTRAR A HACER LA SUMAAAAAAAAAAAAAAAAAA SUMAAAAAAAA")

   
            
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
                result = { 
                    value: Number(nodoIzq.value + nodoDer.value), 
                    type: Type.NUMBER 
                }
            }else if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.STRING
                ||nodoDer.type == Type.STRING && nodoIzq.type == Type.NUMBER) {
                result = { 
                    value: (String(nodoIzq.value) + String(nodoDer.value)), 
                    type: Type.STRING 
                }
            }else if (nodoIzq.type == Type.STRING || nodoDer.type == Type.STRING ) {
                result = { 
                    value: (String(nodoIzq.value) + String(nodoDer.value)), 
                    type: Type.STRING 
                }
            }
            
        }else if (this.type == AritmeticOption.MENOS) {

                console.log("SI ENTRA A LA RESTA")
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
                result = { 
                    value: Number(nodoIzq.value - nodoDer.value), 
                    type: Type.NUMBER 
                }
            }
            //en la resta unicamente quiero con numeros AGREGAR LAS TIPO VARIABLES
            
        }else if(this.type == AritmeticOption.MULTIPLICACION)
        {
            console.log("POPR QUE NO ENTRA A LA MUTLIIIIIIIIIIIII")
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
                console.log("DEBERIA ENTRAR A HACER LA multiplicacioooooooooooooooon")

                result = { 
                    value: Number(nodoIzq.value * nodoDer.value), 
                    type: Type.NUMBER 
                }
            }


        }
        else if(this.type == AritmeticOption.DIVISION)
        {
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
                result = { 
                    value: Number(nodoIzq.value / nodoDer.value), 
                    type: Type.NUMBER 
                }
            }


        }
        else if(this.type == AritmeticOption.MODULO)
        {
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
                result = { 
                    value: Number(nodoIzq.value % nodoDer.value), 
                    type: Type.NUMBER 
                }
            }


        }
        else if(this.type == AritmeticOption.POTENCIA)
        {
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
                result = { 
                    value: Number(nodoIzq.value ** nodoDer.value), 
                    type: Type.NUMBER 
                }
            }


        }
    }
        else if(this.type == AritmeticOption.SOBRESUMA)
        {
            if (nodoIzq.type == Type.VARIABLE) {
                
                if(env.getTipo_variable(nodoIzq.value)== Type.NUMBER)
                {//CAMBIO DE LITERAL DE NOBRE DE VARIABE A SU VALOR
                    console.log("SI ENTRA A LA SOBRE SUMA")
                    var tmp = nodoIzq.value
                nodoIzq.type = env.getTipo_variable(nodoIzq.value)
                nodoIzq.value = Number(env.get_variable(nodoIzq.value).value)
                
                nodoIzq.value = Number(nodoIzq.value) + 1
                
                var nsimbol = new Symbol(nodoIzq.value,tmp,nodoIzq.type,false)
                
                env.actualizar_variable(tmp, nsimbol)


                result = { 
                    value: nodoIzq.value, 
                    type: Type.NUMBER 
                }
            }
            }


        }
        else if(this.type == AritmeticOption.SOBRERESTA)
        {
            if (nodoIzq.type == Type.VARIABLE) {
                if(env.getTipo_variable(nodoIzq.value)== Type.NUMBER)
                {//CAMBIO DE LITERAL DE NOBRE DE VARIABE A SU VALOR
                    var tmp = nodoIzq.value
                nodoIzq.type = env.getTipo_variable(nodoIzq.value)
                nodoIzq.value = env.get_variable(nodoIzq.value).value
                nodoIzq.value = nodoIzq.value - 1
                env.actualizar_variable(tmp, nodoIzq.value)


                result = { 
                    value: nodoIzq.value, 
                    type: Type.NUMBER 
                }
            }
            }


        }






        return result
    }


}
module.exports = {Arithmetic};
