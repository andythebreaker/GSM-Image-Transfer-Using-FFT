const fs = require("fs");
const path = require("path");

// Get the current directory
const cwd = process.cwd();

// Get all the files in the current directory
const files = fs.readdirSync(cwd);

// Create a new CSV file
const csvFile = fs.createWriteStream("all-files.csv");

// Write the header row to the CSV file
csvFile.write("file,size\n");

// Iterate over all the files
files.forEach(file => {
  // Get the file size
  const size = fs.statSync(path.join(cwd, file)).size;

  // Write the file name and size to the CSV file
  csvFile.write(`${file},${size}\n`);
});

// Close the CSV file
csvFile.close();
