// Step 1: Create / Switch to database
use shopDB

// Step 2: Create collection and insert 5 product documents
db.products.insertMany([
  { pid: 1, pname: "Smartphone", category: "Electronics", price: 15000, stock: 25 },
  { pid: 2, pname: "Laptop", category: "Electronics", price: 50000, stock: 10 },
  { pid: 3, pname: "T-Shirt", category: "Fashion", price: 800, stock: 100 },
  { pid: 4, pname: "Mixer Grinder", category: "Home Appliances", price: 3500, stock: 15 },
  { pid: 5, pname: "Headphones", category: "Electronics", price: 2000, stock: 0 }
]);

// Step 3: Display all products in the “Electronics” category
db.products.find({ category: "Electronics" });

// Step 4: Find all products where price > 5000
db.products.find({ price: { $gt: 5000 } });

// Step 5: Update stock count for a given product ID (pid = 5)
db.products.updateOne(
  { pid: 5 },
  { $set: { stock: 20 } }
);

// Step 6: Delete all products where stock = 0
db.products.deleteMany({ stock: 0 });

// Step 7: Use $and to find products with price > 1000 and stock < 50
db.products.find({
  $and: [
    { price: { $gt: 1000 } },
    { stock: { $lt: 50 } }
  ]
});

// Step 8: Use $or to find products in “Fashion” or “Home Appliances”
db.products.find({
  $or: [
    { category: "Fashion" },
    { category: "Home Appliances" }
  ]
});
