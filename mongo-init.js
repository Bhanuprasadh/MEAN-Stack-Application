// MongoDB initialization script
print('Starting MongoDB initialization script...');

// Switch to the application database
db = db.getSiblingDB('dd_db');
print('Switched to dd_db database');

// Create collections if they don't exist
if (!db.getCollectionNames().includes('tutorials')) {
  db.createCollection('tutorials');
  print('Created tutorials collection');
}

// Create indexes for better query performance
db.tutorials.createIndex({ "title": 1 }, { background: true });
db.tutorials.createIndex({ "createdAt": -1 }, { background: true });
db.tutorials.createIndex({ "published": 1 }, { background: true });
print('Created indexes on tutorials collection');

// Check if we already have data to avoid duplicate insertion
const count = db.tutorials.countDocuments();

if (count === 0) {
  // Insert sample data
  db.tutorials.insertMany([
    {
      title: "Node.js Basics",
      description: "Introduction to Node.js fundamentals for beginners",
      published: true,
      createdAt: new Date(),
      updatedAt: new Date()
    },
    {
      title: "MongoDB Tutorial",
      description: "Learn how to use MongoDB with Node.js applications",
      published: true,
      createdAt: new Date(),
      updatedAt: new Date()
    },
    {
      title: "Angular Components",
      description: "Understanding Angular components and their lifecycle",
      published: true,
      createdAt: new Date(),
      updatedAt: new Date()
    },
    {
      title: "Express.js Middleware",
      description: "How to create and use custom middleware in Express.js",
      published: false,
      createdAt: new Date(),
      updatedAt: new Date()
    },
    {
      title: "Docker for MEAN Stack",
      description: "Containerizing your MEAN stack application with Docker",
      published: true,
      createdAt: new Date(),
      updatedAt: new Date()
    }
  ]);
  print('Inserted 5 sample tutorials');
} else {
  print('Data already exists, skipping sample data insertion');
}

// Create an application user if it doesn't exist
if (!db.getUser('app_user')) {
  db.createUser({
    user: 'app_user',
    pwd: 'password',
    roles: [
      { role: 'readWrite', db: 'dd_db' }
    ]
  });
  print('Created application user');
} else {
  print('Application user already exists');
}

print('MongoDB initialization completed successfully');

