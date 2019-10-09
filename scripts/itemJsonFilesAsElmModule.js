#!/usr/bin/env node
// https://gist.github.com/choonkeat/b9959168e15d813d9f8a84d0e2c9632a

const fs = require("fs");
const { readFilesIntoObject } = require("./util");

/*
type alias Item =
    { titleEn : String
    , titleEt : String
    , date : Time.Posix
    , priority : Int
    , bodyEn : String
    , bodyEt : String
    , galleryImages : List String
    }

 */

function itemToElm({ functionName, content }) {
  return [
    `${functionName} : Item`,
    `${functionName} =`,
    `    { titleEn = "${content.titleEn}"`,
    `    , titleEt = "${content.titleEt}"`,
    `    , date = Time.millisToPosix ${Date.parse(content.date)}`,
    `    , priority = ${content.priority}`,
    `    , bodyEn = "${content.bodyEn}"`,
    `    , bodyEt = "${content.bodyEt}"`,
    `    , galleryImages =\n${galleryImagesToElmList(
      content.galleryImages.map(s =>
        s
          .replace(/\/uploads\//g, "/images/")
          .split(".")[0]
          .concat(".jpg")
          .slice(1)
      )
    )}`,
    `    }`
  ].join("\n");
}

function galleryImagesToElmList(images) {
  const a = images
    .slice(1)
    .map(a => `        , "${a}"`)
    .join(`\n`);
  return `        [ "${images[0]}"\n${a.length ? a + "\n" : a}        ]`;
}

// Elm module generation

let listing = {};

process.argv.slice(2).forEach(function(basedir) {
  listing = readFilesIntoObject(basedir, basedir, fs.readdirSync(basedir));
});

console.log("module Items exposing");
new Array("all").concat(Object.keys(listing)).forEach(function(key, index) {
  let prefix = "    ,";
  if (index === 0) prefix = "    (";
  console.log(prefix, key);
});
console.log("    )");
console.log("import Item exposing (Item)");
console.log("import Time");
console.log("");
console.log("");
console.log("all : List Item");
console.log("all =");
Object.keys(listing).forEach(function(key, index) {
  let prefix = "    ,";
  if (index === 0) prefix = "    [";
  console.log(prefix, key);
});
console.log("    ]");

Object.keys(listing).forEach(function(key) {
  console.log("");
  console.log("");
  console.log(
    itemToElm({ functionName: key, content: JSON.parse(listing[key]) })
  );
});
