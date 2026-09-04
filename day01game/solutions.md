# GitHub Flavored Markdown

* [John Gruber's original spec](http://daringfireball.net/projects/markdown/)
* [Github-flavored Markdown info page](http://github.github.com/github-flavored-markdown/)
* [Myndex's Cheat Sheet](https://gist.github.com/Myndex/5140d6fe98519bb15c503c490e713233)

----------------

# Table of Contents (H1)
Main topics H2, Sub-topics H3     
[Topic 1](#topic1)   
[Topic 2](#topic2)   
[Topic 3](#topic3)   
&nbsp;&nbsp;&nbsp; [Subtopic 1](#subtopic1)     
&nbsp;&nbsp;&nbsp; [Subtopic 2](#subtopic2)     
&nbsp;&nbsp;&nbsp; [Subtopic 3](#subtopic3)     

----------------

# Header 1
## Header 2
### Header 3
#### Header 4

----------------

Thick Horizontal line: Three (3) or more Hyphens, Asterisks, or Underscores

----------------

## Line Breaks 

To start a *new separate paragraph*, use two newlines.

Or you can end a line with four white spaces befor hitting return.    
The next line will start on the left.

If you do not put four whitespaces, then the text will be rendered
as one paragraphline wrapped together.

----------------

## Emphasis & Code/Syntax Highlighting

- Italics: aka Emphasis, use *asterisks* or _underscores_.     
- Boldface: aka Strong Emphasis, use **double asterisks** or __double underscores__.     
- Bold+Italic: aka Combined Emphasis, use **_double asterisks + underscores_**.     
- Strikethrough: use one tilde ~Scratch This~ or two tildes ~~Scratch this~~      
- Underline is reserved for links.

Inline `code` has `back-ticks` around it.

Blocks of code are fenced by lines with three back-ticks <code>```</code>.

Javascript:
```javascript
var mystring = "JavaScript syntax highlighting";
// comment
alert(mystring);
```

Python:
```python
mystring = "Python syntax highlighting"
// comment
print mystring
```

No language specified:
```
No language indicated.
let message = 'Press ENTER when done';
// comment
<b>tag</b>.
```

----------------

## Tables

Colons can be used to align columns.

| Tables        | Are           | Cool |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

The outer pipes (|) are optional, and you don't need to make the raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3

----------------

## Blockquotes

> This is a *block quote*. Pirate gibberish: Bounty belaying pin quarterdeck scuttle grog blossom red ensign hands pillage coxswain heave down. Pressgang long clothes walk the plank pirate driver parley heave down bilge execution dock overhaul. Crack Jennys tea cup scallywag Pirate Round rutters belay bowsprit bring a spring upon her cable Brethren of the Coast clap of thunder Jack Tar..

>> This is **also a block quote**. Pirate gibberish: Furl Buccaneer blow the man down take a caulk tender tackle booty lateen sail killick gangway. Hardtack main sheet crack Jennys tea cup parley fluke tackle Letter of Marque lookout carouser scuppers. Coffer grapple wench no prey, no pay keel lookout Yellow Jack scourge of the seven seas Blimey fire in the hole.

>>> Finally, a **third block quote**. Pirate gibberish: Splice the main brace heave down hulk provost killick Letter of Marque bilge rat flogging grog blossom Chain Shot. Warp to go on account gaff scallywag line man-of-war hands crack Jennys tea cup weigh anchor Sink me. Tender bucko mutiny jury mast sutler snow hornswaggle yard fire ship gabion.

----------------

### Details/Summary

<details>
  <summary><b>Summary line --- click here</b></summary>

  **Surprise!** -- Hidden text waiting to be revealed.  You can use markdown here     
  in the details section, but **_not_** in the summary above.     
  
</details>     

----------------

## Lists

Ordered list:

1. First ordered list item
2. Second ordered list item
    * Unordered sub-list (lead with 4 spaces)
3. Actual numbers don't matter, just that it's a number
    1. Ordered sub-list, lead with 4 spaces
        1. More sub, lead with 4 spaces
    2. previous sub
4. And another item.

Unordered list:

- This is a list
    - This is a sub list, lead with 4 spaces
        - and a further sublist, lead with 4 spaces
    - back down a few
    1. add in some ordered stuff
        1. sub ordered stuff
- Back to the first level
   
* Unordered list can use asterisks
- Or minuses
+ Or pluses

----------------

## Links

There are several ways to create links.

[Inline-style link](https://www.google.com)

[Reference-style link][case-insensitive reference]

[You can use numbers][1] for reference-style link definitions

Or leave it empty and use the [link text itself][]

This is useful when you are doing lots of cites [[2],[3]].

HTML links also work, if you need a "class" in your link: 
<a href="#Links" class="dismissed">HTML link</a>

Below links do not appear in final markdown output:

[case-insensitive reference]: https://git.myndex.com
[1]: http://apcacontrast.com
[link text itself]: http://tangledweb.xyz
[2]: http://bridgepca.com
[3]: https://linktr.ee/Myndex

----------------

## Notes

> [!NOTE]  
> This is a note.

> [!TIP]
> This is a tip.

> [!IMPORTANT]  
> This is important.

> [!WARNING]  
> This is a warning.

> [!CAUTION]
> This is a caution.

----------------

## HTML in Markdown

You can sometimes use raw HTML in your Markdown.

### Definitions

<dl>
  <dt>Definition list</dt>
  <dd>Is something people use sometimes.</dd>
  <dt>Markdown in HTML</dt>
  <dd>Does *not* work **very** well. Use HTML <em>tags</em>.</dd>
</dl>

SuperScript<sup>You *can* use **markdown** in ***superscript***</sup>

SubScript<sub>You *can* use **markdown** in ***subscript***</sub>

----------------

### HTML Tables

<table>
  <tr><th>HTML</th><th>Tables</th><th colspan="2">Are Possible</th></tr>
  <tr><th colspan="2">Dessert:</th><td>Jello</td><td>Whirrled</td></tr>
  <tr><td colspan="4" align="center">And more flexible</td></tr>
  <tr><td colspan="4" align="center">since you can use colspan</td></tr>
  <tr><td>And</td><td rowspan="2" colspan="2" align="center">rowspan</td><td>To</td></tr>
  <tr><td>Also</td><td>Boot</td></tr>
</table>

----------------

## Images

Here's a logo (hover to see the title text):

Inline-style: 
![don't forget to do alt text](https://avatars.githubusercontent.com/u/42009457?s=40&v=4 "Descriptive Alt Text Here")

Reference-style: 
![don't forget to do alt text, this is a logo][logo]     

[logo]: https://avatars.githubusercontent.com/u/42009457?s=40&v=4 "Descriptive Alt Text"     

Regular HTML image tags work and allow setting width, height, and classes for use with pages:

<img width="200" alt="Descriptive Alt Text" class="recess" src="https://avatars.githubusercontent.com/u/42009457?s=400&u=2dcba5c146315f82f802b8b58e92a4d6b82344b3&v=4">

----------------
