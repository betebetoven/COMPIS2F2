//import { Expression } from "../abstract/express";
const { Instruccion } = require( "../abstract/instruccion.js");
//import { Environment } from "../symbols/enviroment";
//import { Type } from "../symbols/type";

 class Declaracion extends Instruccion {
    constructor( final, tipo, nombres,value,line, column) {
        super(line,column);
        this.nombres = nombres;
        this.tipo = tipo;
        this.value = value;
        this.final = final;// esta madre es boolean
    }
        //aca se transofmran de retorno a simbolo
     executar(env) {
        //codigo analisis semantico
        console.log("Declarando nueva variable: "+ this.nombres);
        //console.log(this);


        //console.log(this.value)
        const expresion= this.value.executar(env);//retortna un objeto retorno, ya sesa de la expresion
        //o de un valor especifico, aqui falta agregar que al asignar que pueda ser igualado al valor de una variable
        console.log(expresion);
        
        for (const nombre  of this.nombres)
        {
        if(!env.tablaSimbolos.has(nombre))
            console.log("SI LLEGA A GUARDAR LAS VIARIABLES QU EPEO")
            env.guardar_variable(nombre,expresion.value,expresion.type,this.final)
        console.log(env)
        }
        console.log(env.tablaSimbolos)
        

        
    }
}
module.exports ={Declaracion}