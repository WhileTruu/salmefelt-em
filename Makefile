generate: src/Files.elm

src/Files.elm: scripts/files-as-elm-methods.js $(shell find assets/images)
	node scripts/files-as-elm-methods.js assets/images > src/Files.elm

