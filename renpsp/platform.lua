function GAME_hasMP3()
	return CURRENT_SYSTEM == "HM7"
end

function GAME_CPU(x)
	if CURRENT_SYSTEM == "HM7" then
		System.setCpuSpeed(x)
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

--WEETABIX NOTE: System.draw is an LPE-only requirement
function GAME_draw()
	if CURRENT_SYSTEM == "LPE" then
		System.draw()
	end
end

function GAME_nodraw()
--WEETABIX NOTE: System.endDraw is an LPE-only requirement
	if CURRENT_SYSTEM == "LPE" then
		System.endDraw()
	end
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
		--System.draw()
		screen:slowClear() 
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
