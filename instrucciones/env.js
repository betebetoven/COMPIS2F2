
const { Instruccion } = require("../abstract/instruccion.js");
const { Environment } = require("../symbols/enviroment.js");


class Bloque extends Instruccion {
    constructor(instrucciones,line, column) {//INSTRUCCIONES ES UN ARRAY
        this.instrucciones = instrucciones;
        super(line,column);
    }

     executar(env) {    

        //analisis semantivo 

        const new_env= new Environment(env);//aca es donde entra el env padre
        //y lo que hace que varios env puedanconvivier juntos sin tocarse


        // como acceder a otras tablas de simbolos padres
        // while(env!=null){
        //     //busqueda de dla variblea
        //     env = env.anterior
        // }


        for (const elemento  of this.instrucciones) {
            try {
                
                elemento.executar(new_env)
            } catch (error) {
                //console.log(error);
                
            }
        }

        
    }
}
module.exports= {Bloque};