class nodo {
    constructor(value) {
        this.index = 0;
      this.value = value;
      this.Next = null;
      this.Prev = null;
      //console.log("NODO CREADO CON EXITO")
    }
    getString() {

        var opt = "";
        if (this.value.constructor.name == opt.constructor.name && (this.value.includes("GLOBALA")))
            opt = ",fillcolor = \"#8B0000\"";
        else  if (this.value.constructor.name == opt.constructor.name && (this.value.includes("BLOQUE_INSTRUCCIONES")))
            opt = ",fillcolor = \"#CD5C5C\"";
        else  if (this.value.constructor.name == opt.constructor.name && (this.value.includes("BLOQUE_INSTRUCCION")))
            opt = ",fillcolor = \"#FFC0CB\"";
        else  if (this.value.constructor.name == opt.constructor.name && (this.value.includes("INSTRUCCION_")))
            opt = ",fillcolor = \"#98FB98\"";
        else  if (this.value.constructor.name == opt.constructor.name && (this.value.includes("OPCION")))
            opt = ",fillcolor = \"#AFEEEE\"";
            else opt = "";
        return  this.index+"[label=\""+this.value+"\""+opt+"]";


    }
  }
  module.exports = {nodo};