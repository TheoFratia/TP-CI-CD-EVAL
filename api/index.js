const express = require('express');
const app = express();
const PORT = 3000
;

app.get('/status', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date() });
});

app.listen(PORT, () => {
  console.log(`API disponible sur http://localhost:${PORT}`);
});