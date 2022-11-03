const { Expression } = require("../abstract/express.js");
const { Instruccion } = require("../abstract/instruccion.js");
//import { Environment } from "../symbols/enviroment.js";
const { Type } =  require("../symbols/type.js");
const { Symbol }= require ("../symbols/symbols.js");

class Asignacion extends Instruccion {
    constructor(nombre ,valor ,line, column ) {
        super(line,column);
        this.nombre = nombre;
        this.valor = valor;
       
    }

     executar(env) {
         if(this.valor instanceof Expression)
         {
            
            const expresion= this.valor.executar(env);
            const tmp = env.getTipo_variable(this.nombre);
            const tmp4 = env.get_variable(this.nombre)
            env.actualizar_variable(this.nombre,new Symbol(expresion.value, this.nombre, tmp,tmp4.editable));
           // env.actualizar_variable(this.nombre,expresion.value);


         }
         else
         {
             const tmp = env.getTipo_variable(this.nombre);
             const tmp2 = env.getTipo_variable(this.valor);
             if(tmp == tmp2)
             {
                 const tmp3 = env.get_variable(this.valor).value
                 const tmp4 = env.get_variable(this.nombre)
                 env.actualizar_variable(this.nombre,new Symbol(tmp3, this.nombre, tmp,tmp4.editable));

             }

         }
        
        
    }
    graficar(){
        //singleton, una funcion agregar reporte ast
        //
       
        
    }
}
module.exports = {Asignacion};