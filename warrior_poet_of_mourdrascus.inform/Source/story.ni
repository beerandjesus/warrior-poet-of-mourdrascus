"WARRIOR POET OF MOURDRASCUS" by Charles M Ball

Include Basic Screen Effects by Emily Short.
Include Menus by Emily Short.
Include Questions by Michael Callaghan.

Release along with a website, an interpreter, and the introductory booklet.

Volume 1 - Setup

Part 1 - Testing Scenarios

Test scenarioBlueAlleyway with "test camelpit / test bluemerchant / test alleyway".
Test scenarioGreenAlleyway with "test camelpit / test greenmerchant / test alleyway".
Test scenarioRedAlleyway with "test camelpit / test redmerchant / test alleyway".

Test scenarioChapel with "test camelpit / test redmerchant / test chapel".
Test scenarioTenflowers with "test camelpit / test greenmerchant / test tenflowers".

Part 2 - Global

Understand "ex [something]" as examining.
Understand "x [something]" as examining.

A thing can be keepworthy or unkeepworthy.  A thing is usually unkeepworthy.
Instead of dropping something that is keepworthy, say "You would rather keep that."
Instead of taking off something that is keepworthy, say "You would rather keep that on."
Instead of giving something that is keepworthy to someone, say "You would rather keep that."
Instead of inserting something that is keepworthy into something that is not carried by the player, say "You would rather keep that."
Instead of putting something that is keepworthy on something, say "You would rather keep that."

Part 3 - Gold Pieces, Wealth and the Bank

A gold piece is a kind of thing.

To decide what number is the wealth of (the wealthy - a person):
	let x be 0;
	repeat with gp running through gold pieces carried by the wealthy:
		increase x by 1;
	decide on x.
	
The Bank is a room.  60 gold pieces are in the Bank.

To make the player richer by (x - a number):
	repeat with N running from 1 to x:
		let gp be a random gold piece in the Bank;
		move the gp to the player.
	
Part 4 - Price and Buying

Every thing has a number called a price. The price of a thing is usually 0. After examining something for sale, say "Its price is [the price of the noun] gold pieces."

Definition: a thing is free if the price of it is 0.
Definition: a thing is for sale if it is not free.
	
The block buying rule is not listed in the check buying rules.

Instead of taking something that is for sale, say "You would need to buy that first."
Instead of buying something not for sale, say "That is not for sale."

Before buying something for sale:
	if the wealth of the player is 0:
		say "Hard times -- you are flat broke." instead;
	otherwise if the wealth of the player is less than the price of the noun:
		say "[The noun] costs [the price of the noun] gold pieces, but you only have [the wealth of the player]." instead.

Check buying something for sale:
	let x_paid be 0;
	repeat with gp running through gold pieces carried by the player:
		if x_paid is less than the price of the noun:
			move the gp to the Bank;
			increase x_paid by 1;
		otherwise:
			break;
	say "You hand over [the price of the noun] gold piece[s] for [the noun].";
	now the price of the noun is 0;
	now the player is carrying the noun.
	
Part 5 - Giving and Desiring

The block giving rule is not listed in the check giving it to rules.

[We will not allow implicit taking while giving, anything given must be carried by the player.]
Rule for implicitly taking while the current action is giving:
	say "You will have to be carrying that before you can give it away." instead.

[People must want to receive something in order for it to be given to them.]
Desiring relates various people to various things.

The verb to desire means the desiring relation.

[We will control what is desired by its category.  The category is expected to be the name of its specific kind (e.g., furniture, fruit, etc.) or a unique thing (e.g. "Scepter of Asmodeus").]
Every thing has a text called the category.

The category of a gold piece is usually "gold pieces".

When play begins:
	repeat with chosen item running through things:
		if the category of the chosen item is "":
			now the category of the chosen item is "[the chosen item]".

Instead of giving when the offer of the noun is not desired by the second noun:
	say "[The second noun] is not interested in [the noun]."
		
[Checking that whatever is being given is the type of thing desired by the receiver.]
To decide whether the offer of (offer - a thing) is not desired by (receiver - a person):
	let unacceptable be true;
	repeat with desired item running through things desired by the second noun:
		if the category of the offer is the category of the desired item:
			now unacceptable is false;
			break;
	decide on unacceptable.
	
Part 6 - Giving Multiple Things (Donating)

Understand "give [things] to [someone]" as donating it to.  Donating it to is an action applying to two things.

[A map we will use to say the number and category of things given.]
Table of Donations
Category	Name	Count
"Nothing"	"Nothing"	0
with 20 blank rows.

To update the donated counts with (donation - a thing):
	let found be false;
	repeat through the Table of Donations:
		if the Category entry is the category of the donation:
			now the Count entry is the Count entry plus 1;
			now found is true;
			break;
	if found is false:
		choose a blank row in the Table of Donations;
		now the Category entry is the category of the donation;
		now the Name entry is "[the donation]";
		now the Count entry is 1.

