/*	;Notes
	Written By: Minnowo 
	Discord: https://discord.gg/Y6us9tk
	Date Started: May 19th, 2020
	Date Of Last Edit: May 24th, 2020
	Description: This is an on hold autoclicker maximum click speed is ~2400cps
				activation hotkeys are mouse only at current time 
				will add a toggle
	*/
#singleinstance, force
setBatchLines -1
SetMouseDelay,-1
SetControlDelay, -1
DetectHiddenWindows On
Coordmode,Mouse,Client
SetTitleMatchMode, 2
#MaxThreadsPerHotkey 2

onmessage(0x232, "move_ghost_window")
Target_Window:=null
Gui, +alwaysontop
Gui, 1:add, text, x10 y20 , Mouse Button
Gui, 1:add, text, x90 y20 , Hold Button
Gui, 1:add, text, x210 y20 , Click Type
Gui, 1:add, text, x330 y20 , Min Delay
Gui, 1:add, text, x400 y20 , Max Delay
Gui, 1:add, text, x52 y40 , Left :
Gui, 1:add, text, x45 y+17,  Right :
Gui, 1:add, text, x39 y+17,  Middle :

Gui, 1:Add, CheckBox, x10 y0 vAlways Checked gAlways_On_Top, Always On Top
Gui, 1:Add, CheckBox, x+10 y0 vHide_On_Start gHide_When_Started, Hide When Started
Gui, 1:Add, CheckBox, x+10 y0 vghost_mode gghost_mode, Ghost Mode
Gui, 1:Add, CheckBox, x+10 y0 vtoggle gToggle, Toggle
Gui, 1:add, text, x+10 y0, Ctrl+P : Pause
Gui, 1:add, text, x+10 y0, Ctrl+Esc : Exit

Gui, 1:add, dropdownlist, xm+80 ym+30 w100 r10 vButton gFirstButton, None||Left|Right|Middle|xButton1|xButton2|
Gui, 1:add, dropdownlist, xm+80 ym+60 w100 r10 vButton1 gSecondButton, None||Left|Right|Middle|xButton1|xButton2|
Gui, 1:add, dropdownlist, xm+80 ym+90 w100 r10 vButton2 gThirdButton, None||Left|Right|Middle|xButton1|xButton2|
Gui, 1:add, dropdownlist, xm+200 ym+30 w100 r10 vClicktype1 gFirstButtonclicktype, Single||Double|
Gui, 1:add, dropdownlist, xm+200 ym+60 w100 r10 vClicktype2 gSecondButtonclicktype, Single||Double|
Gui, 1:add, dropdownlist, xm+200 ym+90 w100 r10 vClicktype3 gThirdButtonclicktype, Single||Double|

Gui, 1:add, edit, xm+320 ym+30 w50 vMinSleep gMinSleep Number, 
Gui, 1:Add, UpDown, Range0-1000, 30
Gui, 1:add, edit, xm+390 ym+30  w50 vMaxSleep gMaxSleep Number, 
Gui, 1:Add, UpDown, Range0-1000,60
Gui, 1:add, edit, xm+320 ym+60 w50 vMinSleep1 gMinSleep1 Number, 
Gui, 1:Add, UpDown, Range0-1000, 30
Gui, 1:add, edit, xm+390 ym+60  w50 vMaxSleep1 gMaxSleep1 Number, 
Gui, 1:Add, UpDown, Range0-1000,60
Gui, 1:add, edit, xm+320 ym+90 w50 vMinSleep2 gMinSleep2 Number, 
Gui, 1:Add, UpDown, Range0-1000, 30
Gui, 1:add, edit, xm+390 ym+90  w50 vMaxSleep2 gMaxSleep2 Number, 
Gui, 1:Add, UpDown, Range0-1000,60
 
Gui, 1:add, button, xm+79  ym+129 w102 vstr gStart,  Start
Gui, 1:add, button, xm+199  ym+129 w102 vstp gStop, Stop
Gui, 1:add, button, xm+319  ym+129  w122 gReload, Reload
Gui, 1:add, button, x0 ym+140   vtmr gonclick, click me
Gui, 1:add, button, x0 ym+120 w25 gseconds1, 1s
Gui, 1:add, button, x+0 ym+120 w25 gseconds5, 5s

widthspawn := A_screenwidth-548
heightspawn:= A_screenheight-652
Gui, 1:show, x%widthspawn% y%heightspawn% w500 h169, AutoClicker
guicontrol,1:disable, stp
guicontrol,1:disable, tmr
clicktype1 = 1
clicktype2 = 1
clicktype3 = 1
Clicktype4 = 1
loop_Clicker = 0
global ghost_window_offsetx := 3
global ghost_window_offsety := 195
global ghost_window_width := 500
global ghost_window_height := 169
global stop
stop := False
keep_looping := 1
keep_looping1 := 1
keep_looping2 := 1
timeron := False

return

