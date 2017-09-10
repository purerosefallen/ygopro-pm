# ygopro-pm

### How To Play
1. Start YGOPro.
2. Disable `Auto chain order` in the Settings tab in Deck Editor.<br>
If enabled, always choose the chain order from left to right.
3. Make a main deck of exactly 60 cards:<br>
-All 60 cards must be Pokémon cards.<br>
-Add *Pokemon Trading Card Game Rules* to your extra deck.<br>
-If there is at least 1 non-Pokémon card in your deck, you will lose the duel.<br>
4.

<details>
<summary>Card Types</summary>

- `Pokémon = Monster + Effect (Level=Retreat Cost, ATK=DEF=HP)`
- `Trainer = Spell`
	- `Stadium = Spell + Field`
- `Energy = Spell`
</details>
<details>
<summary>Locations</summary>

- `Active Pokémon (In Play) = Extra Monster Zone`
- `Bench (In Play) = Main Monster Zone`
- `Discard Pile = Graveyard`
- `Lost Zone = Face-up banished cards`
- `Prize Cards = Cards placed underneath "Prize Cards" in left-most Spell & Trap Zone` (Your opponent's LP is equal to your total number of Prize cards.)
</details>
<details>
<summary>Glossary</summary>

- `Ability/Pokémon Power = Monster effect`
- `Active Pokémon = Monster in the Extra Monster Zone`
- `Ancient Trait = *TBA*`
- `Attach = Attach a card to a monster as a material`
- `Attack = When a monster declares an attack`
- `Between-Turns Step = *TBA*`
- `Break Evolution = *TBA*`
- `Burn Marker = Burn Counter`
- `Damage = Place a Damage Counter on a monster at the end of the Damage Step. (Monsters with a Damage Counter lose 10 ATK and DEF for each Damage Counter on it, also are sent to the Graveyard when their ATK and DEF become 0.)`
- `Damage Counter = Damage Counter`
- `Defending Pokémon = Attack target`
- `Devolve = *TBA*`
- `Evolve = *TBA*`
- `Evolved Pokémon = Monster with the appropriate material`
- `GX Marker = *TBA*`
- `Hit Points (HP) = ATK = DEF`
- `In Play = Cards in the Extra and Main Monster Zones`
- `Knocked Out = Send a monster to the Graveyard [due its ATK and DEF becoming 0 by a Damage Counter]`
- `Poké-Body = Continuous monster effect that is immediately applied when a monster is placed in the Monster Zone`
- `Poké-Power = Ignition monster effect`
- `Pokémon = Monster`
- `Pokémon Legend = *TBA*`
- `Poison Marker = Poison Counter`
- `Resistance = *TBA*`
- `Retreat = Once per turn: You can switch the locations of 1 monster in your Extra Monster Zone with 1 monster in your Main Monster Zone, by detaching the appropriate Energy cards from the monster in the Extra Monster Zone equal to its Level.`
- `Special Condition = Continuous Effect ("Asleep", "Burned", "Confused", "Paralyzed" and "Poisoned")`
- `Sudden Death = *TBA*`
- `Weakness = *TBA*`
</details>
<details>
<summary>Categories</summary>

- `0x1	Destroy Spell/Trap` = *TBA*
- `0x2	Destroy Monster` = *TBA*
- `0x4	Banish` = *TBA*
- `0x8	Send to Graveyard` = Discard a card
- `0x10	Return to Hand` = *TBA*
- `0x20	Return to Deck` = *TBA*
- `0x40	Hand Destruction` = *TBA*
- `0x80	Deck Destruction` = *TBA*
- `0x100	Increase Draw` = *TBA*
- `0x200	Search Deck` = *TBA*
- `0x400	Recover from Graveyard` = *TBA*
- `0x800	Change Card Position` = Switch an Active Pokémon with a Benched Pokémon or vice-versa
- `0x1000	Get Control` = *TBA*
- `0x2000	Increase/Decrease ATK/DEF` = *TBA*
- `0x4000	Piercing` = *TBA*
- `0x8000	Multiple Attack` = *TBA*
- `0x10000	Restrict Attack` = *TBA*
- `0x20000	Direct Attack` = *TBA*
- `0x40000	Special Summon` = *TBA*
- `0x80000	Token` = *TBA*
- `0x100000	Type` = *TBA*
- `0x200000	Attribute` = *TBA*
- `0x400000	Reduce LP` = *TBA*
- `0x800000	Recover LP` = *TBA*
- `0x1000000	Cannot Destroy` = *TBA*
- `0x2000000	Cannot Target` = *TBA*
- `0x4000000	Counter` = *TBA*
- `0x8000000	Gamble` = Flip a coin
- `0x10000000	Fusion` = *TBA*
- `0x20000000	Synchro` = *TBA*
- `0x40000000	Xyz` = Attach/discard a card underneath another card
- `0x80000000	Cancel out Effect` = *TBA*
</details>

#
© 2017 Pokémon. © 1995–2017 Nintendo/Creatures Inc./GAME FREAK inc.
