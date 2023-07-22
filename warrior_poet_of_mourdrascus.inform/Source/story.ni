"WARRIOR POET OF MOURDRASCUS" by Michael J Stevens

Include Basic Screen Effects by Emily Short.
Include Menus by Emily Short.
Include Questions by Michael Callaghan.

Release along with a website, an interpreter, a solution, the introductory booklet, and the private source text.

Part 0 - Setup

Section 1 - Global

Understand "ex [something]" as examining.
Understand "x [something]" as examining.

Section 2 - Gold Pieces, Prices and Buying

Every thing has a number called a price. The price of a thing is usually 0. After examining something for sale, say "Its price in pieces of gold is [the price of the noun]."

Definition: a thing is free if the price of it is 0.
Definition: a thing is for sale if it is not free.

Instead of taking something for sale:
	say "That must be bought first."

Instead of buying something not for sale:
	say "That is not for sale." instead.

The player carries a coin pouch. The coin pouch contains gold. The price of the gold is 1. The printed name of the gold is "[price of the gold] gold pieces".  Understand "gold pieces" as the gold.

Before buying something for sale when the gold is not in the coin pouch:
	say "Your coin pouch is empty." instead.

Before buying something for sale when the price of the gold is 0:
	say "Your coin pouch is empty." instead.

Before buying something for sale when the price of the gold is less than the price of the noun:
	say "[the noun] costs [the price of the noun], but you only have [the price of the gold]." instead.
	
Instead of buying something:
	decrease the price of the gold by the price of the noun;
	say "You take [the price of the noun] from your coin pouch and hand it over for [the noun], leaving yourself with [the price of the gold].";
	if the gold is free:
		now the gold is nowhere;
	now the price of the noun is 0;
	now the player is carrying the noun.

Section 3 - Starting Inventory




Section 4 - Beginning

After printing the banner text:
	say "[line break][line break]    THE TREK ACROSS the sands of the Infinite Desert stressed your ability to maintain meditative selflessness to its limits. Mile after mile of dunes went by under the slow plodding gait of your Ashen camel, countless nights passing while you traveled, each one the same as the one before. The brutal sun pierced your crude shelter during the days, penetrating your dreams while you suffered fitful sleep until the cooler nights allowed you to continue on.
[line break][line break]     If not for your training in mental discipline from the College of Myth and Legend back in your home city of Mourdrascus, you would have been a mumbling headcase halfway into the journey, lost to the sands like many foolish travelers who venture alone into the Infinite Sands, unprepared for its unending torment of boiling heat and dismal emptiness.
[line break][line break]     Finally you have arrived in the flourishing coastal city of Dol Bannath.  The onset of dizzying culture shock again tests your cognitive durability as the sights, smells and sounds of civilization assault your sensitive faculties. Your camel, having taken you across the greatest stretches of the sand sea, is now worth much more in trade than as transportation, so you trot your animal companion into the Camel Pit at the Market Square, and consider your options for selling the beast."


Part 1 - City of Dol Bannath

Chapter 1 -  Camel Pit in Market Square

Section 1 - Places

Camel Pit is a room. "[if the player is carrying the Ashen camel]Several merchants await customers in the pit.  To the west is a merchant in rich red robes, to the north is a merchant with an eye patch, and to the east a merchant in exotic green garb calls out to you.[otherwise]XXXXXXXXX[end if]"

Red Robed Merchant's Tent is west of Camel Pit. "Rich red silks and flowing embroidered cotton adorn the merchant under her billowing canopy.

[if unvisited]She greets you warmly and strolls around your animal, inspecting its teeth and coat. 'A fine Ashen camel, young traveller. I cannot offer you her full worth in coin; but, along with forty gold pieces, I can give you this silver dirk, a much superior weapon to the small knife on your belt.'[otherwise]The merchant greets you as you return to her tent.  'Still thinking about the silver dirk I see?'[end if]"

Blue Robed Merchant's Tent is north of Camel Pit. "Despite a patch over one eye, the flashy jewelry and expensive looking, royal blue robes worn by the camel merchant suggest both class and taste.

[if unvisited]He avoids small talk as he examines your mount, prodding and squeezing its hindquarters and lifting each of the animal’s hooves from the gound to inspect it. 'Your camel has traveled far but is no worse for wear,' he says finally. 'I see from the amulet you wear that you hail from the College of Myth and Legend in far off Mourdrascus. To pay you in gold for this camel would leave me with scant funds for turthger business today, however, you may be interested in this Gleaming Poet’s Eye I have to trade. I can offer it to you along with forty gold pieces for the animal.'

