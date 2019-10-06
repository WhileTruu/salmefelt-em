const fs = require("fs");
const path = require("path");

function camelCasePath(str) {
  const parts = str.split(/[^A-Za-z0-9]/);
  if (parts.length === 1) return str;
  const rest = parts
    .slice(1)
    .filter(function(word) {
      return !word.match(/^([a-f0-9]{20}|[a-f0-9]{32})$/); // remove webpack `[hash]`
    })
    .map(function(word) {
      if (word.length === 1) return word.toUpperCase();
      return word.charAt(0).toUpperCase() + word.substr(1);
    });
  return [parts[0].toLowerCase(), rest.join("")].join("");
}

function readFilesIntoObject(trim, basedir, files) {
  return files.reduce(function(accumulator, file) {
    const fullPath = path.join(basedir, file);
    if (fs.statSync(fullPath).isDirectory()) {
      return readFilesIntoObject(trim, fullPath, fs.readdirSync(fullpath));
    }
    return Object.assign(accumulator, {
      [camelCasePath(fullPath.substr(trim.length + 1))]: fs.readFileSync(
        fullPath,
        "utf-8"
      )
    });
  }, {});
}

function readFileNamesIntoObject(trim, basedir, files) {
  return files.reduce(function(accumulator, file) {
    const fullPath = path.join(basedir, file);
    if (fs.statSync(fullPath).isDirectory()) {
      return readFilesIntoObject(trim, fullPath, fs.readdirSync(fullpath));
    }
    return Object.assign(accumulator, {
      [camelCasePath(fullPath.substr(trim.length + 1))]: fullPath.substr(
        trim.length
      )
    });
  }, {});
}

module.exports = {
  readFilesIntoObject,
  readFileNamesIntoObject
};
