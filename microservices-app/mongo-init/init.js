// This script creates the necessary databases and users
db = db.getSiblingDB('admin');

// Create admin user if it doesn't exist
if (db.getUser("admin") == null) {
  db.createUser({
    user: "rayyan9477",
    pwd: "Nobility@2025",
    roles: [{ role: "userAdminAnyDatabase", db: "admin" }]
  });
}

// Auth service database
db = db.getSiblingDB('auth-service');
db.createUser({
  user: "rayyan9477",
  pwd: "Nobility@2025",
  roles: [{ role: "readWrite", db: "auth-service" }]
});

// Todo service database
db = db.getSiblingDB('todo-service');
db.createUser({
  user: "rayyan9477",
  pwd: "Nobility@2025",
  roles: [{ role: "readWrite", db: "todo-service" }]
});

// Create initial collections
db = db.getSiblingDB('auth-service');
db.createCollection('users');

db = db.getSiblingDB('todo-service');
db.createCollection('todos');
