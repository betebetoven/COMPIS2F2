
import React, { Component } from 'react'
import axios from 'axios'
//import { response } from 'express'

 class PostForm2 extends Component {
    constructor(props) {
      super(props)
    
      this.state = {
         texto:''
         
      }
      this.mjs = "";
      this.response = "";
    }
    changeHandler = e => {
        this.setState({[e.target.name]: e.target.value})
        this.msj = this.response;
    }
    
    submitHandler = e  => {
        e.preventDefault()
        console.log(this.state)
        axios.post('http://localhost:5000/gramaticarlos',this.state).then
        (response=>{
            
        console.log(response.data.salida);
        //alert((response.data.salida).toString())




        this.response  = JSON.stringify(response.data.salida, null, 4);     
        alert(JSON.stringify(response.data.consola, null, 4) )



        }).catch(error => {
            console.log(error)
        })
    }
  render() {
    const {texto} = this.state
    return (
      <div>
        <form onSubmit={this.submitHandler}>
        <div>
        <label>EDITOR DE TEXTO:</label>
            </div>  
            <div>
            <textarea type="text"  name="texto" rows="30" cols="60" value={texto} onChange={this.changeHandler}/> 
            </div> 
            <div>
            <textarea type="text"  name="textotr" rows="20" cols="110" value={this.msj} /> 
            
            </div>    
            <div>
                <button type='submit'>GRAFICAR AST!!!!</button>
            </div>
        </form>
      </div>
    )
  }
}

export default PostForm2