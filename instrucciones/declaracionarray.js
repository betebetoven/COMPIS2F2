//import { Expression } from "../abstract/express";
const { Instruccion } = require( "../abstract/instruccion.js");
//import { Environment } from "../symbols/enviroment";
const { Type } = require( "../symbols/type");
const { Symbol }= require ("../symbols/symbols.js");


 class DeclaracionARRAY extends Instruccion {
    constructor( final, tipo, nombres,value,tamaño,tamaño2,dosdimensiones,line, column) {
        super(line,column);
        this.dosdimensiones = dosdimensiones;
        this.tamaño = tamaño;
        this.tamaño2 = tamaño2;
        this.nombres = nombres;
        this.tipo = tipo;
        this.value = value;
        this.final = final;// esta madre es boolean
    }
        
     executar(env) {
        if(this.dosdimensiones == false)
        {
        var vector = [];//es un vector de simbolos para despues agregarlo al map con su nombre especifico
        //console.log("Declarando nuevo array: "+ this.nombres);
       // console.log("ACA ES PARA VER EL VALOR INICIAL DE LAS ENTRADAS "+this.nombres[0]+": "+this.tamaño)
        
        if(this.value == null)
        { 
            //console.log("si entra a la declaracion de valor null array")
            var entradavectorvacio = new Symbol(null,null,null,null);
            if(this.tipo == Type.NUMBER)
            entradavectorvacio.value = 0;
            else if(this.tipo == Type.STRING )
            entradavectorvacio.value = "";
            else if(this.tipo == Type.STRING )
            entradavectorvacio.value = false;
            //console.log("vamos a ver de que se llena el vector: "+entradavectorvacio.value )
            for (var i = 0 ; i < Number(this.tamaño.executar(env).value); i++) {
                vector.push(entradavectorvacio);
            }
            //console.log("aca se mira el vector vacio de "+this.nombres[0]+": ")
            //console.log(vector)

        }
        else if(this.tamaño == null)
        {
            //console.log("TAMAÑO SI ES IGUAL A NULL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            //console.log(this.value)
        for (var valorsito of this.value) {
            //console.log("este es valorcito????????????????????????????????")
            //console.log(valorsito)
            var expresion = (valorsito.executar(env)).value
            //console.log("ESTE DE ABAJO ES EXPRESION????????????????????")
            //console.log(expresion)

            var entrada = new Symbol(expresion, this.nombres[0], this.tipo,false)
            vector.push(entrada)

            
        }
       
      
        //console.log("ACA ABAJO ESTA EL VECTOR LLENO")
        //console.log(vector)


        }
        //console.log(this.nombres[0])
        if(!env.tablaSimbolos.has(this.nombres[0]))
            //console.log("SI LLEGA A GUARDAR LAS VIARIABLES QU EPEO")
            env.guardar_variable(this.nombres[0],vector,this.type,this.final)
        console.log(env)

        console.log(env.tablaSimbolos)
        

        
    }
    else
    {
        //DOSDIMENSIONES = TRUE
        var vector = [];//es un vector de simbolos para despues agregarlo al map con su nombre especifico
        
        
        if(this.value == null)
        { 
            
            var entradavectorvacio = new Symbol(null,null,null,null);
            if(this.tipo == Type.NUMBER)
            entradavectorvacio.value = 0;
            else if(this.tipo == Type.STRING )
            entradavectorvacio.value = "";
            else if(this.tipo == Type.STRING )
            entradavectorvacio.value = false;
            for (let index = 0; index <Number(this.tamaño.executar(env).value); index++) {
                var v =[]
                for (let i = 0; i < Number(this.tamaño2.executar(env).value); i++) {
                    
                    v.push(entradavectorvacio)
                }
                vector.push(v)
                
            }
            
            /*for (var i = 0 ; i < Number(this.tamaño.executar(env).value); i++) {
                vector.push(entradavectorvacio);
            }*/
            

        }
        else if(this.tamaño == null)
        {
          console.log("SISE METE A JUAN !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
          console.log(this.value)
          console.log("aca termina jaun !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        for (var valorsito of this.value) {
            
            var v = []
            for(var valorsito2 of valorsito)
            {
            var expresion = (valorsito2.executar(env)).value
            var entrada = new Symbol(expresion, this.nombres[0], this.tipo,false)
            v.push(entrada)
            
            }
            vector.push(v)

            
        }

        }
        
        if(!env.tablaSimbolos.has(this.nombres[0]))
            
            env.guardar_variable(this.nombres[0],vector,this.type,this.final)
        console.log(env)

        console.log(env.tablaSimbolos)

    }
}
}
module.exports ={DeclaracionARRAY}