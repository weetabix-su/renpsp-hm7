function GAME_hasMP3()
	return CURRENT_SYSTEM == "HM7"
end

function GAME_CPU(x)
	if CURRENT_SYSTEM == "HM7" then
		System.setcpuspeed(x)
	end
end

function GAME_fps_init()
	if CURRENT_SYSTEM ~= "HM7" then
		fpstimer = Timer.new()
		fpstimer:start()
		fpscount = 0
		fpstext = 'NaN'
	end
end

function GAME_fps()
	if CURRENT_SYSTEM ~= "HM7" then
		screen:fillRect(0,0,30,11,Color.new(0, 0, 0))
		screen:print(1,1,fpstext,Color.new(255, 255, 255))
		fpscount = fpscount + 1
		if fpstimer:time()>1000 then
			fpstext = tostring(fpscount)
			fpscount = 0
			fpstimer:reset()
			fpstimer:start()
		end
	else
		System.showFPS()
	end
end

function GAME_draw()
	if CURRENT_SYSTEM == "HM7" then
		--System.startDraw()
	end
end

function GAME_nodraw()
	--if CURRENT_SYSTEM == "HM7" then
		--System.endDraw()
	--end
	if SHOW_FPS then
		GAME_fps()
	end
	screen.flip()
end

function GAME_clear()
	screen:clear() 
end

function GAME_isdir(item)
	return item.directory == true or (item.size%4096) == 0
end

function GAME_superblit(x,y,img,imx,imy,dx,dy)
--WEETABIX NOTE: Alpha value only works on LPE
	if CURRENT_SYSTEM == "LPE" then
		screen:blit(x,y,img,1.0,imx,imy,dx,dy) 
	else
		screen:blit(x,y,img,imx,imy,dx,dy) 
	end
end

function GAME_start()
	if CURRENT_SYSTEM == "HM7" then
		--System.startDraw()
		screen:clear() 
		--System.endDraw()
		System.usbDiskModeActivate()
	end
	GAME_fps_init()
	math.randomseed(os.time())
end

function GAME_quit()
	if CURRENT_SYSTEM == "HM7" then
		System.quit()
	end
end

function GAME_print(text)
	tmpFile = io.open(ROOT_FOLDER.."/renpsp.log","a")
	tmpFile:write(text..'\n') 
	tmpFile:close()
	print(text)
end

function GAME_curdir(dir)
	currentDirectoryFunc =  nil
	if CURRENT_SYSTEM == "LPP" then
		currentDirectoryFunc = System.currentDir
	else
		currentDirectoryFunc = System.currentDirectory
	end

	if dir == nil then
		return currentDirectoryFunc()
	else
		tmp_cwd = currentDirectoryFunc()
		currentDirectoryFunc(dir)
		return tmp_cwd
	end
end

function GAME_listdir(d)
	if CURRENT_SYSTEM == "LPP" then
		if d ~= nil then
			return System.listDir(d)
		else
			return System.listDir()
		end
	else
		if d ~= nil then
			return System.listDirectory(d)
		else
			return System.listDirectory()
		end
	end
end

function GAME_chkDir(x)
	local num = 0
	if GAME_listdir(x) == nil then
		return num > 0
	end
	for idx,item in pairs(GAME_listdir(x)) do
		num = num+1
	end
	return num > 0
end

function GAME_makeDir(x)
	if CURRENT_SYSTEM == "LPP" then
		System.createDir(x)
	else
		System.createDirectory(x)
	end
end

