const request = require('supertest');
const app = require('./index');

describe('RESTful API Tests', () => {
    it('GET /api/items should return all items', async () => {
        const response = await request(app).get('/api/items');
        expect(response.statusCode).toBe(200);
        expect(response.body).toEqual([{ id: 1, name: 'Item 1' }]);
    });

    it('POST /api/items should create a new item', async () => {
        const newItem = { name: 'Item 2' };
        const response = await request(app).post('/api/items').send(newItem);
        expect(response.statusCode).toBe(201);
        expect(response.body).toEqual({ id: 2, name: 'Item 2' });
    });
});
