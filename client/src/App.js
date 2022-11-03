//import { response } from 'express'
/*import React, {useEffect,useState} from 'react'

function App() {
  const [backendData, setBackendData] = useState([{}])
  useEffect(() => {
    fetch("/p").then(
      response => response.json()
    ).then (
      data => {
        setBackendData(data)
      }
    )
  },[])

  return (
    <div>
      {(typeof backendData.mensaje === 'undefined')? (
        <p>Loading...</p>
      ):
      (
       
        <p > {backendData.mensaje}</p>
        

      )}

    </div>
  )


 
}


export default App

*/
import React, { Component } from 'react'
import './App.css'
import PostForm from './components/PostForm'

class App extends Component {
	render() {
		return (
			<div className="App">
				<PostForm />
				{/* <PostList /> */}
			</div>
		)
	}
}

export default App