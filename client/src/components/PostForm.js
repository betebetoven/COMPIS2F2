
import React, { Component } from 'react'
import axios from 'axios'
//import { response } from 'express'

 class PostForm extends Component {
    constructor(props) {
      super(props)
    
      this.state = {
         texto:''
      }
    }
    changeHandler = e => {
        this.setState({[e.target.name]: e.target.value})
    }
    submitHandler = e  => {
        e.preventDefault()
        console.log(this.state)
        axios.post('http://localhost:5000/setIncremental',this.state).then
        (response=>{console.log((response.data.salida).toString());
        alert((response.data.salida).toString())
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
            <textarea type="text"  name="texto" rows="20" cols="80" value={texto} onChange={this.changeHandler}/> 
            </div>    
            <div>
                <button type='submit'>GRAFICAR AST!!!!</button>
            </div>
        </form>
      </div>
    )
  }
}

export default PostForm