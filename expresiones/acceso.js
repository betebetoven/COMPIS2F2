const { Expression } = require("../abstract/express.js");
const { Retorno } = require ("../abstract/Retorno.js");
//import { Environment } from "../symbols/enviroment.js";
//import { Type } from "../symbols/type.js";


class Acceso extends Expression {
    constructor( id,line,column) {
        super(line, column) 
        this.id = id;
    }

    executar(env) {



        //preguntar si exite variable
        //sino existe 
        //error semanticos



        

        const variable_ts= env.get_variable(this.id)


        if(variable_ts== null|| variable_ts== undefined){
            //errores semaintics
            throw "Error semantico, esta variable no existe! :c"
        }

        var rt = new Retorno(variable_ts.value,variable_ts.type);

        return rt;
            
        

        



    }
}
module.exports = {Acceso};