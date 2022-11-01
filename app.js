var express = require('express');
var morgan = require('morgan');
var fs = require('fs'); 
var parser = require('./prueba');



var app = express();


app.use(morgan('dev'));
app.use(express.json())
app.use(express.urlencoded({extended:   true}));


var incremental = 0


app.listen(5000, function (){
    
console.log('escuchando en el puerto 8080 jaja');

})
app.get('/', function (req, res){
    incremental++;
    fs.readFile('./entrada.txt', (err, data) => {
        console.log(data.toString());
        if (err) throw err;
        parser.parse(data.toString());
    });
    
    res.json({mensaje: "hola patata"});
})
app.get('/retornoTexto', function (req, res){

    res.send( "Este mensaje esta en texto");
})
app.get('/getincremental', function (req, res){

    res.json({incremental: incremental});
})
app.post('/setIncremental', function(req,res){
    //body hace referncia a un objeto json y el punto marca a que parte del objeto se refiere
    incremental = req.body.incremental
    var texto = req.body.texto
    res.json({status: "ok",
    incremental: incremental
    })

})