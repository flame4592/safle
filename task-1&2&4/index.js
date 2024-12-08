// index.js
const express = require('express');
const bodyParser = require('body-parser');

const app = express();
app.use(bodyParser.json());

let todos = [];

// GET endpoint to retrieve all todos
app.get('/api/todos', (req, res) => {
    res.json(todos);
});

// POST endpoint to create a new todo
app.post('/api/todos', (req, res) => {
    const newTodo = req.body;
    todos.push(newTodo);
    res.status(201).json(newTodo);
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

module.exports = app; // Exporting app for testing purposes