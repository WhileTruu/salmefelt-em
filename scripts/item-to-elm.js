#!/usr/bin/env node

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
    `    , bodyEt = "${content.bodyEn}"`,
    `    , galleryImages =\n${galleryImagesToElmList(content.galleryImages)}`,
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

module.exports.itemToElm = itemToElm;
