//import { response } from 'express'
import React, {useEffect,useState} from 'react'

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