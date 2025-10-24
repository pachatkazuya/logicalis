const http = require('http');
const server = require('./server');

test('responds with 200 and JSON', done => {
  http.get('http://localhost:8080', res => {
    expect(res.statusCode).toBe(200);
    let data='';
    res.on('data', chunk => data += chunk);
    res.on('end', () => {
      const obj = JSON.parse(data);
      expect(obj.status).toBe('ok');
      done();
    });
  });
});
