const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3002;

app.use(cors());
app.use(bodyParser.json());

app.post('/login', (req, res) => {
  console.log('Received login request with body:', req.body);
  const { username, password } = req.body;

  if (username === 'admin' && password === 'admin') {
    res.status(200).json({ message: 'Login successful' });
  } else {
    res.status(401).json({ message: 'Invalid credentials' });
  }
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
