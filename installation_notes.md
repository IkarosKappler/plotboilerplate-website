# Steps that led to this website project

Hugo version:
```
hugo v0.124.1-db083b05f16c945fec04f745f0ca8640560cf1ec linux/amd64 BuildDate=2024-03-20T11:40:10Z VendorInfo=gohugoio
```

Definitely working with:
hugo_0.127.0_linux-amd64.deb


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


## Run Hugo
> hugo server


## Install a CSS-Postprocessor (tailwindcss)
Afer picking a theme (papermod) I noticed that the CSS files are all static.

For more flexibility I need a CSS postprocessor, so I choose to try sass.

> npm i sass
> put.css --watch



## Generate typedocs
```
npm run mk-typedocs
```
After this run Hugo again.


# Using a nice theme for the Typedoc documents
> npm install typedoc-material-theme
> npm i typedoc-theme-hierarchy
> npm install @mxssfd/typedoc-theme

