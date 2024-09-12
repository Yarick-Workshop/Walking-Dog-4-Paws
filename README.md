
Shield: [![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]
<!-- Thanks to this Guy: https://github.com/santisoler/cc-licenses?tab=readme-ov-file#cc-attribution-noncommercial-sharealike-40-international-->
This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

# 4-Paws Walking Dog 3D Model
<p align="center" width="100%">
    <img width="80%" src="media/logo.png">
</p>

A 3D model of a 4-paws walking dog toy. The model was designed for producing on a 3D printer.

⚠️ **In case of any questions** – do not hesitate to contact the author in Telegram group ([see below](#contact-me)) and ask.


## HOWTO

⚠️ Before assembling read the topic to the bottom!

This 3D model is highly customizable. So you can configure it for you needs.


### Pre-rendered STL

If you do not need any customizations and would only like to have the same "Walking dog" toy as I have – you can download prerendered STL files: 
 * https://t.me/YarickWorkshop/533 - version with rounding;
 * https://t.me/YarickWorkshop/534 - with chamfers;
 * https://t.me/YarickWorkshop/535 - angular version.


**But do not be in hurry and read the manual there as well**. First of all print only the test figures and check if your fasteners and shafts fit well.

In case the test figures are not fit or you would like to customize the walking dog – you can "polish" the model's parameters.

There are several *".scad"* files in the project folder. Most of them are just libraries. Open **"Dog.scad"** to get the 3D model itself.

### Model Parameters

I used self-explanatory names for OpenSCAD model parameters. But if you still have any questions – [contact me](#contact-me).

⚠️ **Pay attention:**
1) There are three modes: *"Preview"*, *"Producing"* and *"Demo"* (See *"General"* -> *"renderingType"* parameter): 
 * *"Preview"* allows to see the toy as if it was assembled;
 * **If you are going to print parts** – choose *"Producing"*;
 * *"Demo"* can be used to create a 3D scene as on the Logo (see above). It takes **more than 1 hour to render.**

2) If you'd like to have **the rounded corners or chamfers** on the model - there are two parameters (see the *"General"* group):
    * *"rounding"*  – rounding type. **It takes too much time** to apply the effect. So, adjust any other parameters and apply either rounding or chamfer at the latest stage. And take some coffee 😉. Possible values:
        |Value|Description|Correct name as for real engineers|Takes time to apply|
        |--|--|--|--|
        |*"Off"*|Neither rounding or chamfer|-|Less than a second|
        |*"Cone"*|Conical rounding|**Chamfer**|~30 minutes|
        |*"Sphere"*|Spherical rounding|**Rounding**|~60 minutes|
    * *"roundingRadius"* – rounding radius / chamfer height (depending on selected value of the *"rounding"* parameter);



After modifying parameters look in OpenSCAD Console. Calculated debugging values were added there:

```
ECHO: "Results: "
ECHO: "  Scale factor: ", 0.200348
ECHO: 
ECHO: "  Wheel: "
ECHO: "      Diameter: ", 42.4739
ECHO: "      Spacer wall thickness: ", 4.15
ECHO: "      Wheel pair width: ", 21.4
ECHO: 
ECHO: "  Side: "
ECHO: "      Total length: ", 112
ECHO: "      Total height: ", 66.0701
ECHO: 
ECHO: "  Others: "
ECHO: "      Total width: ", 35
ECHO: "      Screw rod length: ", 32.6
```
They are YAML-like and hierarchically grouped. So you can customize the model for your needs and see the results in the Console log.


### Print Settings

Here is an example of my **printing parameters**:

|Name|Value|Comment|
|--|--|--|
|Nozzle diameter|0.4 mm|0.5, 0.6 and even 1 mm could could also be fine. Try!|
|Layer height/First layer height|0.2 mm|It can be any from 0.8 up to 2.4 mm and (may be) even more. So everything is up to You!|
|Perimeters|3|3 is enough but 4 for wheels can be better 🧔|
|Solid layers - top/bottom|6||
|Fill density|25%|15% should be enough but I wanted to have more solid toy|
|Fill pattern|Cubic|It is not critical|
|Supports|Not needed|The model was designed to be printed without any supports|
|Filament|CoPET(PETG)|PLA or ABS would would also be fine. I'd also like to try FLEX for paws (but haven't checked it yet)|

It is just an example. So you can play with yours 🙂. 

It took me ~10 hours to print (in general ~12 hours) on my Graber i3 printer. Printing time depends on kind on printer and the printing parameters. 


### Assembling

To assemble the walking dog you will need the next **Tools and Materials**: 

|Name|Quantity|Comment|
|--|--|--|
|Drill bit ⌀ 3-3.2 mm|1|To polish the 3 mm holes|
|Drill bit ⌀ 4.5-4.8 mm|1|To polish paw holes|
|Drill|1|Even a primitive one because it will be used for drilling plastic parts only|
|PTFE tube ⌀ 4 mm or a gel pen refill ⌀ ~4.3 mm|1|It will be used for the paw-wheels shaft. **PTFE tube is much better** but a pen refill can be used instead|
|M3 x 35 screws|5||
|M3 nuts|5||
|Screw driver|1||
|File|1|To shorten the screws & adjust the tenons on the paws|
|Filament| ~ 100 g | With different(?) colours|
|3D printer|1| Or a friend with a 3D printer 😉|


⚠️ If you have everything from the table above **follow one of the next assembling video manual links**: 
|URL|Comment|
|--|--|
|https://youtu.be/OoCZ0ncWTXQ|Russian but with English subtitles|
|https://t.me/YarickWorkshop/532|The same video on Telegram. Russian language only|


*I tried to do my best translating subtitles to English. But if you see something could be fixed - [let me know](#contact-me), please! And I will update the text. The same for text here as well. Thank you in advance!*


## Contact me
To follow the progress go to my channels:
  - Telegram: [https://t.me/YarickWorkshop](https://t.me/YarickWorkshop/316)
  - YouTube: https://www.youtube.com/@yarick-workshop

Yeah, they both are in Russian.

**If you have any questions** – contact me in either Telegram channel (see above) or Mail: techno.man.983@gmail.com. I can communicate in English without any problems. 

⚠️ **Pay attention**: I do not respond to any comments on YouTube (despite I read them). Why? It is a HUGE secret 🙃
