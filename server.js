const express = require('express');
const path = require('path');
const compression = require('compression');
const helmet = require('helmet');

const app = express();
const PORT = process.env.PORT || 3000;

// Security and performance middleware
app.use(helmet({
  contentSecurityPolicy: false // Adjust based on your needs
}));
app.use(compression());

// View engine setup
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Static files
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.get('/', (req, res) => {
  res.render('index', {
    title: 'KidzView - Live Streaming for PlaySchools | Parents Watch Kids Live',
    description: 'Let parents watch their kids live from your PlaySchool. 8 HD cameras, unlimited parent access, secure & private. Modern mobile app & web portal for preschools.',
    keywords: 'KidzView, playschool live streaming, preschool cameras, parent monitoring, daycare cameras, nursery live stream, playschool app, parent app, child safety'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).render('404', {
    title: '404 - Page Not Found | KidzView'
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 KidzView website is running on http://localhost:${PORT}`);
});

