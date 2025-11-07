use libraryDB;

// Sample Data
db.books.insertMany([
  { id: 1, title: "DBMS Concepts", author: "Korth", category: "Database", price: 500 },
  { id: 2, title: "Operating System", author: "Silberschatz", category: "System", price: 650 },
  { id: 3, title: "C Programming", author: "Dennis Ritchie", category: "Programming", price: 400 },
  { id: 4, title: "Java Complete Reference", author: "Herbert Schildt", category: "Programming", price: 750 },
  { id: 5, title: "NoSQL Databases", author: "Pramod Sadalage", category: "Database", price: 600 }
]);

// Map Function – emits category and count 1
var mapFunction = function() {
  emit(this.category, 1);
};

// Reduce Function – sums up the count for each category
var reduceFunction = function(key, values) {
  return Array.sum(values);
};

// Run MapReduce
db.books.mapReduce(
  mapFunction,
  reduceFunction,
  { out: "category_count" }
);

// Display results
print("Books count per category:");
db.category_count.find().forEach(printjson);
