#singleinstance, force
setBatchLines -1
SetMouseDelay,-1
SetControlDelay, -1
setwindelay, -1

gui, +alwaysontop
gui, add, button, xm y40 w441 h80 vstp gonclick, click me
gui, add, button, x10 y10 gseconds1, 1 second
gui, add, button, x+10 y10  gseconds5, 5 seconds
gui, add, button, x+10 y10   gseconds10, 10 seconds
gui, add, button, x+10 y10   gseconds30, 30 seconds
gui, add, button, x+10 y10   gseconds60, 60 seconds
gui, add, button, x+10 y10   gseconds100, 100 seconds
gui, add, button, xm+319  ym+119  w122 gReload, Reload
widthspawn := A_screenwidth // 2 - 250
heightspawn:= A_screenheight // 2 - 75
gui, show, x%widthspawn% y%heightspawn% w461  h159, Click Speed Test
guicontrol,disable, stp
timeron := False
return
Reload:
    Reload
seconds1:
	guicontrol,enable, stp
	time := -1000
	return
seconds5:
	guicontrol,enable, stp
	time := -5000
	return
seconds10:
	guicontrol,enable, stp
	time := -10000
	return
seconds30:
	guicontrol,enable, stp
	time := -30000
	return
seconds60:
	guicontrol,enable, stp
	time := -60000
	return
seconds100:
	guicontrol,enable, stp
	time := -100000
	return
onclick:
	totalclicks += 1
	if (timeron = False){
		SetTimer, stop, %time%
		timeron := True
		}
	return
stop:
	guicontrol,disable, stp
	timeron := False
	msgbox, % totalclicks " Clicks"
	totalclicks := 0
	guicontrol,enable, stp
	return
