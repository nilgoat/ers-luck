
all: ers.love

ers.love:
	zip -9 -r $@ . -x './.editorconfig' './.gitignore' './.git/*'