He shows you the Eye, a dark blue gem set into a silver base which sits against the forehead and adds to the effect of a Poet’s rhymes.[otherwise]The merchant sees you returning and raises the eyebrow above his working eye.  'Welcome back traveller.  Are you interested in my offer?'[end if]"

Green Robed Merchant's Tent is east of Camel Pit. "The camel merchant’s robe, the color of spearmint leaves, is sashed by a belt of golden silk.

[if unvisited]She smiles and offers you a cup of fresh water before taking time to examine your animal. 'I had my eye on you when you led this sturdy mount into the pit,' she says while holding her hand before the beast’s hissing nostrils. 'You have made a long journey through the desert, haven’t you, traveller? And your fine Ashen camel served you well. But now your journey takes you away from the burning sands, but to what destination? I cannot pay you enough in gold for this specimen’s worth, but I can offer you a sturdy leather chest piece with matching vambraces and greaves to protect you on your travels in these lands, as well as forty gold pieces.'[otherwise]The merchant in her green robes nods as you return to her tent.  'Have you reconsidered?'[end if]"

Section 2 - Things

The Ashen camel is a thing.  The player carries the Ashen camel.

The Silver Dirk is a thing.
The Gleaming Poet's Eye is a thing that is wearable.
The Leather Armor is a thing that is wearable.

Section 3 - Actions

Instead of going west from the Camel Pit when the player is not carrying the Ashen camel:
	say "You don't need to talk to the camel merchant again.  Time to leave the camel pit."

Instead of going north from the Camel Pit when the player is not carrying the Ashen camel:
	say "You don't need to talk to the camel merchant again.  Time to leave the camel pit."

Instead of going east from the Camel Pit when the player is not carrying the Ashen camel:
	say "You don't need to talk to the camel merchant again.  Time to leave the camel pit."
	
Instead of going south from the Camel Pit when the player is carrying the Ashen camel:
	say "You should sell your camel before you leave the Camel Pit."

After going to the Red Robed Merchant's Tent:
	say "[bold type]Red Robed Merchant's Tent[roman type][line break][the description of the Red Robed Merchant's Tent][line break][line break]";
	now the Red Robed Merchant's Tent is visited;
	now the current question is "You can trade your camel for forty gold pieces and the dirk, or you can try another merchant.  Would you like to trade?";
	ask a closed question, in yes/no mode.

After going to the Blue Robed Merchant's Tent:
	say "[bold type]Blue Robed Merchant's Tent[roman type][line break][the description of the Blue Robed Merchant's Tent][line break][line break]";
	now the Blue Robed Merchant's Tent is visited;
	now the current question is "You can trade your camel for forty gold pieces and the Poet’s Eye, or you can try another merchant.  Would you like to trade?";
	ask a closed question, in yes/no mode.

After going to the Green Robed Merchant's Tent:
	say "[bold type]Green Robed Merchant's Tent[roman type][line break][the description of the Green Robed Merchant's Tent][line break][line break]";
	now the Green Robed Merchant's Tent is visited;
	now the current question is "You can trade your camel for forty pieces of gold and the leather armor, or you can try another merchant.  Would you like to trade?";
	ask a closed question, in yes/no mode.

A yes/no question rule (this is the confirm camel trade rule):
	if the location is the Red Merchant's Tent:
		if the decision understood is Yes:
			now the player carries the Silver Dirk;
			accept the trade for the camel;
		otherwise:
			move the player to the Camel Pit;
	otherwise if the location is the Blue Robed Merchant's Tent:
		if the decision understood is Yes:
			now the player wears the Gleaming Poet's Eye;
			accept the trade for the camel;
		otherwise:
			move the player to the Camel Pit;
	otherwise if the location is the Green Robed Merchant's Tent:
		if the decision understood is Yes:
			now the player wears the Leather Armor;
			accept the trade for the camel;
		otherwise:
			move the player to the Camel Pit.
		
To accept the trade for the camel:
	say "[line break]The merchant hands you your items and says, 'Excellent. You have made a fine trade today, traveller.' He leads your camel away.";
	increase the price of the gold by 40;
	now the Ashen camel is nowhere;
	move the player to the Camel Pit.

Section 4 - Scenes


Clamoured is a room. 
"
Greatly, she clamoured
Not stone for me, nay
ye be so enamoured,
let all be astray!
"

XYZ is a room.
"
Some that come find not that thought
Which cream did dream his glower turned sour.

But this is a magic spell, so here!"



	

