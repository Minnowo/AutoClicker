﻿#singleinstance, force
setBatchLines -1
SetMouseDelay,-1
SetControlDelay, -1

gui, +alwaysontop
gui, add, text, x10 y10 , Mouse Button
gui, add, text, x90 y10 , Hold Button
gui, add, text, x210 y10 , Click Type
gui, add, text, x330 y10 , Min Delay
gui, add, text, x400 y10 , Max Delay
gui, add, text, x52 y40 , Left :
gui, add, text, x45 y+17,  Right :
gui, add, text, x39 y+17,  Middle :

gui, add, dropdownlist, xm+80 ym+30 w100 r10 vButton gFirstButton, None||Middle|xButton1|xbutton2|
gui, add, dropdownlist, xm+80 ym+60 w100 r10 vButton1 gSecondButton, None||Middle|xButton1|xbutton2|
gui, add, dropdownlist, xm+80 ym+90 w100 r10 vButton2 gThirdButton, None||Left|Right|xButton1|xbutton2|
gui, add, dropdownlist, xm+200 ym+30 w100 r10 vClicktype1 gFirstButtonclicktype, Single||Double|
gui, add, dropdownlist, xm+200 ym+60 w100 r10 vClicktype2 gSecondButtonclicktype, Single||Double|
gui, add, dropdownlist, xm+200 ym+90 w100 r10 vClicktype3 gThirdButtonclicktype, Single||Double|

gui, add, edit, xm+320 ym+30 w50 vMinSleep gMinSleep Number, 
Gui, Add, UpDown, Range1-1000, 30
gui, add, edit, xm+390 ym+30  w50 vMaxSleep gMaxSleep Number, 
Gui, Add, UpDown, Range1-1000,60
gui, add, edit, xm+320 ym+60 w50 vMinSleep1 gMinSleep1 Number, 
Gui, Add, UpDown, Range1-1000, 30
gui, add, edit, xm+390 ym+60  w50 vMaxSleep1 gMaxSleep1 Number, 
Gui, Add, UpDown, Range1-1000,60
gui, add, edit, xm+320 ym+90 w50 vMinSleep2 gMinSleep2 Number, 
Gui, Add, UpDown, Range1-1000, 30
gui, add, edit, xm+390 ym+90  w50 vMaxSleep2 gMaxSleep2 Number, 
Gui, Add, UpDown, Range1-1000,60
 
gui, add, button, xm+79  ym+119 w102 vstr gStart,  Start
gui, add, button, xm+199  ym+119 w102 vstp gStop, Stop
gui, add, button, xm+319  ym+119  w122 gReload, Reload
gui, add, button, x0 ym+130   vtmr gonclick, click me
gui, add, button, x0 ym+110 w25 gseconds1, 1s
gui, add, button, x+0 ym+110 w25 gseconds5, 5s

widthspawn := A_screenwidth-548
heightspawn:= A_screenheight-652
gui, show, x%widthspawn% y%heightspawn% w500 h159, AutoClicker
guicontrol,disable, stp
guicontrol,disable, tmr

clicktype1 = 1
clicktype2 = 1
clicktype3 = 1
timeron := False
return
GuiClose:
	Exitapp
	return
Reload:
    Reload
MinSleep:
	gui, submit, nohide
	MinSleep = % MinSleep
	return
MaxSleep:
	gui, submit, nohide
	MaxSleep = % MaxSleep
	return
MinSleep1:
	gui, submit, nohide
	MinSleep1 = % MinSleep1
	return
MaxSleep1:
	gui, submit, nohide
	MaxSleep1 = % MaxSleep1
	return
MinSleep2:
	gui, submit, nohide
	MinSleep2 = % MinSleep2
	return
MaxSleep2:
	gui, submit, nohide
	MaxSleep2 = % MaxSleep2
	return
FirstButton:
	gui, submit, nohide
	button =  % Button
	if button = Middle
		button = MButton

	return
	
SecondButton:
	gui, submit, nohide
	button1 = % Button1
	if button1 = Middle
		button1 = MButton
	return
ThirdButton:
	gui, submit, nohide
	button2 = % Button2
	return

FirstButtonclicktype:
	gui, submit, nohide
	clicktype1 := % Clicktype1
	if clicktype1 = Single
		clicktype1 := 1
	if clicktype1 = Double 
		clicktype1 := 2
	return
SecondButtonclicktype:
	gui, submit, nohide
	clicktype2 = % Clicktype2
	if clicktype2 = Single
		clicktype2 := 1
	if clicktype2 = Double 
		clicktype2 := 2
	return
ThirdButtonclicktype:
	gui, submit, nohide
	clicktype3 = % Clicktype3
	if clicktype3 = Single
		clicktype3 := 1
	if clicktype3 = Double 
		clicktype3 := 2
	return
seconds1:
	guicontrol,enable, tmr
	time := -1000
	return
seconds5:
	guicontrol,enable, tmr
	time := -5000
	return
onclick:
	totalclicks += 1
	if (timeron = False){
		;tooltip, start timer
		SetTimer, timerstop, %time%
		timeron := True
		} else {
		tooltip, %totalclicks%
		SetTimer, RemoveToolTip, -2000
		}
	return
RemoveToolTip:
	totalclicks := 0
	ToolTip
	return
timerstop:
	timeron := False
	totalclicks := 0
	guicontrol,disable, tmr
	sleep, 2000
	guicontrol,enable, tmr
	return
Stop:
	guicontrol,enable, str
	stop = True
	guicontrol,disable, stp
	return
Start:
	WinMinimize, A
	guicontrol,enable, stp
	guicontrol,disable, str
	if clicktype1 = Single
		clicktype1 := 1
	if clicktype1 = Double 
		clicktype1 := 2
	if clicktype2 = Single
		clicktype2 := 1
	if clicktype2 = Double 
		clicktype2 := 2
	if clicktype3 = Single
		clicktype3 := 1
	if clicktype3 = Double 
		clicktype3 := 2
	loop{
		if(%stop% = True){
			stop = False
			break
		}
		While GetKeyState(button, "D"){
			mouseclick, left, , , %clicktype1%
			random, x, %MinSleep%, %MaxSleep%
			sleep, %x%
		}
		While GetKeyState(button1, "D"){
			mouseclick, right, , , %clicktype2%
			random, y, %MinSleep1%, %MaxSleep1%
			sleep, %y%
		}
		While GetKeyState(button2, "D"){
			mouseclick, middle, , , %clicktype3%
			random, z, %MinSleep2%, %MaxSleep2%
			sleep, %z%
		}
	}
		return
	return