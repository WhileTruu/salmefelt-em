#!/usr/bin/env node

const fs = require("fs");
const { readFileNamesIntoObject } = require("./util");

let listing = {};

process.argv.slice(2).forEach(function(basedir) {
  listing = readFileNamesIntoObject(basedir, basedir, fs.readdirSync(basedir));
});

console.log("module Files exposing");
Object.keys(listing).forEach(function(key, index) {
  var prefix = "    ,";
  if (index === 0) prefix = "    (";
  console.log(prefix, key);
});
console.log("    )");
Object.keys(listing).forEach(function(key) {
  console.log("");
  console.log("");
  console.log(key, ": String");
  console.log(key, "=");
  console.log("    " + JSON.stringify(listing[key]));
});
