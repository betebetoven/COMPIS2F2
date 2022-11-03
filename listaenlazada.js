const { nodo } = require ("./nodo.js");
class listaenlazada
{
    constructor()
    {
        this.First = null;
        this.Last = null;
        this.tamaño = 0;
        this.completo = "digraph G\n" +
            "{label=\"expresion regular\"\n" +
            "        node[shape = circle]\n" +
            "        node[style = filled]\n" +
            "        node[fillcolor = \"#EEEEE\"]\n" +
            "        node[color = \"#EEEEE\"]\n" +
            "        node[color = \"#31CEF0\"]";
        this.conexiones = "";
        this.pepe = "";
        this.rep = [];

    }
    static general_index = 0;
     agrega( mnodo)//entra nodo
    {
        
        listaenlazada.general_index++;
        mnodo.index = listaenlazada.general_index;
        //nodo mnodo = new nodo(valor);
        if (this.tamaño==0) {
            this.First = mnodo;
            this.Last = mnodo;
            //this.First.index = 0;
           
        }
        else
        {

            var ahora = this.First;
            while (ahora.Next != null)
                ahora = ahora.Next;
            ahora.Next = mnodo;
            ahora.Next.Prev = ahora;
            this.Last = mnodo;
        }
        this.tamaño += 1;
        
    }
    concatena( p)//entra una lista enlazada
    {
        var  c = p.First;
        while (c!= null) {
            this.agrega(new nodo(c.value));
            c = c.Next;
        }
    }
    imprimirtodo( p){//aca tambien entra una listaenlazada
        var  temp = p.First;
        while (temp != null)
        {
            if (temp.value.constructor.name==this.constructor.name)
            this.imprimirtodo(temp.value);
                else
            this.completo+= "\n"+temp.getString();
            temp= temp.Next;

        }


    }


    //this.pepe = "";
    //ArrayList<String> rep = new ArrayList<>();
    v( x,  c)// x y c son nodos
    {

        var exemple = "";
        var listaexemple = new listaenlazada();
        while (c!= null)
        {
            if (x.value.constructor.name == exemple.constructor.name && c.value.constructor.name==listaexemple.constructor.name)
            {

                var aptd = c.value.First; // 
                while (aptd != null)
                {
                    if (aptd.value.constructor.name != listaexemple.constructor.name) {

                       
                        if (!rep.includes("\n" + x.index + "->" + aptd.index)) {
                            this.conexiones += "\n" + x.index + "->" + aptd.index;
                            rep.push("\n" + x.index + "->" + aptd.index);
                        }
                    }
                    else {

                        
                        v(aptd.Prev, aptd);
                    }
                    aptd=aptd.Next;
                }

            }

            x = x.Next;
            c = c.Next;
            
        }


    }
     g()
    {
        this.completo = "digraph G\n" +
                "{label=\"expresion regular\"\n" +
                "        node[shape = octagon]\n" +
                "        node[style = filled]\n" +
                "        node[fillcolor = \"#EEEEE\"]\n" +
                "        node[color = \"#EEEEE\"]\n" +
                "        node[color = \"#31CEF0\"]";
        this.conexiones = "";
        pepe = "";
        v(this.First,this.First.Next);
        imprimirtodo(this);


        console.log(this.completo+this.conexiones+"\n }")
        return this.completo+this.conexiones+"\n }";
    }


}
module.exports = {listaenlazada};