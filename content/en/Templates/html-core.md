---
author: "Cristian Mosquera"
title: "Html Core"
date: 2020-06-04T17:46:12-04:00
lastmod: 2020-06-04T17:46:12-04:00
description: "Basic HTML template for any project"
draft: false
hideToc: false
enableToc: true
enableTocContent: false
tags: 
- HTML
- CSS
- JS
- Web-page
---

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">

  <title>The HTML5 Herald</title>
  <meta name="description" content="The HTML5 Content">
  <meta name="author" content="SitePoint">

  <link rel="stylesheet" href="css/styles.css?v=1.0">
  <script src="https://www.gstatic.com/firebasejs/7.14.6/firebase-app.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/p5@0.10.2/lib/p5.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/0.9.0/addons/p5.dom.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/p5@0.10.2/lib/addons/p5.sound.min.js"></script>
  <!-- <script src="sketch.js"></script> -->
</head>

<body>

  <script src="js/scripts.js"></script>
</body>
</html>
```

# Form template
* Credits: https://github.com/siwalikm/quick-form-css/blob/master/demoForm.html

```html
<html>

<head>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link rel="stylesheet" href="qfc-dark.css">
  <!-- <link rel="stylesheet" href="qfc-light.css"> -->

</head>

<body>
    <div class="qfc-container">
      <h2>Form Title</h2>
      <label>Description of Lorem ipsum dolor sit amet, consectetur adipiscing elit.</label>
      
      <form class="simple-form">  <!-- <form name="frm1" method="post" action="/" onsubmit="return greeting()"> -->
	<div>
          <div>
            <input id="usrfullname" placeholder="Full Name" type="text" required>
          </div>
          <div>
            <input id="usrphone" placeholder="Phone Number" type="tel" required>
          </div>
          <div>
            <input id="usremail" placeholder="Email Address" type="email">
          </div>
          <div>
            <label>Gender</label>
            <div>
              <label>
                <input type="radio" name="usrgender" checked="checked">Male
              </label>
            </div>
            <div>
              <label>
                <input type="radio" name="usrgender">Female
              </label>
            </div>
          </div>
          <div>
            <div>
              <input id="usrlikeform" type="checkbox" checked="checked">
              <label>Do you love this form?</label>
            </div>
          </div>
          <div>
            <label>Your City (single-select)</label>
            <select id="usrcity" id>
              <option disabled selected value="--">Select Your City</option>
              <option value="Bangalore">Bangalore</option>
              <option value="Chennai">Chennai</option>
              <option value="Kolkata">Kolkata</option>
            </select>
          </div>
          <div>
            <label>Favourite Foods (multi-select)</label>
            <select id="usrfood" multiple>
              <option value="Cheese">Cheese</option>
              <option value="Bacon">Bacon</option>
              <option value="Pasta">Pasta</option>
              <option value="Pizza">Pizza</option>
            </select>
          </div>
          <div>
            <label>Message (textarea)</label>
            <div>
              <textarea id="usrmessage" placeholder="Eg. Enter your messages here"></textarea>
            </div>
          </div>
          <div>
            <label>Attach file</label>
            <div>
              <input id="usrfile" type="file" id>
            </div>
          </div>
          <div>
            <button id="usrsubmit" type="submit" value="submit" onclick="return submitNow();">Submit</button>
          </div>
	</div>
      </form>
    </div>
    
    
    <script>      
        function submitNow() {      
        const data = prepareData();
        console.log("==Data==");
        console.log(data);       
        //alert("Submit button clicked!");
        return true;      
        }

    function prepareData(){
        const fullname=document.querySelector("#usrfullname").value;
        const phone=document.querySelector("#usrphone").value;
        const email=document.querySelector("#usremail").value;
        const gender=( document.querySelector('input[type=radio][name=usrgender]:checked').value=="on" ? "male":"female" );
        const likeform=(document.querySelector("#usrlikeform").value=="on");
        const cityel=document.querySelector("#usrcity");
        const city=cityel.options[cityel.selectedIndex].value;
        const foodel=document.querySelector("#usrfood");
        const food=Array.from(foodel).filter(el => el.selected).map(el => el.value);
        const msg=document.querySelector("#usrmessage").value;
        const file=document.querySelector("#usrfile").value;

        let date=new Date();
        let time=date.getTime(); //Time from 1970
        let utc=date.toJSON().slice(0,10).replace(/-/g,'/');

        const dataForm={
            date: firebase.firestore.Timestamp.fromDate(new Date("December 10, 1815")),
            time: time,
            fullname:fullname,
            phone:phone,
            email:email,
            gender:gender,
            likeform:likeform,
            city:city,
            food:food,
            msg:msg,
            file:file
        }
        
        return dataForm;
    }
    </script>      
</body>
<div style="padding-bottom:15px; font-family: 'Roboto';color:white;" align="center">
  made with <span style="color:#e25555;">❤</span> by <a target="_blank" href="https://twitter.com/">@Twitter</a> and the <a target="_blank" href="https://github.com/">internet</a></div>
<style>
  a {
    color :#00bcd4;
    text-decoration: none;
  }
</style>
</html>
```