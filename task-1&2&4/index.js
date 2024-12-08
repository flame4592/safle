const express = require('express');
const app = express();

app.use(express.json());

// Sample in-memory data
let items = [{ id: 1, name: 'Item 1' }];

// Routes
app.get('/api/items', (req, res) => {
    res.status(200).json(items);
});

app.post('/api/items', (req, res) => {
    const newItem = { id: items.length + 1, name: req.body.name };
    items.push(newItem);
    res.status(201).json(newItem);
});

// Export for testing
module.exports = app;

// Start the server (only when not in test mode)
if (require.main === module) {
    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
}
