-- this folder
ROOT_FOLDER = System.currentDirectory()

-- folder of RenPSP engine
RENPSP_FOLDER = ROOT_FOLDER.."/renpsp"

-- folder to store game dirs
GAMES_FOLDER = ROOT_FOLDER.."/games"

-- SHOULD be "LPE"/"LPP"/"WIN"/"HM7"
CURRENT_SYSTEM = "HM7"

-- SHOULD be true or false/nil
SHOW_FPS = false       

System.currentDirectory(RENPSP_FOLDER)

-------------------
------ START -----
-------------------
dofile("main.lua")