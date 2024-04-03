# Steps that led to this website project

## I'm using Hugo static site builder
> sudo apt-get install hugo

> cd public_html
> mkdir plotboilerplate-website
> cd plotboilerplate-website
> hugo new site .

### Install a Theme
I picked 'seven'.

> git init
> git config --global init.defaultBranch main
> git checkout main
> git submodule add https://github.com/maolonglong/hugo-simple.git themes/hugo-simple
> echo "theme = 'hugo-simple'" >> config.toml
> hugo mod npm pack
> npm install

### Same for theme
> cd themes/seven
> hugo mod npm pack
> npm install

> hugo new content posts/my-first-post.md


### Fixing CSS build error
> npm install postcss-cli
> npm i @fullhuman/postcss-purgecss