GuiClose:
	Exitapp
	return
Reload:
    Reload
set_window:
	Target_Window:=Set_Window(Target_Window)
    GuiControl,,Target_Window,% Target_Window 
	return
Always_On_Top:         
	Gui, 1:Submit, NoHide
	if(Always==1)
			Gui, 1:+AlwaysOnTop
	if(Always==0)
			Gui, 1:-AlwaysOnTop
	return
Hide_When_Started:
	Gui, 1:Submit, NoHide
	return
ghost_mode:
	Gui, 1:Submit, NoHide
	if(ghost_mode==1){
		gui,2:Destroy 
		wingetpos, x1, y1, , , A 
		gui,2:+alwaysontop -caption +owner1
		gui,2:add, button, x10 ym+0 gset_window, set window
		Gui,2:add,Edit,x+10 w200 vTarget_Window ,% Target_Window
		Gui,2:add,Button,x+10 gUpdate_Window,Update
		gui,2:show, % "x" x1+ghost_window_offsetx "y" y1+ghost_window_offsety "w"+ghost_window_width "h"+ ghost_window_height, Ghost Window
		ghost_mode_active := True
		}
	if(ghost_mode==0)
		gui,2:Destroy
		ghost_mode_active := False
	return
Toggle:
	Gui,1:Submit,NoHide
	return
Update_Window:
    Gui,Submit,NoHide
    return
MinSleep:
	gui, 1:submit, nohide
	MinSleep = % MinSleep
	return
MaxSleep:
	gui, 1:submit, nohide
	MaxSleep = % MaxSleep
	return
MinSleep1:
	gui, 1:submit, nohide
	MinSleep1 = % MinSleep1
	return
MaxSleep1:
	gui, 1:submit, nohide
	MaxSleep1 = % MaxSleep1
	return
MinSleep2:
	gui, 1:submit, nohide
	MinSleep2 = % MinSleep2
	return
MaxSleep2:
	gui, 1:submit, nohide
	MaxSleep2 = % MaxSleep2
	return

FirstButton:
	gui, 1:submit, nohide
	button =  % Button
	if button = Left
		button = LButton
	if button = Right
		button = RButton
	if button = Middle
		button = MButton
	
	return
	
SecondButton:
	gui, 1:submit, nohide
	button1 = % Button1
	if button1 = Left
		button1 = LButton
	if button1 = Right
		button1 = RButton
	if button1 = Middle
		button1 = MButton
	return
ThirdButton:
	gui, 1:submit, nohide
	button2 = % Button2
	if button2 = Left
		button2 = LButton
	if button2 = Right
		button2 = RButton
	if button2 = Middle
		button2 = MButton
	return

FirstButtonclicktype:
	gui, 1:submit, nohide
	clicktype1 := % Clicktype1
	if clicktype1 = Single
		clicktype1 := 1
	if clicktype1 = Double 
		clicktype1 := 2
	return
SecondButtonclicktype:
	gui, 1:submit, nohide
	clicktype2 = % Clicktype2
	if clicktype2 = Single
		clicktype2 := 1
	if clicktype2 = Double 
		clicktype2 := 2
	return
ThirdButtonclicktype:
	gui, 1:submit, nohide
	clicktype3 = % Clicktype3
	if clicktype3 = Single
		clicktype3 := 1
	if clicktype3 = Double 
		clicktype3 := 2
	return

seconds1:
	guicontrol,1:enable, tmr
	time := -1000
	second5 := False
	second1 := True
	return
seconds5:
	guicontrol,1:enable, tmr
	time := -5000
	second5 := True
	second1 := False
	return
onclick:
	totalclicks += 1
	if (timeron = False){
		;tooltip, start timer
		SetTimer, timerstop, %time%
		timeron := True
		}
	return
RemoveToolTip:
	totalclicks := 0
	ToolTip
	return

timerstop:
	;tooltip, %second1% %second5%
	guicontrol,1:disable, tmr
	if(Always==1)
		alwaystop := 262144
	if(Always==0)
		alwaystop := 0
	stop := True
	suspend, on
	if second1 = 1
		msgbox, % alwaystop ,Hotkeys are suspended while this is open, % totalclicks " Clicks/Second", 10
	if second5 = 1
		msgbox, % alwaystop ,Hotkeys are suspended while this is open, % totalclicks " Clicks In 5 Seconds Or " totalclicks // 5 " CPS", 10
	suspend, off
	stop := False
	timeron := False
	totalclicks := 0
	guicontrol,1:enable, tmr
	return
Stop:
	guicontrol,1:enable, str
	guicontrol,1:enable, button
	guicontrol,1:enable, button1
	guicontrol,1:enable, button2
	guicontrol,1:enable, MinSleep
	guicontrol,1:enable, MaxSleep
	guicontrol,1:enable, MinSleep1
	guicontrol,1:enable, MaxSleep1
	guicontrol,1:enable, MinSleep2
	guicontrol,1:enable, MaxSleep2
	guicontrol,1:enable, toggle

	stop = True
	if button != None
		hotkey, *~$%button%, buttonhotkey, *~$ off
	if button1 != None
		hotkey, *~$%button1%, buttonhotkey1, *~$ off
	if button2 != None
		hotkey, *~$%button2%, buttonhotkey2, *~$ off
	guicontrol,1:disable, stp
	return

