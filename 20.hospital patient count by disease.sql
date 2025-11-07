use hospitalDB;

// Sample Data
db.patients.insertMany([
  { pid: 1, pname: "Ravi", disease: "Flu", city: "Nashik" },
  { pid: 2, pname: "Amit", disease: "Covid", city: "Pune" },
  { pid: 3, pname: "Sneha", disease: "Flu", city: "Mumbai" },
  { pid: 4, pname: "Neha", disease: "Malaria", city: "Pune" },
  { pid: 5, pname: "Raj", disease: "Covid", city: "Nashik" },
  { pid: 6, pname: "Kiran", disease: "Typhoid", city: "Pune" },
  { pid: 7, pname: "Priya", disease: "Covid", city: "Mumbai" },
  { pid: 8, pname: "Arjun", disease: "Flu", city: "Pune" }
]);

// Map Function – emits disease and count 1
var mapFunction = function() {
  emit(this.disease, 1);
};

// Reduce Function – sums up all counts for each disease
var reduceFunction = function(key, values) {
  return Array.sum(values);
};

// Run MapReduce
db.patients.mapReduce(
  mapFunction,
  reduceFunction,
  { out: "disease_count" }
);

// Display results
print("Number of patients per disease:");
db.disease_count.find().forEach(printjson);
