generate: src/Files.elm src/RawItems.elm

src/Files.elm: scripts/files-as-elm-methods.js $(shell find assets/images)
	node scripts/files-as-elm-methods.js assets/images > src/Files.elm

src/RawItems.elm: scripts/filecontent-as-elm-methods.js $(shell find static/items)
	node scripts/filecontent-as-elm-methods.js static/items > src/RawItems.elm