---
author: "Cristian Mosquera"
title: "P5JS HTML Bundle"
date: 2020-05-30T18:09:26-04:00
lastmod: 2020-05-30T18:09:26-04:00
description: "Initial p5js template with sources from CDN"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- Processing
- js
- Javascript
- p5js
---

# P5js Template: Loading local p5.js script

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Demo P5.js</title>

    <script src="https://cdn.jsdelivr.net/npm/p5@0.10.2/lib/p5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/addons/p5.dom.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/p5@0.10.2/lib/addons/p5.sound.min.js"></script>
    <script src="sketch.js"></script>
  </head>
  <body>
  </body>
</html>
```

# P5js Template: Embedded p5.js script

```html
<!DOCTYPE html>
<html>
  <head>
    <script src="https://cdn.jsdelivr.net/npm/p5@1.0.0/lib/p5.js"></script>
    <script>
        function setup() {
        createCanvas(400, 400);
        }

        function draw() {
        if (mouseIsPressed) {
            fill(0);
        } else {
            fill(255);
        }
        ellipse(mouseX, mouseY, 80, 80);
        }    
    </script>
  </head>
  <body>
  </body>
</html>
```

# P5js Template: Loading a local image
```html
<!DOCTYPE html>
<html>
  <head>
    <title>Fetching image</title>
    <script src="https://cdn.jsdelivr.net/npm/p5@1.0.0/lib/p5.js"></script>
    <script>
      
      //const site = 'https://covers.openlibrary.org/b/id/295577-S.jpg';
      const site = 'drake2.png'; 

      async function catchImage(){
        const res = await fetch(site);
        const blob = await res.blob();
        
        document.getElementById('showcase').src = URL.createObjectURL(blob);
      }
      catchImage().catch(error => {
        console.log('ERROR')
        console.error(error)
      });
      
</script>
  </head>
  <body>
    <img src="" id="showcase" />
  </body>
</html>
```
