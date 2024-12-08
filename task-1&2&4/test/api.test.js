// test/api.test.js
const request = require('supertest');
const app = require('../index');

describe('Todo API', () => {
    it('GET /api/todos should return an empty array initially', async () => {
        const response = await request(app).get('/api/todos');
        expect(response.statusCode).toBe(200);
        expect(response.body).toEqual([]);
    });

    it('POST /api/todos should create a new todo', async () => {
        const newTodo = { id: 1, task: 'Learn Node.js' };
        const response = await request(app)
            .post('/api/todos')
            .send(newTodo);
        
        expect(response.statusCode).toBe(201);
        expect(response.body).toEqual(newTodo);
    });
});