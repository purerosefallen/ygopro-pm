# ygopro-pm

### How to Install
1. Exit YGOPro.
2. Put all `cards-X.cdb`, `constant_X.lua` and `utility_X.lua` files in the `expansions` folder.
3. Put the `script` folder in a `.zip` file and put it in the `expansions` folder, or put the `script` folder in the main folder instead.<br>
Optional: If you have card pics, put them in a `pics` folder and put it in the `.zip` file, or put the `pics` folder in the main folder instead.
4. Put `lflist.conf` in the main folder. (Make a backup of the original file(s), if you do not want to overwrite them.)
5. Optional: Put the `deck` folder in the main folder.
6. Optional: Put all `fieldX.png` and `field-transparentX.png` files in the `textures` folder. (Make a backup of the original file(s), if you do not want to overwrite them.)

### How to Play
In Yugioh terms:
1. Start YGOPro.
2. Optional: Disable `Auto chain order` in the Settings tab in Deck Editor.<br>
If enabled, always choose the chain order from left to right.
3. Make a main deck of exactly 60 cards:<br>
	-All 60 cards must be Pokémon cards.<br>
	-There must be at least 1 ["Basic Pokémon"](https://bulbapedia.bulbagarden.net/wiki/Basic_Pok%C3%A9mon_(TCG)) monster in your deck.<br>
	-Add 1 *Pokemon Rules* to the extra deck.<br>
	-If there is at least 1 non-Pokémon card in your deck, you will lose the duel.
4. Begin the duel by drawing 7 cards, then place 1 "Basic Pokémon" monster from your hand in an extra monster zone face-down as your [Active Pokémon](https://bulbapedia.bulbagarden.net/wiki/Appendix:Glossary_(TCG)#Active_Pok.C3.A9mon).<br>
If you do not have a "Basic Pokémon" monster in your hand, show your hand, shuffle it into the deck, then draw 7 cards. Repeat this until you have a "Basic Pokémon" monster in your hand.<br>
5. Optional: Place any number of "Basic Pokémon" monsters from your hand in your main monster zones face-down as Pokémon on the [Bench](https://bulbapedia.bulbagarden.net/wiki/Appendix:Glossary_(TCG)#Bench).<br>
6. Set aside the top 6 cards of your deck as [Prize cards](https://bulbapedia.bulbagarden.net/wiki/Appendix:Glossary_(TCG)#Prize_Card), then your life points become 6.<br>
7. Optional: Your opponent draws a number of cards, up to the number of times you shuffled your hand into the deck because you did not have a "Basic Pokémon" monster in your hand.<br>
8. Flip all face-down cards on your field face-up.
9. During your draw phase, draw 1 card, regardless if it is the first turn of the duel. If you cannot, you lose the duel. (There is no limit to the number of cards in your hand.)
10. Nothing happens during your standby phase.
11. Optional: During your main phase 1, do any of the following:<br>
	-Special summon any number of "Basic Pokémon" monsters from your hand in your main monster zones.<br>
	-Special summon any number of ["Evolution"](https://bulbapedia.bulbagarden.net/wiki/Appendix:Glossary_(TCG)#Evolution_card) monsters from your hand, by placing them on top of a card in the main monster zone or extra monster zone that has its name listed in its text, except if that card was summoned this turn, or if it is the first turn of the duel. (This is treated as an evolution summon.)<br>
	-Attach an ["Energy"](https://bulbapedia.bulbagarden.net/wiki/Energy_card_(TCG)) card from your hand to 1 of your monsters as a material. (You can only do this once per turn.)<br>
	-Activate any number of ["Trainer"](https://bulbapedia.bulbagarden.net/wiki/Trainer_card_(TCG)) cards from your hand. (You can only activate 1 "Supporter" and 1 "Stadium" card per turn.)<br>
	-Retreat your Active Pokémon, by switching its place with 1 monster on the Bench, and detaching "Energy" cards equal to its Level [(Retreat Cost)](https://bulbapedia.bulbagarden.net/wiki/Retreat_cost). (You can only do this once per turn.)<br>
	-Activate or apply any monster effects.<br>
	-If it is not the first turn of the duel and you have the "Energy" cards attached to your Active Pokémon that are listed in its text, you can activate its effect to [attack](https://bulbapedia.bulbagarden.net/wiki/Attack_(TCG)) the opponent's Active Pokémon. Place [Damage Counters](https://bulbapedia.bulbagarden.net/wiki/Appendix:Glossary_(TCG)#Damage) on that opponent's monster, equal to the number listed in your monster's text, divide by 10. (Monsters with a Damage Counter lose 10 ATK for each Damage Counter on it, also are destroyed when their ATK become 0 as a result.) If that opponent's monster is destroyed, add 1 Prize card to your hand. (At any time, if an opponent's monster(s) is destroyed, add 1 Prize card to your hand for each destroyed monster.) Your main phase 1 ends.
12. You cannot conduct your battle phase.
13. During your end phase, activate or apply any [Special Condition](https://bulbapedia.bulbagarden.net/wiki/Special_Conditions_(TCG)) effects, then your turn ends.

### How to Win
1. Take all your Prize cards. (Your opponent's life points are reduced to 0.)
2. At any time, if your opponent controls no monsters. (If their only monster is destroyed.)
3. If your opponent cannot draw a card for their normal draw during their draw phase.
4. [Some cards](https://www.pokemon.com/us/pokemon-tcg/pokemon-cards/?cardName=&cardText=win+this+game&evolvesFrom=&simpleSubmit=&format=unlimited&particularArtist=&sort=number&sort=number) will allow you to win by other means.

<details>
<summary>Card Types</summary>

- `Pokémon = Monster (Level=Retreat Cost, ATK=current HP, DEF=original HP)`
	- `Pokémon with "Poké-Power", "Poké-Body", "Ability", etc. in their text = Monster + Effect`
- `Trainer = Spell`
	- `Stadium = Spell + Field`
- `Energy = Trap`
</details>
<details>
<summary>Energy Types</summary>

- `Grass = EARTH Attribute`
- `Fire = WATER Attribute`
- `Water = FIRE Attribute`
- `Lightning = WIND Attribute`
- `Psychic = LIGHT Attribute`
- `Fighting = DARK Attribute`
- `Darkness = DIVINE Attribute`
- `Metal = 0x080` (unlisted in YGOPro's tabs)
- `Colorless = 0x100` (unlisted in YGOPro's tabs)
- `Fairy = 0x200` (unlisted in YGOPro's tabs)
- `Dragon = 0x400` (unlisted in YGOPro's tabs)
</details>
<details>
<summary>Locations</summary>

- `Active Pokémon (In Play) = Extra Monster Zone`
- `Bench (In Play) = Main Monster Zone`
	- [Increased Bench](https://www.pokemon.com/us/pokemon-tcg/pokemon-cards/xy-series/xy6/89/) `(In Play) = Spell & Trap Zones #1-4` (Not fully supported by YGOPro.)
- `Discard Pile = Graveyard`
- `Lost Zone = Face-up banished cards` (text color = black)
- `Prize Cards = Face-down banished cards` (text color = blue) (Your opponent's life points are equal to your total number of Prize cards.)
</details>
<details>
<summary>Card Search</summary>

You can search for the following specific card information in YGOPro:
- Attack Damage: Type `N damage`, or type ` N damage` for a more norrower search
- Card Type: Search by `Type`
- Energy Type (Pokémon Type): Search by `Attribute` (only until `Darkness`), or type `Pokemon Type: Energy`
- Expansions (what set the card appears in): **N/A**
- Format (what tournament format the card is legally playable in): **N/A**
- HP (Hit Points): Search by `ATK`
- Pokémon that have an Ability: Search by `Effect` or `Has Ability`
- Pokémon Evolution: Type `Stage 1`, `Stage 2`, or type `Stage: Stage 1`, `Stage: Stage 2`, and `Evolves from Pokémon name` for a more norrower search
- Rarity: **N/A**
- Resistance: Type `Resistance: Energy -N`, or type `Resistance: none` for Pokémon that have no Resistance
- Retreat Cost: Search by `Level/Rank`
- Total Attack Cost: **N/A** (You can type `[P] ` for Pokémon attacks that require only 1 Psychic Energy, etc.)
- Weakness: Type `Weakness: Energy x2`, `Weakness: Energy +N`, or type `Weakness: none` for Pokémon that have no Weakness

Note - Energy. The following abbreviations are used for each Energy Type:<br>
- [G] = Grass
- [R] = Fire (R is short for 'Red')
- [W] = Water
- [L] = Lightning
- [P] = Psychic
- [F] = Fighting
- [D] = Darkness
- [M] = Metal
- [C] = Colorless
- [Y] = Fairy (Y is the last letter in 'Fairy')
- [N] = Dragon (N is the last letter in 'Dragon')

Note - missing information. Text that appears on the card that is not essential to gameplay is not searchable in the database:<br>
- Card Illustrator (artist who illustrated the image on the card)
- Pokédex Number - No. 125
- Pokémon Category (Species) - Electric Pokémon
- Pokémon Length/Height - Ht:3'07''
- Pokémon Weight - WT 66.1 lbs
</details>
<details>
<summary>Glossary</summary>

- `Ability/Pokémon Power =` [Monster effect](http://yugioh.wikia.com/wiki/Monster_effect)
- `Active Pokémon = Monster in the Extra Monster Zone`
- `Ancient Trait` = *TBA*
- `Attach = Attach a card to a monster as a material`
- `Attack = During your Main Phase, if this card has [...] attached to it: You can activate this effect; (attack goes here).`
- `Between-Turns Step = End Phase`
- `Break Evolution` = *TBA*
- `Burn Marker = Burn Counter`
- `Damage = Place a Damage Counter on a monster at the end of the Damage Step. (Monsters with a Damage Counter lose 10 ATK for each Damage Counter on it, also are destroyed when their ATK become 0 as a result.)`
- `Damage Counter = Damage Counter`
- `Defending Pokémon = Attack target in an Extra Monster Zone`
- `Devolve` = *TBA*
- `Discard = Send a card to the Graveyard or detach a material from a monster.`
- `Evolve = Special Summon this card (from your hand) in Attack Position, by placing it on a monster that is listed in this card's text. (This is treated as an Evolution Summon.)`
- `Evolved Pokémon = "Evolution" monster with a material whose name is included on it`
- `GX Marker` = *TBA*
- `Game = Duel`
- `Hit Points (HP) = ATK`
- `In Play = Cards in the Extra Monster Zones and Main Monster Zones [or Spell & Trap Zone as an extended Bench]`
- `Knocked Out = When a monster on the field is destroyed`
- `Match = Duel`
- `Poké-Body =` [Continuous](http://yugioh.wikia.com/wiki/Continuous_Effect) `monster effect [while that monster is in a Monster Zone or Spell & Trap Zone]`
- `Poké-Power =` [Ignition](http://yugioh.wikia.com/wiki/Ignition_Effect) `monster effect`
- `Pokémon = Monster`
- `Pokémon Legend` = *TBA*
- `Poison Marker = Poison Counter`
- `Resistance` = *TBA*
- `Retreat = Once per turn: You can switch the locations of 1 monster in your Extra Monster Zone with 1 monster in your Main Monster Zone [or Spell & Trap Zone as an extended Bench], by detaching "Energy" cards from the monster in the Extra Monster Zone equal to its Level.`
- `Special Condition = Continuous Effect` (["Asleep"](https://bulbapedia.bulbagarden.net/wiki/Special_Conditions_(TCG)#Asleep), ["Burned"](https://bulbapedia.bulbagarden.net/wiki/Special_Conditions_(TCG)#Burned), ["Confused"](https://bulbapedia.bulbagarden.net/wiki/Special_Conditions_(TCG)#Confused), ["Paralyzed"](https://bulbapedia.bulbagarden.net/wiki/Special_Conditions_(TCG)#Paralyzed) and ["Poisoned"](https://bulbapedia.bulbagarden.net/wiki/Special_Conditions_(TCG)#Poisoned))
- `Sudden Death` = *TBA*
- `Weakness` = *TBA*
</details>
<details>
<summary>OT</summary>

- `0x5` = OCG only card `(0x1 OCG + 0x4 Anime/DIY)`
- `0x6` = TCG only card `(0x2 TCG + 0x4 Anime/DIY)`
- `0x7` = OCG + TCG card `(0x1 OCG + 0x2 TCG + 0x4 Anime/DIY)`
</details>
<details>
<summary>Monster Types</summary>

- `0x1	Warrior` = Superpower, Punching, Kicking, Handstand, Scuffle, Meditate, Muscular, etc.
- `0x2	Spellcaster` = Magical, etc.
- `0x4	Fairy` = Fairy, Balloon, Transform(†), Starshape(†), Happiness, Playhouse, Intertwining, Life, Cotton Candy, Fragrance, Perfume, etc.
- `0x8	Fiend` = Gas(†), Shadow, Dark(ness), Sharp Claw(†), Moonlight, Pitch-Black, Wicked, Big Boss, Disaster, Savage(†), Brutal, Scarecrow(†), etc.
- `0x10	Zombie` = **N/A**
- `0x20	Machine` = Magnet (Area), Armor (Bird), Iron (Snake, Will), Scissors, Temporal(†), Shield, Bronze (Bell), Sword (Blade), etc.
- `0x40	Aqua` = Aquamouse, Sea Lion, Tadpole, (Tiny) Turtle, Mysterious(†), Starshape, Bubble Jet, Freeze, Sludge(†), (River) Crab, etc.
- `0x80	Pyro` = Volcano, Spitfire, Flame, Fire (Horse, Mouse), Live Coal, Blast, High Temp, Lava, Ember, Scorching, etc.
- `0x100	Rock` = (Rock) Skin, Snake, Megaton, Armor, Hard Shell, etc.
- `0x200	Winged Beast` = Duck, (Twin) Bird, Beak(†), Bat, Owl, Diving(†), Music Note, Predator(†), Starling(†), etc.
- `0x400	Plant` = Seed, Vine, Flower, Egg, Coconut, (Cotton)Weed[420], Mushroom{840}, (Tiny) Leaf, Herb, Sun, Bug Catcher, Blossom, Thorn, etc.
- `0x800	Insect` = Mantis, (Poison, Tiny) Bee, Worm, Mole(†), Cocoon, Poison Gas(†), (Hairy) Bug, Butterfly, (Stag)Beetle, (Poison)Moth, etc.
- `0x1000	Thunder` = Electric, Ball(†), Light, Angler(†), Wool(†), Thunder(bolt), EleSquirrel, Flash, Spark, Gleam Eyes, Discharge, Plasma, etc.
- `0x2000	Dragon` = Dragon, Humming(†), Boundary, Cave(†), Axe Jaw(†), etc.
- `0x4000	Beast` = Mouse, (Scratch, Classy, Tiger) Cat(ty), Puppy, Drill(†) Poison Pin(†), Fox, Rat, Parent, (Pig) Monkey, Lonely, Bonekeeper, etc.
- `0x8000	Beast-Warrior` = **N/A**
- `0x10000	Dinosaur` = Fossil, Spiral(†), Head Butt, Tundra(†), Sea Lily(†), Barnacle(†), Plate, Old Shrimp(†), etc.
- `0x20000	Fish` = (Shell, Gold, Water)Fish, Neon(†), etc.
- `0x40000	Sea Serpent` = Atrocious(†), etc.
- `0x80000	Reptile` = Lizard, Cobra, (Land) Snake, etc.
- `0x100000	Psychic` = Genetic, Psi, Hypnosis, Human Shape(†), Barrier(†), Dopey, Royal(†), Mystic, Sun, Patient(†), New Species(†), Symbol, Bright, etc.
- `0x200000	Divine-Beast` = Legendary, Timetravel, Rainbow(†), Aurora, Alpha, etc.
- `0x400000	Creator God` = **N/A**
- `0x800000	Wyrm` = **N/A**
- `0x1000000	Cyberse` = Virtual, etc.
- (†) = Subject to change
</details>
<details>
<summary>Categories</summary>

- `0x1	Destroy Spell/Trap` = Put a Stadium or non-Pokémon card that is In Play into the discard pile
- `0x2	Destroy Monster` = Knock Out a Pokémon
- `0x4	Banish` = Put a card in the Lost Zone
- `0x8	Send to Graveyard` = Put a card into the discard pile; discard a card
- `0x10	Return to Hand` = Put a card that is In Play into a player's hand
- `0x20	Return to Deck` = Put a card into a player's deck
- `0x40	Hand Destruction` = Take a card or have your opponent, take a out of their hand; decrease their hand size
- `0x80	Deck Destruction` = Take a card or have your opponent, take a out of their deck; decrease their deck size
- `0x100	Increase Draw` = Put a card from the top of the deck into a player's hand
- `0x200	Search Deck` = Look at a player's deck
- `0x400	Recover from Graveyard` = Put a card from the discard pile into a player's hand, or In Play
- `0x800	Change Card Position` = Switch an Active Pokémon with a Benched Pokémon, or vice-versa
- `0x1000	Get Control` = Add a Special Condition to a Pokémon
- `0x2000	Increase/Decrease ATK/DEF` = Increase or decrease a Pokémon's HP
- `0x4000	Pierce` = Make a Pokémon do more damage, have a Pokémon take less damage, or prevent damage done to a Pokémon
- `0x8000	Multiple Attacks` = Make a Pokémon able to attack more than once per turn
- `0x10000	Restrict Attack` = Make a Pokémon unable to use its attacks; Mega Evolution; end a player's turn before that player can attack
- `0x20000	Direct Attack` = **N/A**
- `0x40000	Special Summon` = Put a Pokémon In Play; play a non-Pokémon card as if it were a Pokémon
- `0x80000	Token` = **N/A**
- `0x100000	Type` = Lists a Pokémon category (species) in the text box
- `0x200000	Attribute` = Lists a non-Attack Cost Energy Type in the text box
- `0x400000	Reduce LP` = Put a Damage Counter on a Pokémon, except due to a Pokémon's attack
- `0x800000	Recover LP` = Remove a Damage Counter from a Pokémon
- `0x1000000	Cannot Destroy` = Make a Pokémon unable to be Knocked Out; doesn't count as a Knocked Out Pokémon
- `0x2000000	Cannot Target` = Remove a Special Condition from a Pokémon
- `0x4000000	Counter` = Lists a counter/marker in the text box; put any counters/markers on a card, or remove them
- `0x8000000	Gamble` = Flip a coin; rock-paper-scissors; guess information
- `0x10000000	Fusion` = **N/A**
- `0x20000000	Synchro` = **N/A**
- `0x40000000	Xyz` = Lists an Evolution card in the text box; Evolution; evolve or devolve a Pokémon
- `0x80000000	Cancel out Effect` = Cause a Poké-Body, Poké-Power, or ability to stop working
</details>

#
© 2017 Pokémon. © 1995–2017 Nintendo/Creatures Inc./GAME FREAK inc.