[The player can only give things they are carrying, but we won't stop the action when multiple things are given, we will just filter them out of the list of things.]
Definition: a thing is matched if it is listed in the multiple object list.

finished_donating is a truth state that varies.

Before reading a command:
	now finished_donating is false.

Check donating:
	if finished_donating is true:
		stop the action.

Carry out donating:
	now finished_donating is true;
	let L be the list of matched things;
	if the number of entries in L is 0:
		try giving the noun to the second noun instead;
	if the number of entries in L is 1:
		try giving entry 1 of L to the second noun instead;
	if the number of entries in L is greater than 20:
		say "You lose count and give up before you can hand anything over to [the second noun].  (Perhaps try giving fewer things at a time, like less than 20)." instead;
	let L_accepted be a list of texts;
	now L_accepted is {};
	let L_rejected be a list of texts;
	now L_rejected is {};
	let uncarried be false;
	blank out the whole of Table of Donations;
	repeat with donation running through L:
		if the donation is not carried by the player:
			now uncarried is true;		
		otherwise if the offer of the donation is not desired by the second noun:
			add the category of the donation to L_rejected, if absent;
		otherwise:
			move the donation to the second noun;
			update the donated counts with the donation;
	if uncarried is true:
		say "(Some things you are trying to give away are nearby, but you are not carrying them; they will not be given)[command clarification break]";
	if the number of entries in L_rejected is greater than 0:
		say "[The second noun] is not interested in [L_rejected].";
	if the number of filled rows in the Table of Donations is greater than 0:
		repeat through the Table of Donations:
			if the Count entry is 1:
				add "[Name entry]" to L_accepted;
			otherwise:
				add "[Count entry] [Category entry]" to L_accepted;
		say "[The second noun] accepts your offer of [L_accepted].";
	otherwise if the number of entries in L_rejected is 0:
		say "You had nothing to give.".
	
	
[Stop Inform from reporting every donated thing on a line so our custom reporting does the job.]
The silently announce items from multiple object lists rule is listed instead of the announce items from multiple object lists rule in the action-processing rules.

This is the silently announce items from multiple object lists rule:
	unless donating something to someone:
		if the current item from the multiple object list is not nothing, say "[current item from the multiple object list]: [run paragraph on]".
	
	
Part 7 - Hit points, weapons, armor and combat

[Enemies are attackable, others are not.]
An enemy is a kind of person.  An enemy can be hostile or nonhostile.  An enemy is usually nonhostile.
Every enemy has a number called saving throw difficulty.  The saving throw difficulty of an enemy is usually 17.
Instead of attacking a thing who is not an enemy, say "No good can come from expressing your frustration through violence against [the noun]."

[A weapon's power is in the amount of damage it does.]
A weapon is a kind of thing.
Every weapon has a number called minimum damage.  The minimum damage of a weapon is usually 1.
Every weapon has a number called maximum damage.  The maximum damage of a weapon is usually 3.

After printing the name of a weapon while taking inventory:
	say " ([minimum damage]-[maximum damage] damage)".

[Armor will reduce damage incurred by a protection factor.]
Armor is a kind of thing that is wearable.
Every armor has a number called protection.  The protection of an armor is usually 0.

Check wearing an armor:
	if the player is wearing armor, say "You can only wear one set of armor at a time." instead.

After printing the name of armor while taking inventory:
	say " ([if worn]protection [protection][otherwise]unworn, offering no protection[end if])";
      

Every person has a number called maximum hit points.  The maximum hit points of a person are usually 1.
Every person has a number called current hit points.  The current hit points of a person are usually 1.
The maximum hit points of the player are 20.

[Set everyone's current hp to their max hp.]
When play begins:
	repeat with individual running through people:
		now the current hit points of the individual are the maximum hit points of the individual.

Definition: a person is defeated if his current hit points are less than 1.

[1-20 is determined when attacking with a weapon, if it meets or exceeds attack rank, a hit is scored.]
Every person has a number called attack rank.  The attack rank of a person is usually 15.
The attack rank of the player is 4.

[Set the damage done by the player's Rhymes.  Rhymes automatically hit but do less damage than the more powerful weapons.]
The player has a number called minimum poetry power.  The minimum poetry power of the player is 2.
The player has a number called maximum poetry power.  The maximum poetry power of the player is 5.

[poetry buff -- some items add to the damage done by Poetry.  When worn they will increase the poetry bonus, when removed they will decrease it.] 
The player has a number called poetry bonus.  The poetry bonus of the player is 0.

poetry buff is a kind of thing that is wearable.  Every poetry buff has a number called bonus.  The bonus of a poetry buff is usually 1.

After removing or taking off a poetry buff:
	now the poetry bonus of the player is the poetry bonus of the player minus the bonus of the noun;
	continue the action.

After wearing a poetry buff:
	now the poetry bonus of the player is the poetry bonus of the player plus the bonus of the noun;
	continue the action.
	
After printing the name of a poetry buff while taking inventory:
	say " ([if worn]Rhyme damage bonus +[bonus][otherwise]unworn - no bonus[end if])".

[Might get rid of this, might be useful for now.]
Diagnosing is an action applying to one visible thing. Understand "diagnose [something]" as diagnosing.

Check diagnosing:
	if the noun is not a person, say "Only people can have diagnoses." instead.
Carry out diagnosing: 
	say "[if the noun is the player]Your poetry bonus is [the poetry bonus of the player].  You have[otherwise][The noun] has[end if] [current hit points of the noun] out of a possible [maximum hit points of the noun] hit points remaining.".


Table of awesome poetry power
Text
"You lift an arm high and close your eyes, summoning from the fiendish depths of mystery the awesome power of your training.  [The assailant] squints curiously wondering what you are doing when the ground beneath their feet rumbles and quakes.  Your eyes are glowing from some unnatural force when you open them, and the voice that comes from your lips sounds inhuman -- fey -- demonic -- as you recite your monstrous Rhyme:"
"[The assailant] eyes you suspiciously as you rumble up phlegm from your diaphragm, clearing your vocal passage as you prepare to deliver your Rhyme.  A dark shadow looms overhead as thick clouds gather high above, summoned by the mystical powers of your mysterious Poetry.  When your words come, thunder cracks, the sky opens up, and a fount of terrible beauty expels from your lips like magma from the earth -- like wildfire -- like death!  You cry out:"
"You spread your arms wide showing the command of a great orator, and for a moment it seems that everything is still.  Not a bird chirps, no wind whispers; it's as if all of creation is holding its breath in anticipation of the immense magical destruction to come.  [The assailant] glances around suspiciously in this frozen moment, and then you speak:  an echoing blast of thunder accompanies your sinister Poetry, yet each sorcerous syllable rings clear in terrible, magnificent horror:"
"Dizziness threatens as you recall your training and start to summon the awesome power of your Rhyme.  Overhead, foreboding clouds suddenly gather and emit blinding flashes of lightning -- a great and instantaneous storm of electricity caused by the mysterious forces at your command.  [The assailant] is momentarily startled by the surprising change in the weather, and there is fear in their gaze as they train their eyes on you, uncertain of what is about to be called upon them.  When you release your awesome Poetry, your voice seems to come from everywhere at once:"
"A crack of thunder startles [the assailant] as you lift your arms high and summon the mysterious, mystical power that infuses your dangerous Rhyme.  The ground trembles beneath your feet, magical energy crackling around you as you rumble a ragged noise from your core that quakes along your esophagus, clearing your throat before you begin.  When you release the first sound, your voice comes as a shrill beast of destruction -- a fearsome serpent of murder -- a harbinger of death!  Your terrible voice announces:"
"The very air around you begins to crackle with fantastical energy as you recall your training and consider the dangerous words you will weave into your mysterious Rhyme.  [The assailant] glances around with sudden suspicion, as if sensing some terrible unknown presence about to pounce.  You feel your body slipping from your conscious ability to control your actions, a familiar sensation that frightens you every time you prepare your vocal cords to release the explosive, monstrous power of your deadly Poetry.  Your sudden intonation detonates in the air:"
"A sudden blast of freezing wind sweeps past you as you settle your mind and let the awesome, mysterious power of your training begin to possess you.  [The assailant] looks up in surprise as lightning flashes overhead and cracks of thunder echo from a sudden gathering of dark clouds on high, summoned by the fearsome magic of your horrifying verse.  When you release your Rhyme, your voice stabs, pierces, rends, cuts; the very fabric of existence threatens to shatter when you say:"
"Imagine an immense chasm splitting open beneath your feet, cracking and rumbling deafeningly as it breaks apart and extends and deepens, until the whole of the world is split into two crumbling halves in cruel frozen space.  This is the stupefying vision bursting before your eyes as you summon the mysterious, destructive power of your mystical Poetry.  [The assailant] seems petrified for a moment as the same horrifying scene possesses them, and the fearsome sound that breaks them out of their dumbfoundedness is the equally crushing nightmare of your monstrous, apocryphal verse:"
"You raise your dominant hand high above your head and lift your chin regally, closing your eyes as you recall your training.  A deafening silence closes in, swallowing up every tiny sound until your heartbeat is a tremendous clamor, your blood coursing through your veins a thunderous river through an echoing canyon.  [The assailant] widens their eyes in horror, momentarily overcome by the same unsettling experience.  Before they can make sense of this mystical phenomenon brought on by the mysterious power of your Rhyme, you release the monstrous verse, sounding out with the force of a howling gale:"



Table of mystical rhymes
Text
"Mary had a little lamb..."
"There once was a man from Nantucket..."
"Eeny meeny miny moe..."
"Hey, diddle diddle..."
"One, two, buckle my shoe..."
"Hickory dickory dock..."
"Humpty Dumpty sat on a wall..."
"I'm a little teapot..."
"It's raining, it's pouring..."
"The itsy bitsy spider..."
"Jack and Jill went up the hill..."
"Jack be nimble, Jack be quick..."
"Little Bo Peep lost her sheep..."
"Little Miss Muffet sat on a tuffet..."
"Row row row your boat..."
"Star light, star bright..."
"Twinkle twinkle little star..."
"Little Jack Horner..."
"Mary Mary, quite contrary..."
"Old Mother Hubbard..."
"Pease porridge hot..."
"Roses are red..."
"Three blind mice..."
"This old man, he played one..."
"This little piggy went to the market..."

[Set some variables to use while resolving combat actions chosen from the Questions menu.]
The assailant is an enemy that varies.
The foeweapon is a weapon that varies.
The playerweapon is a weapon that varies.
The emptyweapon is a weapon.  The maximum damage of the emptyweapon is 0.
The playerarmor is a number that varies.
The foearmor is a number that varies.
The round is a number that varies.

[Use the menu extension to allow the player to attack with a weapon, recite a Rhyme, or flee.]
Instead of attacking a person who is an enemy:
	now the round is 0;
	now the assailant is the noun;
	now the foeweapon is the emptyweapon;
	now the playerweapon is the emptyweapon;
	now playerarmor is 0;
	now foearmor is 0;
	repeat with possession running through the weapons carried by the player:
		if the maximum damage of the playerweapon is less than the maximum damage of the possession:
			now the playerweapon is the possession;
	repeat with possession running through the weapons carried by the assailant:
		if the maximum damage of the foeweapon is less than the maximum damage of the possession:
			now foeweapon is the possession;
	repeat with possession running through the armor worn by the player:
		now the playerarmor is the protection of the possession;
	repeat with possession running through the armor worn by the assailant:
		now the foearmor is the protection of the possession;
	say "[line break]You recall your training in Poetry and War, steel your wits, and get ready to battle [the assailant]!";
	now the current question is "Will you ATTACK with your [playerweapon], RECITE a mystical Rhyme, or FLEE?";
	now the current prompt is "Enter 1 to attack, 2 to recite, or 3 to flee: > ";
	ask a closed question, in number mode.

A number question rule (this is the attacking someone rule):
	if the current question is "Will you ATTACK with your [playerweapon], RECITE a mystical Rhyme, or FLEE?":
		increment the round;
		clear the screen;
		repeat with roundCount running from 1 to round:
			say ". ";
		say "combat round [round]:[line break][line break]";
		if the number understood is 3:
			say "You turn tail and flee the battle!";
			exit;
		otherwise if the number understood is 2:
			recite a rhyme;
			if the assailant is defeated:
				say "You have defeated [the assailant]!";
				now the assailant is nonhostile;
				now the assailant is nowhere;
				exit;
			otherwise:
				have the player with protection playerarmor be assaulted by the assailant with the foeweapon;
			if the player is defeated:
				end the story finally saying "GAME OVER[line break][line break]You have been defeated by [the assailant].";
			otherwise:
				retry;
		otherwise if the number understood is 1:
			have the assailant with protection foearmor be assaulted by the player with the playerweapon;
			say "[line break]";
			if the assailant is defeated:
				say "You have defeated [the assailant]!";
				now the assailant is nonhostile;
				now the assailant is nowhere;
				exit;
			otherwise:
				have the player with protection playerarmor be assaulted by the assailant with the foeweapon;
			if the player is defeated:
				end the story finally saying "GAME OVER[line break][line break]You have been defeated by [the assailant].";
			otherwise:
				retry;
		otherwise:
			retry.

To have (target - a person) with protection (ac - a number) be assaulted by (attacker - a person) with (implement - a weapon):
	let the to-hit roll be a random number between 1 and 20;
	say "A roll of [to-hit roll] with attack rank [attack rank of the attacker]:  ";
	if the to-hit roll is less than the attack rank of the attacker:
		say "[The attacker] attempt[if the attacker is not the player]s[end if] to strike [if the target is the player]you[otherwise][the target][end if] with [the implement], but [if the attacker is the player]you miss[otherwise][the attacker] misses[end if]!";
	otherwise:
		let the damage be a random number between the minimum damage of the implement and maximum damage of the implement;
		if the ac is 0:
			decrease the current hit points of the target by the damage;
			say "[The attacker] [if the attacker is the player]attack [the target][otherwise]attacks you[end if] with [if the attacker is the player]your[otherwise]their[end if] [implement], inflicting [damage] points of damage!";
		otherwise if the damage minus the ac is less than 1:
			say "[The attacker] [if the attacker is the player]attack [the target][otherwise]attacks you[end if] with [if the attacker is the player]your[otherwise]their[end if] [implement], but [if the attacker is the player]their[otherwise]your[end if] armor absorbed the damage!";
		otherwise:
			decrease the current hit points of the target by the damage minus the ac;
			say "[The attacker] [if the attacker is the player]attack [the target][otherwise]attacks you[end if] with [if the attacker is the player]your[otherwise]their[end if] [implement].  [ac] points out of [damage] are absorbed by armor, leaving [damage minus ac] inflicted!";
	say "[The target] [if the target is not the player]has[otherwise]have[end if] [current hit points of the target] hit points left.[line break]".
	
To recite a rhyme:
	choose a random row in the table of awesome poetry power;
	say the text entry;
	say "[line break][line break][italic type]'";
	choose a random row in the table of mystical rhymes;
	say the text entry;
	let the save roll be a random number between 1 and 20;
	if the save roll is less than the saving throw difficulty of the assailant plus the poetry bonus of the player:
		let the damage be a random number between the minimum poetry power of the player and the maximum poetry power of the player;
		decrease the current hit points of the assailant by the damage plus the poetry bonus of the player;
		say "'[roman type][line break][line break][The assailant] reels from the awesome power of your mystical verse, taking [damage][if the poetry bonus of the player is greater than 0] (plus [poetry bonus of the player])[end if] hit points of damage, leaving them with [current hit points of the assailant].[line break][line break]";
	otherwise:
		say "'[roman type][line break][line break][The assailant] reels from the awesome power of your mystical verse, but their willpower is strong and they resist any damage from your Rhyme![line break][The assailant] has [current hit points of the assailant] hit points left.[line break][line break]".

Part 8 - Fatigue

A person can be fatigued or unfatigued.  A person is usually unfatigued.

When play begins:
	now the player is fatigued.

Part 9 - Starting Inventory

The faded Warrior Poet's outfit is a thing.  The description is "Somewhat faded after your trek across the Infinite Desert, the colors of the College of Myth and Legend, still conspicuous, adorn your outfit, consisting of a pair of light cotton leggings, a tunic, and a robe with a hood."
The player carries the faded Warrior Poet's outfit.

The dagger is a weapon that is keepworthy.  The description is "A simple weapon, easy to carry, easy to use, and somewhat dangerous in the hands of an undergraduate Warrior Poet such as yourself."
The player carries the dagger. 

Warrior Poet's Undergraduate Amulet is a thing that is wearable and keepworthy.   The description is "Given to you for your final year at the College of Myth and Legend, your Undergraduate Amulet gives mystical power to your Rhymes.  A more powerful Graduate Amulet waits for you upon graduation -- if you can return to Mourdrascus with the Mantablasphere (and with or without Prefect Zylock himself, you guess, given what little you were told when the Academic Tribunal sent you after the delinquent Doctor)."
The player wears the Warrior Poet's Undergraduate Amulet.

Letter of official college business is a thing that is keepworthy.   The description is "You remember sitting before the Academic Tribunal with the issue of your graduation under consideration, along with the complication of Professor Zylock's unexpected criminal flight with the stolen Mantablasphere, prize of the Department of Poetry and War.
[line break][line break]The choice for you to go after Zylock was quite a shock, but the Administrators had little sympathy for your objections; from their point of view, the Department of Poetry and War was losing favor, so if its Prefect and best graduating student both were never heard from again, who would there be to stand in the way of its dissolution?
[line break][line break]Further reasoning carried that the operation was exactly the sort of thing you will be doing after graduation (albeit then for pay), and the experience might help you land a quality job.  (Grudgingly you sympathized with this perspective, but it still bothered you a bit being forced into the position.)  So they wrote up this useless letter informing anyone interested that you were operating in the capacity of a proper representative of the College of Myth and Legend, Mourdrascus, and they sent you on your way."  
The player carries the letter of official college business.

The coin pouch is a container that is keepworthy.  The description is "A sturdy leather pouch you use to carry your money."
Instead of inserting something that is not a gold piece into the coin pouch, say "Your coin pouch is for carrying gold pieces, not [the noun]."
Instead of inserting a gold piece into the coin pouch, say "You're already carrying your gold pieces in your coin pouch."
The player carries the coin pouch.

The player carries 2 gold pieces.

Part 10 - Beginning

Before printing the banner text:
	say "    YOU ARE A Warrior Poet, trained in your discipline through four long years of study in the Department of Poetry and War, at the prestigious College of Myth and Legend in the land of Mourdrascus.
[line break][line break]    Or at least, you [italic type]will[roman type] be a Warrior Poet -- officially, that is -- and able to pursue a lucrative and adventurous career as a professional -- only once you graduate.  To do that, the Prefect of your Department, Doctor Zylock, needs to approve your senior thesis (which you completed quite proudly and submitted confidently).
[line break][line break]    However, a vicious misfortune plagued you, as the Professor turned out to be a dastardly crook:  just before the end of your final academic year, Zylock abandoned his duties, stole the Department's most valuable artifact, and went on the run.
[line break][line break]    You sat before the Academic Tribunal after it was discovered Professor Zylock had stolen the Mantablasphere, and following much hushed debate among the Administrators, you were dumbfounded to hear their final decision on the matter, which was to send you, an inexperienced and untested undergraduate, out across the Infinite Desert to hunt down Zylock and retrieve the artifact.
[line break][line break]    Should such a task fall on your shoulders?  Certainly not.  Were there others more experienced and capable, perhaps even members of the staff, who should go after the delinquent Doctor?  Absolutely.  Was it solid reasoning, and a healthy regard for human life, that led to their decision?  Not in the least.
[line break][line break]    It was the longterm resiliency of the College that the Tribunal cared about, and that alone.  The Department of Poetry and War had been dwindling for some time as more and more new students took on sexier subjects like Psionics, Wizardry, and Business Administration.  There were only four members of your graduating class, including you (well the best among them).  So whether fair or not, the Administrators decided it wasn't worth committing any valuable resources to the problem other than one of the few students left from the College's least important degree program (which they likely will shutter in the next couple of years anyway).
[line break][line break]    So they sent you on your way, to cross the desert, find the deserting Doctor Zylock, and recover the pilfered Mantablasphere.  And if you succeed -- well maybe then you can graduate.[line break][line break]<< press any key >>";
	wait for any key;
	clear the screen.

After printing the banner text:
	say "[line break][line break]    THE TREK ACROSS the sands of the Infinite Desert stressed your ability to maintain meditative selflessness to its limits. Mile after mile of dunes went by under the slow plodding gait of your Ashen camel, countless nights passing while you traveled, each one the same as the one before. The brutal sun pierced your crude shelter during the days, penetrating your dreams while you suffered fitful sleep until the cooler nights allowed you to continue on.
[line break][line break]     If not for your training in mental discipline from the College of Myth and Legend back in your home land of Mourdrascus, you would have been a mumbling head case halfway into the journey, lost to the sands like many foolish travelers who venture alone into the Infinite Desert, unprepared for its unending torment of boiling heat and dismal emptiness.
[line break][line break]     But you lasted, and finally you have arrived at a flourishing city on the eastern border of the sand sea.  Will you find Doctor Zylock here, in Dol Bannath?  It's unlikely, for although his head start on you was only two days, he was after all the Academic Prefect of the Department of Poetry and War, and you are technically still a student.  He likely crossed the desert more quickly than you, with the help of a few advanced Rhymes you have yet to master.
[line break][line break]     Now, with the sun climbing into the sky behind your back and a cool breeze wafting through the city from the direction of Lake Aurora, dizzying culture shock again tests your cognitive durability as the sights, smells and sounds of civilization assault your sensitive faculties.  Your camel, having taken you across the great expanse of the desert sands, is now worth much more in trade than as transportation, so you trot your animal companion into the Camel Pit at the Market Square, and consider your options for selling the beast."


Volume 2 - City of Dol Bannath

Book 1 -  Camel Pit

Part 1 - Places

Camel Pit is a room.  The printed name of the Camel Pit is "In The Camel Pit".  The description of the Camel Pit is "[if the player is carrying the Ashen camel]Several merchants await customers in the pit.  To the west is a merchant in rich red robes, to the north is a merchant with an eye patch, and to the east a merchant in exotic green garb.[otherwise]Satisfied with your transaction, you look south from the Pit toward the Market Square, catching the pungent scents of exotic, spicy food and hearing cries from barkers announcing a range of curious wares.[end if]".  The player is in the Camel Pit.

Red Robed Merchant's Tent is west of Camel Pit. "Rich red silks and flowing embroidered cotton adorn the merchant under her billowing canopy.

[if unvisited]She greets you warmly and strolls around your animal, inspecting its teeth and coat. 'A fine Ashen camel, young traveler. I cannot offer you her full worth in coin; but, along with forty gold pieces, I can give you this silver dirk, a much superior weapon to the small knife on your belt.'[otherwise]The merchant greets you as you return to her tent.  'Still thinking about the silver dirk I see?'[end if]"

Blue Robed Merchant's Tent is north of Camel Pit. "Despite a patch over one eye, the flashy jewelry and expensive looking, royal blue robes worn by the camel merchant suggest both class and taste.

[if unvisited]He avoids small talk as he examines your mount, prodding and squeezing its hindquarters and lifting each of the animal’s hooves from the ground to inspect it. 'Your camel has traveled far but is no worse for wear,' he says finally. 'I see from the colors you wear that you hail from the College of Myth and Legend in far off Mourdrascus. To pay you in gold for this camel would leave me with scant funds for further business today; however, you may be interested in this Poet's Jewel of Rhyming with Orange I have to trade. I can offer it to you along with forty gold pieces for the animal.'

He shows you the Jewel, a dark blue gem which sits against the forehead and adds to the effect of a Poet’s Rhymes.[otherwise]The merchant sees you returning and raises the eyebrow above his working eye.  'Welcome back traveler.  Are you interested in my offer?'[end if]"

Green Robed Merchant's Tent is east of Camel Pit. "The camel merchant’s robe, the color of spearmint leaves, is sashed by a belt of golden silk.

[if unvisited]She smiles and offers you a cup of fresh water before taking time to examine your animal. 'I had my eye on you when you led this sturdy mount into the pit,' she says while holding her hand before the beast’s hissing nostrils. 'You have made a long journey through the desert, haven’t you, traveler?  Well, I cannot pay you enough in gold for this specimen’s worth, but I can offer you a sturdy leather chest piece with matching vambraces and greaves to protect you on your travels in these lands, as well as forty gold pieces.'[otherwise]The merchant in her green robes nods as you return to her tent.  'You are interested in the leather armor after all?'[end if]"

Part 2 - Things

The Ashen camel is a thing.  The player carries the Ashen camel.

The silver dirk is a weapon.  The minimum damage is 2.  The maximum damage is 5.  The description is "A fine dirk, polished to a gleaming sheen and keenly sharpened by the master silver craftsmen of Dol Bannath. A weapon you should be able to employ with skill, assuming you learned anything in your senior seminar titled 'Employment of Blades, 2 1/4 Feet Long and Under.'"

The Poet's Jewel of Rhyming Orange is a poetry buff that is wearable with printed name "Poet's Jewel of Rhyming with Orange".  The bonus is 2.  The description is "The small jewel draws the gaze with a hypnotic color in the deep blue hue of the clear desert sky just after twilight.  Imbued with the magic of many same sounding words, it sticks to the middle of your forehead just above your eyebrows, and makes your Rhymes more potent and commanding."

Leather armor is armor.  The protection is 1.  The description is "Made with fine attention to detail from the boiled and cured hide of the Thick Skinned Antler Beast, the armor is comfortable and stylish, and still provides protection when those you encounter are hostile and won't succumb to your sublime verse."

Part 3 - Actions

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
	now the current question is "You can trade your camel for forty gold pieces and the Poet’s Jewel, or you can try another merchant.  Would you like to trade?";
	ask a closed question, in yes/no mode.

After going to the Green Robed Merchant's Tent:
	say "[bold type]Green Robed Merchant's Tent[roman type][line break][the description of the Green Robed Merchant's Tent][line break][line break]";
	now the Green Robed Merchant's Tent is visited;
	now the current question is "You can trade your camel for forty pieces of gold and the leather armor, or you can try another merchant.  Would you like to trade?";
	ask a closed question, in yes/no mode.

A yes/no question rule (this is the confirm camel trade rule):
	if the location is the Red Merchant's Tent:
		if the decision understood is Yes:
			now the player carries the silver dirk;
			accept the trade for the camel;
		otherwise:
			move the player to the Camel Pit;
	otherwise if the location is the Blue Robed Merchant's Tent:
		if the decision understood is Yes:
			now the player wears the Poet's Jewel of Rhyming Orange;
			accept the trade for the camel;
		otherwise:
			move the player to the Camel Pit;
	otherwise if the location is the Green Robed Merchant's Tent:
		if the decision understood is Yes:
			now the player wears the leather armor;
			accept the trade for the camel;
		otherwise:
			move the player to the Camel Pit.

To accept the trade for the camel:
	say "[line break]The merchant hands you your item and gold pieces and says, 'Excellent. You have made a fine trade today, traveler.' They lead your camel away.";
	make the player richer by 40;
	now the Ashen camel is nowhere;
	move the player to the Camel Pit.

Part 4 - Testing

Test camelpit with "x me / i / x outfit / x dagger / x amulet / x letter / remove amulet / drop letter / x camel / w / n / n / N / e / no".
Test bluemerchant with "n / Yes / i / x pouch / put gold piece into coin pouch / put 2 gold pieces into coin pouch / x jewel / put dagger in coin pouch / n / e / w / s".
Test redmerchant with "w / Yes / i / x pouch / put gold piece into coin pouch / put 2 gold pieces into coin pouch / x dirk / put dagger in coin pouch w / n / e / s".
Test greenmerchant with "e / Yes / i / x pouch / put gold piece into coin pouch / put 2 gold pieces into coin pouch / x armor / put dagger in coin pouch / e / w / n / s".

Book 2 - Market Square Area

The Dol Bannath Market Area is a region.

Part 1 - Market Square

Chapter 1 - Places

Market Square is a room.  It is south of the Camel Pit. It is in the Dol Bannath Market Area. The description is "Your time in the desert dulled your senses with merciless repetition, moon and star light casting a bland monotone glow on the landscape during your travel by night, the plain yellow sand reflecting the glaring sun while you rested during the heat of the day.  Entering the Market Square, you are met with a kaleidoscope of sensations painful to your raw faculties.  Spicy aromas remind you that you haven't eaten anything but dried fruit and salted meat for thirty days, but you are keen that if you ate any of these rich stews or sticky, spiced rices right now, you would make yourself sick.
[line break][line break]Hungry though you are, you know that you need rest before you can begin to enjoy any pleasures of Dol Bannath, to say nothing of continuing your search for freedom from academia.
[line break][line break]Looking beyond the stalls and merchants, you see a narrow alleyway to the east; south is the city's main thoroughfare; and to the west the market ends at a gate before a tall steepled chapel."

Chapter 2 - Things

Stalls is scenery in Market Square.  ""

Chapter 3 - Actions

Instead of going north from Market Square, say "You have no reason to go back to the Camel Pit."

Part 2 - Narrow Market Alleyway

Chapter 1 - Places

Narrow Market Alleyway is a room.  It is in the Dol Bannath Market Area.  It is east of Market Square.  The description is "[if the player is fatigued]Perhaps down this alleyway you can find an inexpensive boarding house with an available bed, you wonder?  [end if][if unvisited]So you step away from the overwhelming cacophony of the bustling market square and enter the alley, which is [otherwise]The alley is [end if]little more than a path of dirty cobblestones between brick and wood buildings rising three stories on each side.  A ratty, domesticated feline creature no longer than your forearm sniffs around a pile of rubble next to a sewage barrel here[if the Cloaked Ruffian is in the Narrow Market Alleyway], and a solitary figure, in a dark cloak with its hood drawn over their face, sits on a back stoop down the alley a ways[end if].  To the west is the Market Square, and to the east where the alley meets a cross street, you see a sign announcing a place of commerce or service, but from here you can't tell what their business is."

Chapter 2 - Things

The cat is scenery in the Narrow Market Alleyway.   The description of the cat is "Cat:  there are plenty of these furry, delightful four legged creatures of mischief where you come from, but the ratty feline you see here is not one of them.  For one thing, it has tiny antlers, and a creepy little eye on the back of its head."
Instead of taking the cat, say "That little thing is not really a cat."

The ratty little feline is scenery in the Narrow Market Alleyway.  The description of the ratty little feline is "This disturbing little creature has tiny antlers, round ears like on a small teddy bear, and a creepy little eye on the back of its head.  It is sniffing around a pile of rubble next to a sewage barrel."
Instead of taking the ratty little feline, say "The weird little creature is not coming with you."

The pile of rubble is scenery in the Narrow Market Alleyway.   The description of the pile of rubble is "A disgusting pile of rubble."
Instead of taking the pile of rubble, say "Gross!"

Sewage barrel is scenery in the Narrow Market Alleyway.   The description of the sewage barrel is "A few of these sanitation barrels dot the alley.  An interesting pulley mechanism seems to enable second and third floors of these buildings to lower waste containers down and deposit their filthy contents into the barrels.  From here no stench reaches your nostrils, suggesting the barrels have some kind of stench containing quality, but you'd rather not get any closer to investigate."

The cloaked ruffian is an enemy in the Narrow Market Alleyway.  Understand "figure" or "solitary figure" or "cloaked figure" as the cloaked ruffian.  The description is "The cloaked figure is sitting on some wooden stairs, part of a low stoop at the back door of one of the buildings.  They appear to be fiddling with some small thing in their hands."  The cloaked ruffian is scenery.  The maximum hit points of the cloaked ruffian are 8.  The attack rank of the ruffian is 10.
A chipped knife is a weapon. The cloaked ruffian carries a chipped knife.

Chapter 3 - Actions

Instead of going somewhere from the Narrow Market Alleyway when the Cloaked Ruffian is in the Narrow Market Alleyway:
	say "You start on your way when suddenly the cloaked figure is up on his feet, and you see the unmistakable flash of a steel blade in his hand as he approaches you menacingly.  From within the shadow cast over his face by the hood of his cloak, you see a greasy smile.  'What's the hurry, stranger?' comes the human's gravelly voice.  'That's a fat purse you have there, and 
[if the player carries the silver dirk]a shiny looking weapon on your belt.  Do you know how to use it?'
[otherwise if the player wears the Poet's Jewel of Rhyming Orange]a sparkly jewel on your forehead.  Don't worry, you won't feel anything when I pry it from your dead skin!'
[otherwise if the player wears the leather armor]a nice new set of armor you're wearing.  I'll try not to damage it too much before I take if off of your corpse!'[end if]";
	now the cloaked ruffian is hostile;
	try attacking the cloaked ruffian.	


Chapter 4 - Testing

Test alleyway with "e / x cat / take cat / x feline / take feline / x rubble / take rubble / x barrel / take barrel / l / n / s / x figure / w".

Part 3 - Gate, Cemetery, Chapel

Chapter 1 - Places

The Burial Ground Wall is a room west of Market Square.  The printed name is "Outside the Cemetery Wall".  The description is "Between the market and the cemetery here there is a low stone wall that appears to be very old.  The barrier is extended above the stones with thick, rusted iron bars six or eight inches apart, each topped with a fat triangular spike.  There is a solid iron gate on rusted hinges, flanked by two large planters from which grow bushy plants with dark crimson branches and prickly green leaves sprouting barbed little purple blossoms."

The Solid Iron Gate is a closed and locked door.  It is scenery.  It is west of the Burial Ground Wall.  "A heavy iron gate is set in the center of the wall separating the market from a cemetery outside the chapel."

The Cemetery is west of the Solid Iron Gate.  "Although much of the architecture you see around Dol Bannath is odd and foreign to you, this yard fronting a chapel to the west is unmistakably a burial ground.  Tombstones of varying sizes are set into the ground marking burial plots organized in rows, and the presence of flowers at some of the graves suggest many buried here are regularly visited by their surviving persons."

The Chapel is west of the Cemetery and northwest of Ten Flowers Road. "This humble stone building reveals its purpose with a high steeple supporting a large iron symbol that can only be religious in nature according to your educated opinion.  The fore entrance is two large arched oaken doors fronted by stone steps on the east face of the chapel.  The building looks to have stood here for perhaps centuries, showing an age far outpacing any other structure you have seen in this part of Dol Bannath.

East of the chapel is a reasonably well groomed yard dotted with grave stones, and Ten Flowers Road leads southeast away from the church.

The doors open on ancient hinges that have survived centuries of maintenance.  Once inside you are taken by the reverent quiet that possesses the place.

Wooden pews line the floor facing a raised dais that supports a pulpit, behind which is a large statue presumably of some worshipful deity you've not heard of."


Chapter 2 - Things

[Outside the Cemetery Wall]
The left planter is scenery in the Burial Ground Wall.  The description is "Someone must be taking care of the colorful bush, it looks pruned and groomed."  Understand "Left Bush" as the left planter

The right planter is a container in the Burial Ground Wall.  It is scenery.  The description is "You take a closer look at the planter on the right and see a tarnished brass key pushed into the soil at the trunk of the spiky plant."

The tarnished brass key unlocks the Solid Iron Gate.  "A tarnished brass key that looks as old as the ancient gate that it unlocks."  It is nowhere.

[The Chapel]
The pews are scenery in the Chapel.  The description is "The pews are as old as the building itself, worn at their edges and corners, their stain faded in the places where worshippers have sat countless times over the centuries."

The Cleric is a man in the Chapel.  "A man sits at a writing table set against the wall to the left the dais.  He is dressed in a robe and chapeau both decorated in a ceremonial fashion, with silver and gold embroidery stitched into heavy red velvet.  This Cleric seems engrossed in the dusty tome before him.  He scratches his beard and turns the page, takes up a feather quill and scratches a note onto a leaf of parchment beside the tome.  He lifts his old gray eyes to you for a moment, smiling briefly before returning to his reading."

The dais is scenery in the Chapel.  The description is "The dais is a raised platform supporting the pulpit, implicitly granting authority over spectators in the pews to whomever should take their place behind the speaking podium."
The pulpit is scenery on the dais.  Understand "podium" and "speaking podium" as the pulpit.  The description is "The pulpit seems like a perfect place from which to deliver an engrossing and impactful sermon."
The statue of Saint Herbeus is scenery in the Chapel.

The small writing table is scenery in the Chapel.  The dusty tome is scenery on the table.  The inkwell is scenery on the table.  The feather quill is scenery on the table.

[The Cemetery]
Tombstones are scenery in the Cemetary.



Chapter 3 - Actions

After examining the right planter:
	now the tarnished brass key is in the right planter.
	
Instead of taking the tarnished brass key when the tarnished brass key is in the right planter:
	say "As carefully as you can, you reach your hand into the bush to snatch the key.  The leaves and flowers are quite sharp and keep stinging your hand, but eventually you are able to extract the key with only a little bit of blood coming from the resulting scratches.  [italic type](You suffer 1 hit point of damage.)[roman type]";
	now the current hit points of the player are the current hit points of the player minus 1;
	if the player is defeated:
		end the story finally saying "GAME OVER[line break][line break]You succumb to your wounds and die.";
	otherwise:
		continue the action.

Table of Tombstone Epitaphs
Text
"Here lies..."
"In memory of..."
"Someone..."

[something like:]
Instead of examining the Tombstones:
	if the Table of Tombstone Epitaphs is empty:
		say "Now this is interesting..."
	otherwise:
		choose a random row from the Table of Tombstone Epitaths;
		say "There are numerous tombstones here.  Most look like whoever lies before them was buried a long time ago.  You step up to a random grave and read the epitath:  [the Text entry]";
		blank out the current row;
	finish the action successfully.
	

Chapter 4 - Testing

Test chapel with "w / w / take key / x right planter / x left planter / take key / i / unlock gate with key / open gate / w / x Tombstones / x Tombstones / x Tombstones / w".

Part 4 - Ten Flowers Road

Chapter 1 - Places

Ten Flowers Road is a room south of Market Square.  "This handsome avenue edging the south border of the market square is shaded by tall trees with bare trunks and round bushy crowns that curve out over the street, creating a patched tunnel of foliage overhead.  The buildings along the road exhibit a decorative architecture that reminds you of the illustrated storybooks your mother read to you when you were a young child back in Mourdrascus.

Across the street from the entrance to the market is a curious creature about four feet tall with a skin tone somewhere between turquoise and lime green, with large pointed ears and a honking snout sprouting boldly from its face.  Face paint and stand-out garb give you the immediate impression that he is the local variant of a circus clown, a conclusion doubly confirmed by the fact that he stands on a brightly painted crate, juggling five fist sized red and blue bags, possibly filled with beans or rice or small pebbles.  A few spectators from the local populace are gathered around the clown, silently watching his concentration as he juggles.  

Looking east you see the road intersects with a wider thoroughfare, and in the other direction the road curves northwest and meets a structure that looks like a church."

Chapter 2 - Things

The brightly painted crate is a supporter in Ten Flowers Road.  It is scenery.  The description is "The crate is brightly painted and looks pretty sturdy."

The goblin clown is a man on the brightly painted crate.  He is scenery.  The description is "The odd goblin-like clown is intently concentrating on his juggling.  The five bags of beans rotate through his hands skillfully as he tosses them high up in the air with one hand and catches them with the other."  Understand "juggler" as the goblin clown.

The spectators is scenery in Ten Flowers Road.  The description is "A few folks dressed in everyday attire stand around the juggler watching him exhibit his performance.  None of them pay you much attention."

The goblin clown carries the juggling bags.  Understand "fist sized bags" and "bean bags" and "beanbags" and "red bags" and "blue bags" as the juggling bags.  The description of the juggling bags is "The clown juggles five small cloth bags, two red and three blue.  They make a soft sound each time he grabs one on its way to the ground, their contents being a fistful of something, beans or rice or perhaps pebbles."

Chapter 3 - Actions

Instead of giving to the goblin clown:
	say "You step through the small crowd of spectators, nodding toward the performer and holding out [the noun] to get his attention.  ";
	interrupt the clown.
	
Interrupting_clown is a truth state that varies.

Before reading a command:
	now interrupting_clown is false.
	
Instead of donating to the goblin clown when interrupting_clown is false:
	say "You step through the small crowd of spectators, nodding toward the performer and holding out [the noun] to get his attention.  ";
	interrupt the clown.
		
Instead of donating to the goblin clown when interrupting_clown is true:
	do nothing.
	
Instead of asking the goblin clown about something:
	say "You step through the small crowd of spectators and start to speak to the performer.  ";
	interrupt the clown.
	
Instead of telling when the noun is the goblin clown:
	say "You step through the small crowd of spectators and start to speak to the performer.  ";
	interrupt the clown.
	
Instead of taking the juggling bags:
	say "You step through the small crowd of spectators and reach for one of the juggler's bags, trying to grab it out of the air before he catches it.  ";
	interrupt the clown.
	
To interrupt the clown:
	say "Immediately the clown loses his concentration and all his juggling bags fall onto the street around his perch.  There is a hushed gasp that comes from the spectators watching, and the clown stands for a moment on his perch, glaring at you silently, not really looking angry, just sad.  He steps off the crate, muttering quietly to himself in a language you can't understand.  He gathers up his five little bags, climbs back up on the crate, and starts juggling again.  The spectators give you a look that is a bit nasty, and then turn their attention back to the clown.";
	now interrupting_clown is true.
	
Chapter 4 - Testing

Test tenflowers with "s / x crate / x juggler / l spectators / l bags / ask spectators about clown / ask clown about bags / take bags / tell clown about Zylock / give gold piece to clown / give 2 gold pieces to clown / give dagger to clown".

Book 3 - Outer Dol Bannath Hotels Association

Chapter 1 - Places

Outer Dol Bannath Hotels Association is a region.

Chapter 2 - Things

Chapter 3 - Actions



	

