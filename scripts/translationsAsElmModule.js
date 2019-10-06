#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

function capitalize(str) {
  return str.charAt(0).toUpperCase() + str.substr(1);
}

/*
type alias Translations =
    { slogan : String
    , homePageContent : String
    , email : String
    , emailAddress : String
    , phone : String
    , phoneNumber : String
    , contact : String
    , contactName : String
    , companyName : String
    , pageNotFound : String
    }

 */

function translationsToElm(translations) {
  const homepageContent = translations.homePageContent.replace(/\n/g, "\\n");
  return [
    `translations =`,
    `    { slogan = "${translations.slogan}"`,
    `    , homePageContent ="${homepageContent}"`,
    `    , email = "${translations.email}"`,
    `    , emailAddress = "${translations.emailAddress}"`,
    `    , phone = "${translations.phone}"`,
    `    , phoneNumber = "${translations.phoneNumber}"`,
    `    , contact = "${translations.contact}"`,
    `    , contactName = "${translations.contactName}"`,
    `    , companyName = "${translations.companyName}"`,
    `    , pageNotFound = "${translations.pageNotFound}"`,
    `    }`
  ].join("\n");
}

const filePath = process.argv.slice(2)[0];
const fileContent = fs.readFileSync(filePath, "utf-8");

console.log(
  `module Translations.${capitalize(
    path.basename(filePath, ".json")
  )} exposing (translations)`
);
console.log("");
console.log("");
console.log(translationsToElm(JSON.parse(fileContent)));
