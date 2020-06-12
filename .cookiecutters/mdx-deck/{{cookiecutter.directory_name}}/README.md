# Compiling/serving/whatever

```sh
# First, in order to prepare to do anything else:
cd /path/to/project/
npm install
```

```sh
# To run in a local server
npm start
```

```sh
# To build into html with a js bundle in the directory `public
npm run-script build
```

```sh
# To build into a pdf
npm run-script pdf
```

# Notes

Some things to avoid looking up or figuring out again:

## Images

To serve an image from within the repo...

```markdown
import img_name from './assets/img_name.png';

<img src={img_name} />
```

*note*: the blank line after the import is necessary

## Presenter notes

These only show up in presenter mode and are not displayed to the audience

```markdown
<!-- to make a presenter-only note -->
<Notes>
Note to self: imagine everyone else in their underpants
</Notes>
```

## Themes

The "included" themes are listed here with preview images: [mdx-deck themes docs](https://github.com/jxnblk/mdx-deck/blob/master/docs/themes.md)
