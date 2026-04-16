const express = require('express');
const app = express();
app.get('/', (req, res) => res.send('API DevOps Operationnelle !'));
app.listen(3000, () => console.log('Server ready on port 3000'));
