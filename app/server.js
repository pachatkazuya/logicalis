const http = require('http');
const port = process.env.PORT || 8080;

const requestHandler = (req, res) => {
  res.writeHead(200, {'Content-Type': 'application/json'});
  res.end(JSON.stringify({ status: 'ok', app: 'hello-web', message: 'Hello from DevOps CI/CD lab!' }));
};

const server = http.createServer(requestHandler);
server.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});

module.exports = server; // for tests
