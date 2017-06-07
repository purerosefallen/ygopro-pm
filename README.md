# ygopro-pokemon-tcg
⚠️ (Work In Progress) An amateur add-on to play the Pokémon Trading Card Game on YGOPro

### How To Play
1.

**Card Types:**
- `Pokémon = Effect Monster Card (Level=Retreat Cost, ATK=DEF=HP (scard.HP=N)`
- `Trainer = Normal Spell Card`
- `Trainer-Stadium = Field Spell Card`
- `Energy = Normal Spell Card`

**Locations:**
- `Active Pokémon (In Play) = Middle Main Monster Zone`
- `Bench (In Play) = Spell & Trap Zone`
- `Discard Pile = Graveyard`
- `Lost Zone = Face-up banished cards, except *Pokémon Rules*` (text color = blue)
- `Prize Cards = Face-down banished cards (text color = black)`

**Keywords:**
- `Ability/Pokémon Power = A monster effect`
- `Attach = Attach a card to a Pokémon monster as a material/Place a card underneath a Pokémon card in the Spell & Trap Zone as a material`
- `Between-Turns Step = End Phase`
- `Break Evolution = *TBA*`
- `Burn Marker = Burn Counter`
- `Damage = Place a Damage Counter on a Pokémon monster. (Monsters with a Damage Counter lose 10 ATK and DEF for each Damage Counter on it, also are sent to the Graveyard when their ATK and DEF become 0.)
- `Damage Counter = Damage Counter`
- `Defending Pokémon = Attack target`
- `Devolve = *TBA*`
- `Evolve = *TBA*`
- `Evolved Pokémon = A Pokémon monster with a material/A Pokémon card in the Spell & Trap Zone with a card placed underneat it`
- `GX Marker = *TBA*`
- `Knocked Out = Send a Pokémon to the Graveyard due its ATK and DEF becoming 0 by a Damage Counter`
- `Poké-Body = A Continuous Monster Effect that is immediately applied when a Pokémon monster is placed on the field`
- `Pokémon Legend = *TBA*`
- `Poison Marker = Poison Counter`
- `Resistance = A Pokémon card that specifically lists "Resistance" ... in its text... (use scard.weakness...)`
- `Retreat = [Target] 1 Pokémon monster and 1 Pokémon card in the Spell & Trap Zone, [then detach...equal to its Level]; switch the placements of those cards`
- `Special Condition = Continuous Effect ("Asleep", "Burned", "Confused", "Paralyzed" and "Poisoned")`
- `Sudden Death = *TBA*`
- `Weakness = A Pokémon card that specifically lists "Weakness" ... in its text... (use scard.weakness...)`

**Categories:**
- `0x1	Destroy Spell/Trap` = *TBA*
- `0x2	Destroy Monster` = *TBA*
- `0x4	Banish` = *TBA*
- `0x8	Send to Graveyard` = *Put a card into the discard pile*
- `0x10	Return to Hand` = *TBA*
- `0x20	Return to Deck` = *TBA*
- `0x40	Hand Destruction` = *TBA*
- `0x80	Deck Destruction` = *TBA*
- `0x100	Increase Draw` = *TBA*
- `0x200	Search Deck` = *TBA*
- `0x400	Recover from Graveyard` = *TBA*
- `0x800	Change Card Position` = *TBA*
- `0x1000	Get Control` = *TBA*
- `0x2000	Increase/Decrease ATK/DEF` = *TBA*
- `0x4000	Piercing` = **N/A**
- `0x8000	Multiple Attack` = *TBA*
- `0x10000	Restrict Attack` = *TBA*
- `0x20000	Direct Attack` = **N/A**
- `0x40000	Special Summon` = *TBA*
- `0x80000	Token` = **N/A**
- `0x100000	Type` = *TBA*
- `0x200000	Attribute` = *TBA*
- `0x400000	Reduce LP` = **N/A**
- `0x800000	Recover LP` = **N/A**
- `0x1000000	Cannot Destroy` = *TBA*
- `0x2000000	Cannot Target` = *TBA*
- `0x4000000	Counter` = **N/A**
- `0x8000000	Gamble` = *Pokémon Trading Card Game*
- `0x10000000	Fusion` = **N/A**
- `0x20000000	Synchro` = **N/A**
- `0x40000000	Xyz` = *Attach/discard cards underneath other cards*
- `0x80000000	Cancel out Effect` = *TBA*
#
© 2017 Pokémon. © 1995–2017 Nintendo/Creatures Inc./GAME FREAK inc.
