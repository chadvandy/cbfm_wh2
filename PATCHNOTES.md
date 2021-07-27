                       Total bugs fixed: ~?

2.3.0 (?)

- Fixed Crone Hellebrons quest for Deathsword and the Cursed blade not progressing.
- Fixed Belegar Ironhammer's Shield of Defiance quest aborting without followup
- Fixed Wulfharts Hunters: Hertwig Van Hal quest interruption
- Fixed Sisters of Twilight's quest chain aborting if Venom Glade was razed
- Settra's Crown quest was not progressing
- Broken Axe (Grom the Paunch) Vortex Final Battle fixed
- Fixed errors in  Von carstein Sword of Unholy quest , Kholek's quest and Thorgrim's axe of grimnir quest
- Attacked Recently Returned Region penalty for Empire was applied even if the region was in enemy hands
- Glade lord with Talon of Kurnos had 30% range instead of 15%
- Newer Greenskin tribes did not trigger confederation dilemmas when their leader was defeated
- Tomb King 'Screamer' mission asked you to recruit the wrong type of unit
- Balthasar Gelt Barded Warhorse skill gave barded warhorses factionwide
- Soul Bound lzd skill gave buffs before rank 7 and extra missres to Coatls
- Fixed more Moulder unit set issues
- Factionwide effects which buff Supreme Sorceress rank now apply also when replacing lords
- Fixed errors with VCoast skill "Loyal to the End" and "Share the Spoils" commandment not working as intended
- Disabled a couple outdated beastmen incidents
- Peak Gate Guard didn't have splash attacks
- Prize Hunter follower upkeep reduction didn't apply to Feral Troglodons
- Norscan herdstones missing garrison
- Removed trespassing penalty after returning a settlement to an elector
- Strygos empire will no longer be at war with Rakaph Dynasty at the start and starts with less units in Vortex due to what we believe was an oversight
- Konquata had three different garrison buildings and beastmen could build a landmark there
- Demigryph knights were affected by unintended buffs
- Belegar Ironhammer once again receives An Oath Fulfilled when capturing Karak Eight Peaks
- Drycha's sacrificial grounds now has formerly missing units
- Upkeep reduction got sometimes (Lahmian) applied twice to embedded heroes
- New Beastmen factions were missing from the horde_reemergence script
- Thorek can now reequip Kraggi, assistant at the forge
- Malagor could climb ladders
- Thungni's Runic Blessing, does not get applied to the RoR Grumbling Guard unit
- Imrik's "Dragon encounter" dilemma can fire multiple times on the same turn
- Bound Fiery Convocation doesn't deal fire damage
- "Proven Tools" skill does not apply it's rune of seeking to Gob-Lobbers (Flying Fox)
- Thorek can't add sundering to ROR longbeards
- Tlaqua&ROR terradons use wrong toadskin jav upgrade
- Arcane Item gain for caster hero with non-caster lords is bugged (uses export_helpers script)
- More wrong building effects when damaged
- Kevon Lloydstein can't use his horse mounts
- Nakai Portal buildings don't affect Coatls & Feral Troglodons
- Nakai's horde armies couldn't increase the Skink Oracle agent cap (or enable recruitment).
- Kazhrak doesn't apply vanguard deployment to Razorgor chariots
- The Red Duke didn't have access to the "Aura of Dark Majesty" and "Dark Pact" skills
- Tehenhauin will start with a skink instead of saurus building in Vortex as well
- Khazrak didn't have access to his abilities in Custom Battle when mounted on his new Tuskgor Chariot
- Beastmen tech "Kadon Unleashed" can now be unlocked also when you have more than 10 summons
- Blood Kisses will now be rewarded if the faction leader is leading reinforcements
- Volkmar's phys resistance buff for flagellants was bugged
- Vlad's Monstrous Strength Skill was not accessible (wrong child link)
- VCoast Damned Paladin on Barded Warhorse was missing Hit Reactions Ignore Chance
- Public Order effects had recruitment cost increases swapped for the low and very low levels
- Coeddil's skill "Exile's return" gave"Annoyance of Netlings" to Dryads below rank 7
- Fixed a diplomacy script error to do with beastmen and trade
- Channeling stance mentions it gives 5% replenishment increase for Vampires 
- Bst army unlock says it requires Ruination Level 8, but it actually requires level 7
- Reward of Dread panel isn't properly centered on the screen
- Fixed missing animations for rogue factions' stag mounts
- Fixed a few Beastmen typos
- Groghooves description mentioned chariots for a centigor unit
- Typo: K in Empire Knights is lowercase in all of Volkmar’s new skills
- Elector Counts (First Time Occupying a Capital) advice message trigger condition wrong
- Kroq-gar trait loc forgot to mention troglodon units
- Cavill was a random name for Elf characters
- VCoast admiral tech was missing lores of magic information
- Norscan faction capitals displayed wrong slot numbers
- Slann recruitment icon and text wrong
- Alchemist's Guildhall (dwarf med plants) typo fixed
- Empire frontend text implied vassalage would be an option

