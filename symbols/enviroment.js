//import { metodo } from "../instrucciones/metodo";
const { Symbol }= require ("./symbols.js");
const { Type } = require ("./type.js");

class Environment {
  
   //tablaSimbolos: Map<string, Symbol>; //unicamente para variables, tienes q guardar funciones en otro map 
   //tablaSimbolos = new Map();
  // tablaSimbolos_metodos: Map<string, any>; //unicamente para metodos o funciones
    //tablaSimbolos_metodos = new Map();


  constructor(anterior) {
    this.anterior = anterior;  
    this.tablaSimbolos = new Map();
    this.tablaSimbolos_metodos = new Map();
    this.tablaSimbolos_metodos_TD = new Map();
  }

   getEnv(){
    return this.tablaSimbolos
  }

  guardar_funcion(nombre, valor) {
    
    //verificar que no existan duplicados
    if (!this.tablaSimbolos_metodos.has(nombre)) {
        this.tablaSimbolos_metodos.set(nombre, valor);
    }
    
  }
    //return boolean
   guardar_variable(nombre, valor, type, final) {
    
    if(!this.tablaSimbolos.has(nombre)){
      this.tablaSimbolos.set(nombre, new Symbol(valor, nombre, type,final));
      return true
    }
    console.log("esta variable ["+nombre+"] ya existe...");
    return false
  }

   
   getTipo_variable(nombre) {
    if(this.tablaSimbolos.has(nombre)){
        return this.tablaSimbolos.get(nombre).type;
    }
    return Type.error
  }
   actualizar_variable(nombre, new_valor) {
    if(this.tablaSimbolos.has(nombre)){
         this.tablaSimbolos.set(nombre, new_valor);
    }
  }
  
//sibolo es la puta variable 
// type es el tipo de variable que es propiedad de simbolo

   get_variable(nombre)
   {
    var env = this;
    while (env != null) {
        if (env.tablaSimbolos.has(nombre)) 
        {
        return env.tablaSimbolos.get(nombre);
        }
        env = env.anterior;
    }
    return null;
}

get_metodo(nombre) {
    var env = this;
    while (env != null) {
        if (env.tablaSimbolos_metodos.has(nombre)) 
        {return env.tablaSimbolos_metodos.get(nombre);}

        env = env.anterior;
    }
    return null;
  }
  
}  
module.exports = {Environment}                     