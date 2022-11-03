const { Environment } = require("./symbols/enviroment.js");
const {consola} = require("./patron_singleton/singleton.js");
var express = require('express');
var morgan = require('morgan');
var fs = require('fs'); 
var parser = require('./prueba');
var arbol_graf = require('./arbol_graficado.js');



var app = express();
var cors = require('cors')

app.use(cors()) // Use this after the variable declaration

app.use(morgan('dev'));
app.use(express.json())
app.use(express.urlencoded({extended:   true}));


var incremental = 0


app.listen(5000, function (){
    
console.log('escuchando en el puerto 8080 jaja');
//res.json({mensaje: "hola patata"});

})
app.get('/p', function (req, res){
    incremental++;
    var env_padre = new Environment(null);
    fs.readFile('./entrada.txt', (err, data) => {
        console.log(data.toString());
        if (err) throw err;
        const ast = parser.parse(data.toString());
        for (const elemento  of ast) {
            try {
                
                //preguntar si ese elemtno es de clase metodo o funciones
                
                    elemento.executar(env_padre)
                
            } catch (error) {
                //console.log(error);
                
                
            }
        }
    });
    
    res.json({mensaje: "hola patata"});
})
app.get('/r', function (req, res){
    fs.readFile('./entrada.txt', (err, data) => {
        console.log(data.toString());
        if (err) throw err;
        arbol_graf.parse(data.toString());
    });
    res.send( "Este mensaje esta en texto");
})
app.get('/getincremental', function (req, res){

    res.json({incremental: incremental});
})
app.post('/setIncremental', function(req,res){
    var texto = req.body.texto
    console.log(texto)
    var salida = arbol_graf.parse(texto).toString();
    fs.writeFile('./salida_graphviz.txt', salida, err => {
        if (err) {
          console.error(err);
        }
        // file written successfully
      });
    res.json({status: "ok",
    incremental: incremental,
    salida : salida
    })

})
app.post('/gramaticarlos', function(req,res){
    var env_padre = new Environment(null);
    var texto = req.body.texto
    console.log(texto)
    const ast = parser.parse(texto);
        for (const elemento  of ast) {
            try {
                
                //preguntar si ese elemtno es de clase metodo o funciones
                
                    elemento.executar(env_padre)
                
            } catch (error) {
                //console.log(error);
                
            }
        }
        const obj = Object.fromEntries(env_padre.tablaSimbolos);
        
       
        
        res.json({status: "ok",
        incremental: incremental,
        salida : obj,
        consola: consola.cons

        })
        consola.cons = "";
            
            //res.toString(consola.cons)

})