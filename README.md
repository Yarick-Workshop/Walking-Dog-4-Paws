
Shield: [![CC BY-NC-SA 4.0][cc-by-nc-sa-shield]][cc-by-nc-sa]
<!-- Thanks to this Guy: https://github.com/santisoler/cc-licenses?tab=readme-ov-file#cc-attribution-noncommercial-sharealike-40-international-->
This work is licensed under a
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License][cc-by-nc-sa].

[![CC BY-NC-SA 4.0][cc-by-nc-sa-image]][cc-by-nc-sa]

[cc-by-nc-sa]: http://creativecommons.org/licenses/by-nc-sa/4.0/
[cc-by-nc-sa-image]: https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png
[cc-by-nc-sa-shield]: https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg

# Walking Dog 3D Model
<p align="center" width="100%">
    <img width="50%" src="/media/logo.png">
</p>

A 3D model of a walking dog toy. The model was designed for producing on a 3D printer.

⚠️ **In case of any questions** – do not hesitate to contact the author in Telegram group ([see below](#contact-me)) and ask.


## HOWTO

Before assembling read the topic to the bottom!


### Model Parameters

This 3D model is highly customizable. I used self-explanatory names for OpenSCAD model parameters. But if you still have any questions – [contact me](#contact-me).

There are two modes: "Preview" and "Producing". See "General" -> "renderingType" parameter. "Preview" allows to see the toy as if it was assembled. ⚠️ **If you are going to print parts** – choose "Producing".

After modifying parameters look in OpenSCAD Console. Calculated debugging values were added there:

```
ECHO: "Results: "
ECHO: "  Scale factor: ", 0.200348
ECHO: 
ECHO: "  Wheel: "
ECHO: "      Diameter: ", 42.4739
ECHO: "      Spacer wall thickness: ", 1.65
ECHO: "      Width: ", 4.2
ECHO: 
ECHO: "  Side: "
ECHO: "      Total length: ", 112
ECHO: "      Total height: ", 66.0701
ECHO: 
ECHO: "  Others: "
ECHO: "      Total width: ", 21
ECHO: "      Screw rod length: ", 18.6
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

It took me around 6.5 hours to print (in general around 8 hours) on my Graber i3 printer. Printing time depends on kind on printer and the printing parameters. 


### Assembling

To assemble the walking dog you will need the next **Tools and Materials**: 

|Name|Quantity|Comment|
|--|--|--|
|Drill bit ⌀ 3 mm(?)|1|In my case it was not required|
|Drill bit ⌀ 4.5 mm|1||
|Drill|1|Even a primitive one because it will be used for drilling plastic parts only|
|Gel pen refill ⌀ ~4.3 mm|1|It will be used as a shaft for paw-wheels|
|M3 x 20 screws|5||
|M3 nuts|5||
|Screw driver|1||
|File|1|To shorten the screws|
|Filament| ~ 100 g | With different(?) colours|
|3D printer|1| Or a friend with a 3D printer 😉|

⚠️ If you have everything from the table above **follow the next assembling video manual**: https://youtu.be/4ERVy12Y__E

Yeah it is in Russian but there are English subtitles too. I tried to do my best translating them to English. But if you see something could be fixed - [let me know](#contact-me) please and I will update the text. The same for text here as well. Thank you in advance!


## Contact me
To follow the progress go to my channels:
  - Telegram: [https://t.me/YarickWorkshop](https://t.me/YarickWorkshop/316)
  - YouTube: https://www.youtube.com/@yarick-workshop

Yeah, they both are in Russian.

**If you have any questions** – contact me in either Telegram channel (see above) or Mail: techno.man.983@gmail.com. I can communicate in English without any problems. 

⚠️ **Pay attention**: I do not answer to any comments on YouTube (despite I read them). Why? It is a HUGE secret 🙃
