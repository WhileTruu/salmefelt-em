generate: src/Files.elm src/Items.elm

src/Files.elm: scripts/files-as-elm-methods.js $(shell find assets/images)
	node scripts/files-as-elm-methods.js assets/images > src/Files.elm

src/Items.elm: scripts/item-json-files-as-elm-module.js $(shell find static/items)
	node scripts/item-json-files-as-elm-module.js static/items > src/Items.elm