Start:
	global stop
	stop := False
	keep_looping := 1
	keep_looping1 := 1
	keep_looping2 := 1
	;WinMinimize, A
	guicontrol,1:enable, stp
	guicontrol,1:disable, str
	guicontrol,1:disable, button
	guicontrol,1:disable, button1
	guicontrol,1:disable, button2
	guicontrol,1:disable, MinSleep
	guicontrol,1:disable, MaxSleep
	guicontrol,1:disable, MinSleep1
	guicontrol,1:disable, MaxSleep1
	guicontrol,1:disable, MinSleep2
	guicontrol,1:disable, MaxSleep2
	guicontrol,1:disable, toggle
	if(Hide_On_Start==1)
		WinMinimize, A
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
	if button != None
		hotkey, *~$%button%, buttonhotkey,  on
	if button1 != None
		hotkey, *~$%button1%, buttonhotkey1,  on
	if button2 != None
		hotkey, *~$%button2%, buttonhotkey2,  on

	buttonhotkey:
		global stop
		if (toggle == 0){
			While GetKeyState(button, "P"){
				mouseclick, left, , , %clicktype1%
				random, x, %MinSleep%, %MaxSleep%
				sleep, %x%
			}
		} 
		else if (toggle == 1){
			keep_looping = %keep_looping%
			stop := %stop%
			up := False
			if (keep_looping == 0){
					keep_looping := 1
				}
			else {
				keep_looping := 0
				}
			while (keep_looping == 1 && stop == False)
			{
				mouseclick, left, , , %clicktype1%
				random, x, %MinSleep%, %MaxSleep%
				sleep, %x%
				getkeystate, state, %button%
				if (state == "D" && up == True){
					keep_looping := 0
					sleep, 1000
				}
				if (state == "U"){
					up := True
				}
			}
		}
		return
	buttonhotkey1:
		global stop
		if (toggle == 0){
			While GetKeyState(button1, "P"){
				mouseclick, right, , , %clicktype2%
				random, y, %MinSleep1%, %MaxSleep1%
				sleep, %y%
			}
		}
		else if (toggle == 1){
			keep_looping1 = %keep_looping1%
			stop := %stop%
			up1 := False
			if (keep_looping1 == 0){
					keep_looping1 := 1
				}
			else {
				keep_looping1 := 0
				}
			while (keep_looping1 == 1 && stop == False)
			{
				mouseclick, right, , , %clicktype2%
				random, y, %MinSleep1%, %MaxSleep1%
				sleep, %y%
				getkeystate, state1, %button1%
				if (state1 == "D" && up == True){
					keep_looping1 := 0
					sleep, 1000
				}
				if (state1 == "U"){
					up1 := True
				}
			}
		}
		return
	buttonhotkey2:
		global stop
		if (toggle == 0){
			While GetKeyState(button2, "P"){
				mouseclick, middle, , , %clicktype3%
				random, z, %MinSleep2%, %MaxSleep2%
				sleep, %z%
			}
		}
		else if (toggle == 1){
			keep_looping2 = %keep_looping2%
			stop := %stop%
			up2 := False
			if (keep_looping2 == 0){
					keep_looping2 := 1
				}
			else {
				keep_looping2 := 0
				}
			while (keep_looping2 == 1 && stop == False)
			{
				mouseclick, middle, , , %clicktype3%
				random, z, %MinSleep2%, %MaxSleep2%
				sleep, %z%
				getkeystate, state2, %button2%
				if (state2 == "D" && up == True){
					keep_looping2 := 0
					sleep, 1000
				}
				if (state2 == "U"){
					up2 := True
				}
			}
		}
		return
Set_Window(Target_Window)
{
	isPressed :=0
	i := 0
	loop, {
		tooltip, Double click a window to select
		Left_Mouse:=GetKeyState("LButton")
		if(Left_Mouse==False&&isPressed==0)
			isPressed:=1
		else if(Left_Mouse==True&&isPressed==1)
		{
			i++,isPressed:=0
			if(i>=2)
			{
				WinGetTitle,Target_Window,A
				ToolTip
				break
			}
		}
		sleep, 25
	}
	return Target_Window   
}
move_ghost_window()
	{
		ifwinexist, Ghost Window
			{	
				wingetpos, x1, y1, , ,A 
				x2 :=x1 + ghost_window_offsetx
				y2 :=y1 + ghost_window_offsety 
				gui,2:show, % "x" + x2 "y" + y2

			}
}

;^p::Pause
^p::Suspend
^esc::exitapp