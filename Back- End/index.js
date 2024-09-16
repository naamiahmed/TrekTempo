const app = require('./app');

const port = 3000;

app.get('/', (req, res) => {
    res.send('Welcome to the homepage!');
    });

app.listen(port, () => {
  console.log(`Server listening on port http://localhost:${port}`);
});