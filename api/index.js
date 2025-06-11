const express = require('express');
const promClient = require('prom-client');
const app = express();
const PORT = 3000;

// Initialisation Prometheus
const collectDefaultMetrics = promClient.collectDefaultMetrics;
collectDefaultMetrics();

const register = promClient.register;

app.get('/status', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date() });
});

// Endpoint Prometheus
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', register.contentType);
  res.end(await register.metrics());
});

app.listen(PORT, () => {
  console.log(`API disponible sur http://localhost:${PORT}`);
  console.log(`Metrics Prometheus sur http://localhost:${PORT}/metrics`);
});