2.2.9 (4)

- Couronne's main settlement building chain now provides the same growth values as other bretonnian main settlement chains
- Welf Shadow Spellsinger are no longer missing the scouting skill on the vortex campaign
- More  flying units able to cap capture points are no longer allowed to do so (Zeldrake)
- Included a fix for regular Kroxigors wrongly using Ancient Kroxigor's textures instead of their own (Lieutenant Rocky)

2.2.8 (6)

- Packmaster recruit rank effects now applies correctly
- Added missing miscast reduction to the Lord version of the upgraded Pit of Shades skill
- Fixed a rare issue that could cause Ghoritch/Coeddil to spawn for their original faction instead of the confederator (the faction that has Throt/Drycha)
- Included a fix that prevents main unit clones to level faster than intended
- Corrected Wurzzag frontend text
- Fixed a typo in the discombobulated effect description

2.2.7 (2)

- Fixed a typo in effect descriptions mentioning the Helblaster Volley Gun.
- Added missing traits for the Supreme Sorceress (Shadow)

2.2.6 (6)

- Lokhir bonus lord recruit rank skill now also applies when replacing lords
- Settra's personal skill no longer increases the Khepra Guard (ROR) cap
- The "Summon the Barrow Lords" incident now correctly references Option Key CND_NOT_HAS_AGENT champion instead of spy (types of agents)
- AI should build up the  Copher and Dragon Isle ports now
- ~~Added missing high threat entry from Brood Horrors and Mutant Rat ogre ROR(makes them prioritized by damage while in crowds, like all single entities)~~
- ~~Fixed all effect bundles for Invasion armies that used the Blood Voyage effect bundle before~~


2.2.5 (7)

- Drycha's -8 leadership skill now correctly applies to local enemy elven factions 
- For Ghoritch the loyalty feature is no longer enabled
- Eshin contract's turn timer variable is saved/loaded to/from the savegame (Hocter)
- Changing Tomb King's campaign difficulty now gets rid of the previous difficulty effects
- Corrected the Shield of Aeons mission description
- ~~Lokhir's unique black ark no longer increases supply lines~~
- ~~"Strike the Rune" now correctly decreases "Rune of Wrath & Ruin (old version)" cooldown~~


2.2.4 (3)

- Fixed a bug causing the initial Ancestor Gods effect bundle to expire one turn too early (uses wh_pro01_grombrindal script)
- Corrected various typos in overcast spell effects tooltips
- ~~Growth changes made by the latest dlc/patch now correctly apply to VH and Legendary difficulty~~


2.2.3 (2)

- The Unicorn gate main settlement building now requires growth to update
- Added missing "Demand Return" Dilemmas for Pfeildorf and Steingart
- Fixed some building and effect typos


2.2.2 (6)

- Returning/reinstating pfeildorf, steingart now correctly improves fealty.
- Added missing Lion Chariots to the army veteran skill.
- Orion is no longer penalized for standing in shallow water as if he is a small unit.
- Quality & Quantity tech now affects artillery and ror units correctly.
- Fixed the typo in "Forest of Gloorm".
- ~~Norsca god devotion stage 3 for Nurgle/Crow works correctly now.~~

Implemented script improvements suggested by Ydok

2.2.1 (5)

- Added missing Necromancy chain to the Tower of Hoeth.
- Fixed Norsca not being able to build or update the port (landmark) in the Dragon Isle settlement.
- Warlock Master on a Doom flayer mount now correctly keeps its campaign variant in battle.
- Added a bunch of missing 2D Portholes for skaven summons and moulder flesh lab units.
- Fleet Captain (Deeps) is no longer just standing on his crab mount in campaign.


2.2.0 (20)

