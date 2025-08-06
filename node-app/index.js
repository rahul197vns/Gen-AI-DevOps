const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;
app.get('/', (req, res) => res.send('Node.js app deployed via GenAI DevOps'));
app.listen(PORT, () => console.log(`Running on port ${PORT}`));
