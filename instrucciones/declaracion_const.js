//import { Expression } from "../abstract/express.js";
const { Instruccion } = require ("../abstract/instruccion.js");
//import { Environment } from "../symbols/enviroment.js";
//import { Type } from "../symbols/type.js";
//HACER FINAL EN LA DECLARACION DE LA VARIABLE O HACERSELO DE ATRIBUTO
class Declaracion_const extends Instruccion {
    constructor(  nombre, tipo,expresion,line, column) {
        super(line,column);
        this.nombre = nombre;
        this.tipo = tipo;
        this.expresion = expresion;
        this.final = true;
    }

     executar(env) {
        //codigo analisis semantico
        console.log("Declarando nueva variable FINAL: "+ this.nombre);
        //console.log(this);


        const expresion= this.expresion.executar(env);
        console.log(expresion);
        

        //preguntar si la variable esta libre
        //si los tipos son correctos o hacen match

        // if(x.type==){
        //     //ingreso de la variable a la tabla simbolos
        // }
        // else{
        //     //reporte de error semantico
        // }

        env.guardar_variable(this.nombre,expresion.value,expresion.type)
        

        
    }
}
module.exports = {Declaracion_const};