- Disabled caster innate traits for mourngul haunters.
- Fire mages on dragons can no longer capture victory zones.
- Fixed an issue causing Vampire coast factions to not be able to build the treasure chain in The Fortress of Vorag region.
- Norscan/Greenskin rebel, invasion, waaagh, separatists and 
incursion factions can no longer confederate via the faction leader defeated dilemma.
- Sword of Khaine no longer returns whenever occupation decisions are performed on the Shrine of Khaine region.
- Added missing recruitment cost reduction for the new Moulder units when playing as Eshin.
- Changed Gaean vale main building to allow glade guard recruitment.
- Sisters of Twilight and Glade Captain can now equip the Bow of Loren.
- Fixed Kroq Gar's chapter 2 bonus mission objectives being mixed up.
- Wood Elven lords can no longer gain the Procrastinator trait.
- Fixed AI Mutinous Gits free army effect bundle not being removed after confederation.
- AI Drycha can now gain the "potion of sacre" trait.
- Applied restrictions so Drycha can no longer put Spellweavers in offices.
- Event messages for foreign slot (Underempire etc.) changes now fire correctly.
- Imrik is now mounted on Minathnir instead of a regular star dragon mount on the campaign map.
- Added missing 2D porthole for summoned Thane Ghost.
- Added missing 2D porthole for Geomantic Nexus Skink priest 
- Fixed the tooltip for Diamond Guardian Phoenix claiming it provides magical instead of physical resistance.
- ~~Glade Captain/Glade Lord on a Great Stag now have a 360° arc of fire (same as on all other mounts).~~
- ~~Changed Norscan minor outpost building to allow for marauder recruitment~~

2.1.9 (9)

- Resolved an issue causing Sarthorael to spawn without units when the player is controlling chaos.
- Fixed two Bloodline skills for the Red Duke not being mutually exclusive
- Included previously missing Supreme Dark Sorceress trait changes, removing some fighter traits and adding caster ones
- Enabled AI Wood Elves to build the Temple of Anath Raema
- Added missing tooltip description for lahmian vampire lords lightning reflexes ability.
- ~~Changed the number of skill points Wood elf lords need in their blue skill line sections in order to move on to the next section to 4. (confirmed oversight)~~
- ~~Applied missing changes from the patchnotes: "Ungrim’s skill “Slayer King” now grants +5 melee attack to slayers, down from +10" "Ungrim Lord effect: Now grants +5 melee attack to slayers, down from +10".~~
- ~~Wildwood Waystones Landmark now correctly provides +5MD for Wildwood Rangers.~~

Corrected an issue we introduced causing Tyrion's upkeep reduction to apply to rangers twice.

2.1.8 (16)

- Confederating Throt before level 5 will no longer prevent you from getting Ghoritch.
- Fixed confederated Drycha not being able to spawn Coeddil.
- The AI can now get Ariel if the player starts as Drycha.
- Resolved an issue causing Rat Ogre RoRs not benefiting from tech boni.
- Ka-Sabar on the Vortex campaign as the Lizardmen no longer has access to the Stone Marker building.
- Fixed the wh_dlc03_faction_diplomacy_mod effect not affecting some subcultures.
- Corrected unit caste in main_units for some of drycha's units.
- When confederating Drycha, finishing her last quest stage will now automatically equip her quest item.
- Fixed a typo for Warrior's Crest skill.
- Fixed missing speech for teclis mounted on his phoenix in the final vortex battle.
- ~~Confederating Throt won't enable the loyalty feature and won't any longer cause him to lose his immortality.~~
- ~~Settra on his Chariot of the Gods got his undead attribute back~~
- ~~Archaon's rank buff no longer provides 27% damage regardless of rank.~~
- ~~Gaean Vale gets 10 slots when owned by Wood Elves like the other major tree settlements.~~
- ~~Coeddil is now immortal.~~
- ~~Drycha Potion of Sacre now correctly applies to Dryad, Treekin and Treeman units.~~

2.1.7 (5)

- Resolved an issue where the Dreadfleet's initial mission targets the wrong military force.
- ~~Fixed a bug with the fallback missions when Wurrzag is confederated.~~
- ~~Beastlords on a razorgor chariot no longer randomly change their variantmeshes when entering the battle environment.~~
- ~~Dwarf rank 7 skill Honoured by Grimnir now correctly affects armour piercing weapon damage.~~
- ~~Increased Peak Gate Guard's armour piercing weapon damage by 1 (so both Peak Gate Guard and the standard Hammerer unit use the same value).~~

2.1.6 (8)

