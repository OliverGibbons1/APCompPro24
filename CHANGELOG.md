# CHANGELOG
The changelog will detail edits to ALL projects on a chronological basis.

### Hangman clone 
Sep/27/2023 - The code was uploaded to SRC and ReadMe.md was updated with a class diagram and a screenshot of the running code. The link to SRC was included in ReadMe.md.

### Individual project start 
Mar/17/2024 - This project will be the final for my AP Computer Programming course. This marks the start of the project and an update to the ReadMe.md. 

Mar/20/2024 - Class diagram created and added to "images" folder. ReadMe updated with a more inclusive description of the project. Skeleton/framework (based on the current class diagram) created and instance variables created.

Mar/27/2024 - Start screen and GUI (start/quit/load game/ clear game) buttons added. Endgame defined. Startscreen and endscreen created. JSON file created for save/load/clear game. 2D array created and filled in with appropriate variables (for the map). 2D array turned into a map that is called when the game starts.

Mar/28/2024 - Adding enemies to the ArrayList<Enemy> based on round. Round start defined and nextRound and handleNextRound methods created. InfoBar created for display of important instance variables (health, gold, round, and "quit and save" button).

Apr/3/2024 - Tower pictures created and added. Range and attack instance variables utilized in IceTower. Special attack added to IceTower. Removing enemies due to damage. Timer class added (to space attacks from towers out). 

Apr/8/2024 - Fixes to code; Enemy, TowerDefense, and Button class. *note: between here and Apr 17 the iceTower special was problematic.

Apr/15/2024 - Fixes to special attack for iceTower. Specials for other towers are in the works. 

Apr/16/2024 - Fixes to range; more work on freezeSpecial() method in iceTower.

Apr/17/2024 - Specials fixed for iceTower. Special added for mageTower. Special added to fireTower. Enemy remove method fixed. Methods for start-of-game tower additions created (selectTower and optionWindow methods created). Loads of GUI for start-of-game tower selection created. ApplySpecial() images created and added.

Apr/18/2024 - GUI fixes for start-of-game tower selection. 

Apr/19/2024 - ApplySpecial() images created and added.

(Large break due to AP testing)

May/13/2024 - Added Select class. Finished start-of-game tower selection logic. Boolean check for purchasing towers. Images added to start-of-game tower buttons. 

May/14/2024 - Lots of work on specials for the towers. New timer logic (enemies can only be frozen if they are not already on fire or under mage control). Method in Enemy class to achieve this effect: hasSpecial().
