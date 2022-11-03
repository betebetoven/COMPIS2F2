const { Expression } = require("../abstract/express.js");
const { Retorno } = require("../abstract/Retorno.js");
//import { Environment } from "../symbols/enviroment.js";
const { Type } = require("../symbols/type.js");
//import { AritmeticOption } from "./aritmeticOption.js";
const { RelacionalOption } = require("./relacionalOptions.js");
class Relacional extends Expression {

    constructor(left ,right ,type ,line,column) {
      super(line, column);
        this.left = left;
        this.right = right;
        this.type = type;
        //super(line, column);
      }
    
    
     executar(env){

        var result = new Retorno(null,Type.error)
        

        
        
       
        const nodoDer = this.right.executar(env)
        if(nodoDer.type == Type.VARIABLE)
            {
                nodoDer.type = env.getTipo_variable(nodoDer.value)
                nodoDer.value = env.get_variable(nodoDer.value).value
            }
        const nodoIzq = null;
        if(this.left != null)
        {
         nodoIzq = this.left.executar(env)
        
        
            
            if(nodoIzq.type == Type.VARIABLE)
            {
                nodoIzq.type = env.getTipo_variable(nodoIzq.value)
                nodoIzq.value = env.get_variable(nodoIzq.value).value
            }

        if (this.type == RelacionalOption.MAYOR) {

            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
                result = {
                  value: nodoIzq.value > nodoDer.value,
                  type: Type.BOOLEAN,
                };
              }
            
        }
        else if (this.type == RelacionalOption.MENOR) {
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
              result = {
                value: nodoIzq.value < nodoDer.value,
                type: Type.BOOLEAN,
              };
            }
          }
          else if (this.type == RelacionalOption.MAYORIGUAL) {
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
              result = {
                value: nodoIzq.value >= nodoDer.value,
                type: Type.BOOLEAN,
              };
            }
          }
          else if (this.type == RelacionalOption.MENORIGUAL) {
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
              result = {
                value: nodoIzq.value <= nodoDer.value,
                type: Type.BOOLEAN,
              };
            }
          }
          else if (this.type == RelacionalOption.IGUAL) {
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
              result = {
                value: nodoIzq.value == nodoDer.value,
                type: Type.BOOLEAN,
              };
            }
            else if (nodoDer.type == Type.STRING && nodoIzq.type == Type.STRING) {
                result = {
                  value: nodoIzq.value === nodoDer.value,
                  type: Type.BOOLEAN,
                };
              }
              else if (nodoDer.type == Type.BOOLEAN && nodoIzq.type == Type.BOOLEAN) {
                result = {
                  value: nodoIzq.value == nodoDer.value,
                  type: Type.BOOLEAN,
                };
              }
          }
          else if (this.type == RelacionalOption.NOIGUAL) {
            if (nodoDer.type == Type.NUMBER && nodoIzq.type == Type.NUMBER) {
              result = {
                value: nodoIzq.value != nodoDer.value,
                type: Type.BOOLEAN,
              };
            }
            else if (nodoDer.type == Type.STRING && nodoIzq.type == Type.STRING) {
                result = {
                  value: nodoIzq.value != nodoDer.value,
                  type: Type.BOOLEAN,
                };
              }
              else if (nodoDer.type == Type.BOOLEAN && nodoIzq.type == Type.BOOLEAN) {
                result = {
                  value: nodoIzq.value != nodoDer.value,
                  type: Type.BOOLEAN,
                };
              }
          }
          else if (this.type == RelacionalOption.AND) {
            if (nodoDer.type == Type.BOOLEAN && nodoIzq.type == Type.BOOLEAN) {
              result = {
                value: nodoIzq.value && nodoDer.value,
                type: Type.BOOLEAN,
              };
            }
          }
          else if (this.type == RelacionalOption.OR) {
            if (nodoDer.type == Type.BOOLEAN && nodoIzq.type == Type.BOOLEAN) {
              result = {
                value: nodoIzq.value || nodoDer.value,
                type: Type.BOOLEAN,
              };
            }
          }

        }
        else if (this.type == RelacionalOption.NEGACION) {
            if (nodoDer.type == Type.BOOLEAN) {
              result = {
                value: !nodoDer.value,
                type: Type.BOOLEAN,
              };
            }
          }



          



        return result
    }


}
module.exports = {Relacional};