- Skarsnik's Death Juice contact effect now works correctly
- Resolved a rare script error caused by the Vampire Coast Treasure map listener
- Fixed duplicate buildings for Bloody Handz
- Gunnery Wight shooting animation no longer causes the gun to clip through the hand holding it
- Savage Orc Camp no longer shows the upgrade symbol when at max lvl
- Fixed a typo in the Mission description for the Cobra Mace of Mazdamundi quest
- ~~Improved mod compatibility for Savage orc building fix~~
- ~~Resolved a rare error caused by Imrik's Dragon encounter script~~

2.1.5 (8)

- Mist of Yvresse attrition effect actually works now
- Lokhir's sea encounter quest objective no longer randomly stops working
- Auto Resolving Lightning strike battles no longer causes characters to be imprisoned by Yvresse if they are not actually taking part in the battle (uses wh2_dlc15_eltharion_lair script)
- Wurrzag can once again select the Dodgy Geezer skill
- Gotreks exp sharing effect no longer stays with the army he lead after he is wounded or left the faction
- Removed second Gunnery Wight from Vampire Coast main building garrison
- Campaign Custom Starts script error resolved
- ~~MP Greenskin Incursion event as Bretonnia can now be resolved~~

2.1.4 (4)

- Corrected Repanse's damage to buildings values (150 instead of 10)
- Added missing miscast reduction effect for the Biointerfaces upgrade
- Added missing Power of Darkness skill entries for the skill colour fix 
- ~~Re-enabled Cult of Sotek's sacrificial offerings pooled resource icon and counter~~

2.1.3 (4)

- Triple garrison for Vampire Counts in Massif Orcal and Yvresse removed
- Smithy's Tavern hero and Louen paladin rrank effect specify the effect is regionwide
- ~~Empire Spy Guild trade agreement visibility fix for a fix (gave vision from the start of the game)~~
- ~~Dark elf master heroes did not apply the initial bonus to province growth (Mandras)~~
- ~~Triple garrison for Wood Elves in Massif Orcal and Yvresse removed~~

2.1.2 (13)

- Empire Spy Guild trade agreement visibility now works
- Many Bretonnian main settlement buildings had wrong PO/Growth values
- Some settlement buildings lost their walls/siege holdout effects when damaged
- Dwarfen ruins retained walls and siege holdout increasing effects
- Broken axe faction icon wrong size
- DEF redline rank 7 skill missing a comma
- Eltharion's mirrored "Grom's Waaagh!" now states that it restores health (Guvenoren)
- State trooper sleeve knots were missing an "alpha"
- ~~Mere-meer typo fix for undercity detection string_event_feed~~
- ~~Removed Norsca garrison buildings in major settlements fix(may return)~~
- ~~Norsca can now occupy some missing new port settlements~~
- ~~Missing animation for Dragon Spine Privateers pirate princes~~
- ~~Dwarfen forge UI  said unique items could be crafted multiple times ~~

2.1.1 (42)

