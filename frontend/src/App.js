import React, { useState } from 'react';
import './App.css';

function App() {
  const [data, setData] = useState([]);
  const [nodeId, setNodeId] = useState('');

  const fetchData = async (endpoint) => {
    const res = await fetch(`http://localhost:5000/${endpoint}`);
    const result = await res.json();
    setData(result);
    setNodeId(res.headers.get("X-Node-ID"));
  };

  return (
    <div className="App">
      <h1>Welcome to the Student Portal</h1>
      <button onClick={() => fetchData("students")}>Students</button>
      <button onClick={() => fetchData("subjects")}>Courses</button>

      <h3>Responding Node: {nodeId}</h3>

      <ul>
        {data.map((item, index) => (
          <li key={index}>{JSON.stringify(item)}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;
