const fs = require('fs');
const csv = require('csv-parser');

// Read the CSV file from stdin
const data = fs.readFileSync(0, 'utf8')
  .split('\n')
  .map(csv.parse);

// Convert the data to a Markdown table
const markdown = data.map(row => row.map(value => `| ${value} |`).join('\n')).join('\n|---|\n');

// Print the Markdown table to stdout
console.log(markdown);