- Imrik special dragons will receive all dragon buffs
- AI may now build some W&P DLC landmarks
- Skaven Reactor, Lzd Geomantic, TK Estate,TK Warsphinx, DE Cold ones,, Dwarf Oaths and  VC Terrorgheist Lair buildings can now be built in the Fortress of Vorag
- You can donate settlements to the Golden Order as Reikland
- Max Rank K8P Skarsnik landmark will no longer downgrade the garrison from 2 to 1 goblin
- Padded shield scrap upgrade will correctly deactivate when wavering or routing
- Savage Orc Boars are now affected by the new boar speed tech
- Already recruited lords in your pool will be wounded instead of killed when chosen to lead Empire intervention armies(this fix may be overwritten by or overwrite part of another mod which uses the wh2_dlc13_empire_politics.lua script)
- AI Greenskins should use faction specific scrap unit upgrades like intended now(Agemouk)
- Mistwalkers can properly mimick Murderous mastery now
- Skavenblight and Hellpit walls will no longer disappear if the settlement is damaged
- AI paladins will get vows as they level too
- Dodgy Geezer for Great Shamans is selectable once more
- Sigmar's ward is available for Amethyst wizards too
- Mistwalker HQ chains should no longer appear twice in certain settlements
- Oreon's camp and Laurelorn forest can now build the Mistwalker HQ
- Normal fanatics excluded from archer unit set (received archer buffs)
- Bretonnia can now acquire the lazy and good/bad at sieging traits
- Karak Eight Peaks no longer has 5 slots for Tomb Kings
- Hell Pepper and Yolk ingredients will also unlock with Regiment of Renown versions of that unit
- River Troll Hag can now acquire traits for assault unit and steal technology
- Warden's cage will do damage as per the tooltip(The Hammer)
- Fixed tooltips and vfx for Gotrek's heroic fortitude, it will also not be affected by miscast chance modifiers (bug for healing nearby enemies persists)
- Added Knowledgeable and Intelligent traits to possible traits for Supreme Sorceresses (matches other caster lords)
- Awakened battlefield specifies the raise dead buff is regionwide
- Many settlement tooltips now state the correct number of slots 
- Gelt will autoequip the Staff of Volans at quest end
- Fixed two different core_object methods having the same name
- ~~Fixed identical text on some Empire dilemmas~~
- ~~Donating Karak Raziak as Nakai will no longer revive Ostermark with a temple~~
- ~~Gor-Rok in ME and all Lizardmen LLs in Vortex will no longer skip to the last mission in their quests(uses wh_quests.lua script)~~
- ~~Norscan settlements will also receive buffs/debuffs based on public order level~~
- ~~Black Ark admirals will start with immortality skilled because they're already immortal~~
- ~~Fixed xp tooltip for Blood Dragon tier 2 bloodline and Hef, Def and Lzd post-battle option~~
- ~~Gotrek will no longer crash the game when dead and opening the recruit lord panel~~
- ~~ Imprisoning a Legendary Lord will now  give your lord their "defeated" trait~~ 
- ~~Changed the recycle value of some Forge items to be lower than their buy value~~
- ~~Wood elf tech no longer gives bankruptcy attrition immunity~~
- ~~Geomantic web will now connect to Morgheim~~
- ~~Imrik's Ashen fields skill will properly apply fire weakness~~
- ~~Storag Kor will no longer be colonized by Delves with an already built industry building~~
- ~~Vaul's anvil can now build the Mistwalker HQ~~
- ~~Slann, not Slaan~~

2.1.0 (21)

- Greenskin +5 recruit rank lord tech will not apply twice for replaced lords
- Wurrzag retains his physical resistance buff on his Big Waaagh ability
- Arachanarok Queen ROR counts for Azhag's Arachnarok quest requirement
- Fixed many Greenskin unit sets, especially Regiments of Renown. They will receive appropriate buffs now
- Red Crested Skinks will no longer receive twice the bonuses from Tehenhauin skills
- Nakai tier 2 minor horde Tlanxla portal will not reduce horned one recruitment time
- Silverin Guard will now benefit from some effects + text fix
- Fixed Yvresse giving 300 leadership when damaged
- Most AI factions may now build garrisons in Norsca
- The Shadow title WOM increase for Mistwalkers will now work for heroes
- Teclis skill Master of the order will now affect embedded Fire mages on Sun dragons
- Orc and Big Uns units effect will now read Orc Boy and Big Uns units to avoid confusion
- ~~Added War Lions and Lion Chariots to Fur building recruit rank bonuses~~
- ~~Abandon Sphinx dilemma had it's tooltip inverted~~
- ~~Skarsnik now has Black orc cap increase for tier 3 AND 4 barracks~~
-  ~~Ulthar's raiders received the ammo increase their normal counterpart received last patch~~
-  ~~Avelorn has access to all lores of magic on mages~~
- ~~Nakai can gift some new update regions to the Defenders of the Great Plan~~
- ~~many effects targeting War lions, White lions and Lion chariots should properly work~~
- ~~Tyrion innate skill will properly affect rangers~~

2.0.9 (4)

- Disbanding lords does not count towards the defeat 5 lords vow anymore
- Grom -7 leadership to Elves actually works (Mandras)
- Ratnik lord effect affects both spider RORs (Mandras)
- ~~Fix for a fix: new DLC lords will now give their defeated trait, our mistake~~

2.0.8 (5)

- Death and shadow Vampires have the same traits now
- Bretonnian characters, Tlaqua skinks and Imrik come back on their proper mounts after being un-wounded
- Miscellaneous fixes for Red Cloud and Leaf Cutterz and some vassalization options between Greenskins and Savage orcs (Lost2insanity)
- Fixed weapon grip for Arkhan on steed
- ~~Fixed weapon grip for : warlock master doomflayer, master assassin, liche priest steed, multiple Eltharion models, some Imrik model/s, miscellaneous Empire and Elf stuff (all credit Marthenil,Mathej,JvJ,Zahel)~~

2.0.7 (24)

- Arkhan and Vlad will mention diplomacy bonuses on their faction screen
- Tortura trait public order part works in friendly territory
- Cruel and Treacherous traits now work
- Replace lord recruit rank fix for Snikch skill
- Wrong values, mostly damaged, for many buildings
- Ushabti and Necroknight regiments of renown missing melee atk and def from tech, Ushabti ROR missing from rank 7 archer unit set, Blessed Stegadon missing 15% missile resist like its normal counterpart(Goremand ft Smokin)
- Alarielle's version of the Court of the Everqueen did not drop Priestesses of Isha
- Ushabti Bodyguard follower is now obtainable
- Tlaqua terradons should now benefit from all effects that target terradons
- Glade Guard and Glade rider ranged variants benefit from all the same buffs as their normal counterpart now as opposed to almost zero
- Goblin archer fanatics missing from two unit sets(didn't receive some goblin archer buffs)
- Southern Realms can now build Peg street pawnshop and Smithy's tavern in Sartosa
- Embedding Green Knight, Kihar or recruiting Azrik and reloading will not unlock all your regiments of renown
- Minor Dwarfen coastal settlements are assigned to the minor Dwarfen settlement set
- Diplomacy with crusaders tech mentions Repanse's faction
- Two Toes Adley was labeled a Vampires and not Deeps caster
- Vamp coast tech specifies that it's armor piercing missile damage not melee
- ~~Ariel's chosen trait melee attack bonus now works~~
- ~~Ruined Karaz-a-Karak can now be upgraded by Tomb Kings~~
- ~~Lord Xltep of Itza is now a unique name~~
- ~~Summoned Dwarfen ancestor unit card fixed (Cataph)~~
- ~~Chaos horsemasters no longer lack mountain, snow and chaos attrition immunity~~
- ~~Pyramid of Nagash states proper number of building slots (Crynsos)~~
- ~~Master of the black arts miscast icon fixed~~

2.0.6 (25)

- fixed confederated legendary lords from having two copies of the same vow
- fixed multiple pledge bug at high chivalry
- Sartosa counts as a full Norscan city
- Fixed Wulfhart Disrupt & Destroy Mission not resolving
- fixed coop victories awarding the partner's defeated trait
- Alarielle's Star of Avelorn quest now has the right icon
- Black Corn Swamp building english localization fix
- the version of Itza and Hexoatl owned by other lizard factions is no longer called"occupied"
- ~~Menace Below now always has the proper number of uses~~
- ~~High Elf skill "Silver Torrent" affects great eagles~~
- ~~Many Tomb king RORs receive bonuses properly now(Goremand ft Smokin)~~ 
- ~~+5 MA part of TK tech goes properly to Necrosphinxes instead of Warsphinxes~~
- ~~Repanse now gets the lionhearted skill like all other bret lords do~~
- ~~fixed an issue with mazda sunburst standard quest stage 2~~
-  ~~Cataph and Vandy think a 0 on the warlord skill ravenous expansion is an oversight so they removed it~~
-  ~~Norscan characters are now properly linked to the warhammer 2 traits instead of their pre-norsca dlc counterparts (credit Sadge)~~
- ~~Maimed leg/arm traits give the appropriate army-wide buff they promise~~
- ~~Fixed Cunning so that hordes / armies in enemy territory have the ambush buff.~~
- ~~Fixed Virtue of Duty so that it works for heroes and not just lords.~~
- ~~intelligent trait has proper scope~~
- ~~Bloated corpse now has terror~~
- ~~Henri le Massif on Hippogryph has siege attacker~~
-  ~~Vampire Coast special settlement chains have their improved projectile effects now~~
-  ~~Integrated Goremand's ROR stat parity mod bringing some ror to the level of their rank9 normal counterparts~~

2.0.5 (17)

- Rogue armies shouldn't sit there and do nothing and get stuck anymore
- Wulfhart has a confederation cooldown
- Repanse's early game mission will properly target the Livery/Grail Chapel instead of Tavern/Barracks for "build a building that allows hero recruitment".
- Empire-occupied Norscan settlements now have recruitable archer and spearmen units in the main chain.
- Noctilus keeps "Encourage" as an ability while mounted.
- The "+ agent success chance" effects for the Undercity Strongholds actually works
- Clarified the tooltip for the Regiments of Renown unlock level requirements, should be clearer that heroes count for the unlock level.
- Fixed the "Strategic Location" icon for Tower of Hoeth showing up for Vampires(the landmark was purposefully removed)
- Tiktaq'to's "Master of Skies" skill now has the right icon size.
- ~~The Beastmen faction spawned by Malus's Warpsword quest can no longer go to war with anyone but Malus~~
- ~~The naval stance "Full Speed" now properly gives units fatigue in combat.~~
-  ~~The Revitalising Scheme rite won't cause agents to become stacked and stuck on one another.~~
- ~~Snikch's weeping blades will auto-equip when earned.~~
-  ~~More recruit-rank fixes for +recruit rank when replacing lords (for Skaven this time!)~~
-  ~~Fixed some bugged traits - Sea Legs will only be given to generals, and Lazy/Campaigner should now be unlockable once more~~
- ~~Fixed wrong unit caste for ROR Squig Hoppers.~~
- ~~Wulfhart's starting heroes will always properly get their unique trait~~

2.0.4 (5)

- Shrine of Sotek, Miragliano, and Gaean Vale have more appropriate "Strategic Location" icons - showing up only for Tehen, TEB, and Elven factions respectively
- ~~Fixed a bug caused by another bug fix, Bretonnian Elven colonies will no longer act weird if already occupied. Just load up a save and they'll be fixed.~~
-  ~~Chief Doomclaw's name is unique once more~~
-  ~~The Warp-Grinder unit is now appropriately marked as a melee unit in battle (Ctrl+M won't include them, for instance)~~
- ~~Resolved some missing unit-sets for the Red Duke, causing them to miss out on some sweet effects~~

2.0.3 (11)

- The Awakening is now treated as a full Norscan city, not just an outpost
- The main settlement building in "Elven Colonies" now have the upgraded Bretonnian effects, walls, and garrisons.
- Fixed most instances of trade tariffs being referred to as "trade" 
- Wulfhart Imperial supply units and Manticores for Beastmen and rogue armies might be recruited by the AI now
- ~~The Defenders of Ulthuan mechanic has had a bug resolved that caused the script to consider any region conquered in the Ulthuan area as High Elf owned,for instance, if Dark Elves conquered a Skaven-owned settlement, the mechanic would consider the region owned by High Elves after.~~
- ~~Sylvanian Bows/Guns and Norsca hunt ROR/Iceforged Legion might be recruited by the AI now~~
-  ~~The Tower of Hoeth landmark for the Dark Elves now allows for recruitment of Medusa units and has some missing effects from the usual Sorcery chain, such as +1 Capacity for Sorceresses on level 1.~~
-  ~~The Count of Talabecland's faction effect that claims to give "+20% income from Timber" will now actually given +20% income from timber. Unfortunately, the timber building chains will now show two different "Income: +x" effects, one will show 0 and the other will show the proper value.~~
- ~~Black Ark Admirals will now properly be given scripted traits - such as those given for defeating legendary lords. There's a chance they may get some negative traits or non-fitting ones, please report back with any weird issues~~
- ~~The Bretonnian tech "Support Religious Errantry" will now give +100 diplo to all crusader factions, including Repanse. This doesn't trigger a confederation or anything, as that would definitely be too much of a reach.~~
-  ~~Harkon's "+8 Leadership vs Lizardmen" was removed from the "faction effects" section and placed into "lord effects" on the frontend as it should.~~
-  ~~Some Empire effects now properly give +recruit rank for replaced lords.~~

2.0.2 (10)

- Def/hef/skv/lzd effects affecting ports should now always function properly.
- "Sacred Kroxigor" renamed to "Sacred Kroxigors". UNPLAYABLE.
- Thorgrim's portrait no longer has two different versions in different spots.
- ~~The VCoast "Ensorcelled Weapons" character skill will now properly apply to Queen Bess~~
- ~~Skaven confederation bug with Undercities has been resolved, if you confederate and gain a region you had an Undercity beneath, the Undercity will be removed (instead of previously being unclickable and annoying).~~
-  ~~Liber Bubonicus' "-25% rite cost" will now properly work for Skrolk's new rite~~
-  ~~A bunch of units have been given their proper attrition immunities for their factions - this was the cause for stuff like Bloodline lords getting attrition from vampiric territory in niche instances.~~
-  ~~Skryre's Doomflayer RoR will now get the Brass Orb ability in campaign~~
- ~~Bretonnia, Norsca, Wood Elves, Warherd of the Shadowgave and Chevaliers de Lyonesse properly use faction colours for RoR units~~
-  ~~Fixed the broken-texture quiver on Empire Archers.~~

2.0.1 (3)

-  ~~Malus's starting dilemma will no longer kill Malus/the Blark if you disbanded the Hag Graef army before taking over the first Tor Elasor settlement.~~
-  ~~Added missing DLC characters to the list for some Dwarf Hero/lLord buffs.~~
- ~~The "Repanse Supplies" mechanic should now work properly in multiplayer campaigns.~~

2.0.0 (39)

- Higher Portal of Tlanxla now gives -2 to global recruitment duration instead of -1, to match other higher portal buildings
- Book of Nagash #8 gives +50% effectiveness increase for the Worship of Ptra commandment as advertised, instead of only +33%
- Fixed a bug preventing confederation with Graeling and Sarl after defeating their leaders
- Fixed Nakai's armies from being broken hordes when the faction is confederated by another Lizardman faction. Now a script will make them regular armies instead.
- Fixed Lokhir's Helm of the Kraken quest data-setup to work properly.
- Fixed Nakai's Golden Tributes quest not working with Sacred Kroxigor units
- Some minor wef/bst/vmp factions were locked to only recruiting 1 army ever
- Bloodline lords added to the custom battle factions for Vlad/Mousillon/Kemmler
- Integrated sm0kin’s skill colour fix, which corrects missing colour information for spell skills. All vanilla skills that grant spells are now correctly coloured according to their lore.
- Arcane Unforging now mentions it causes damage in the tooltip(Guvenoren)
- ~~The High Beastmaster's skill line will properly give MD to the new dark elf monsters~~
- ~~Nakai's "Rite of Allegiance" now properly works and gives hostile armies in DotGP's lands attrition~~
- ~~Fixed Kraken's Pull's unclear tooltip(Guvenoren)~~
-  ~~Added "Strategic Location" icon for the Copher region and corrected the icon entry for the Dragon Isle regions~~
-  ~~Fixed some missions not accepting RoR/other variants of the same unit (ie. shielded/unshielded).~~
-  ~~Fixed an AI issue that resulted in many factions never recruiting a second army, due to those factions not wanting to build necessary recruitment buildings.~~
-  ~~Fixed "Spirit of the Jungle" Saurus Old-bloods & Red-Crested Skink Chiefs not having access to the mounts unlocked through skills~~
-  ~~Enables dark elf masters to equip Delf followers~~
-  ~~Skaven's Brightstone Mine is now build-able in Mount Gunbad~~
- ~~ Itza's primary settlement now gives access to skink cohort's recruitment~~
-  ~~Sword of Rhuin had `augment_melee` as its ai_usage, changed to `augment_ranged_melee`~~
-  ~~Tomb King lords no longer cost money when recruited through "Replace Lord" dialogue~~
-  ~~High Elf Fort garrisons no longer have a weaker level 5 compared to 4~~
-  ~~Cairn Wraiths now properly cause fear as well as terror~~
-  ~~Vampire character mounts are unlocked at the same standard levels rather than the random variances between subtypes~~
-  ~~Crash/inaccessible quest marker for the K8P battles for Skarsnik/Belegar have been fixed.~~
-  ~~Added Master to Morathi's upkeep reduction list~~
-  ~~Prayer of Fortitude and Righteous Strength techs now properly affect characters~~
-  ~~The Red-Crested Skink Chief on Ancient Stegadon will no longer take attrition from desert/swamp/non-vampiric territory (Jhuutom, Vandy)~~
-  ~~"Banishment" should now be available while Volkmar's "Altar of Sigmar" mount is equipped~~
-  ~~Some lord recruit rank effects now also apply to replace-recruited lords (Mr. Festis, Jhuutom, Vandy)~~
-  ~~Morathi's Amber Amulet cannot be lost or stolen anymore~~
-  ~~Malus's "+10% intercept chance" effect now shows on the faction panel~~
-  ~~Bretonnian settlements in the Norscan/Albion regions now have the improved garrisons and +income from the latest patch~~
-  ~~Nakai's "gift to" options now work in the Darklands~~
- ~~Only Cult of Sotek will get Sacrificial Offerings post-battle, instead of all lizard factions~~
-  ~~Fixed a bug which gave additional upkeep  if you recruited a second army and lost/disbanded your first army, or any variation therein. ~~
-  ~~Under-empire nukes won't spawn colonels(phantom heroes) anymore~~
-  ~~"Flensing Ruin" upgraded skill will no longer remove the skill entirely~~
