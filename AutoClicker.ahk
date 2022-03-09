/*	;Notes
	Written By: Minnowo 
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

Gui, 1:Add, CheckBox, x10 y0 vAlways Checked gAlways_On_Top, AlwaysOnTop
Gui, 1:Add, CheckBox, x+10 y0 vHide_On_Start gHide_When_Started, HideOnStart
Gui, 1:Add, CheckBox, x+10 y0 vghost_mode gghost_mode, GhostOptions
Gui, 1:Add, CheckBox, x+10 y0 vtoggle gToggle, Toggle
Gui, 1:add, text, x+10 y0, Ctrl+P Pause
Gui, 1:add, text, x+10 y0, Ctrl+Esc Exit

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
Gui, 1:add, button, x0 ym+120 w25 h20 gseconds1, 1s
Gui, 1:add, button, x+0 ym+120 w25 h20 gseconds5, 5s

widthspawn := A_screenwidth-548
heightspawn:= A_screenheight-652
;Gui, 1:show, x%widthspawn% y%heightspawn% w500 h169, AutoClicker - By Minnowo
Gui, 1:show, w500 h169, AutoClicker - By Minnowo
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
global ghost_window_height := 130
global stop
stop := False
keep_looping := 1
keep_looping1 := 1
keep_looping2 := 1
timeron := False
hotkey, ^h, hide_win_hotkey,  on
hotkey, ^o, run_background_hotkey,  on
hidewin := 1
background_hotkey := 1
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
		Gui,2:add,Edit,xm+80 ym+1 w220 h21  vTarget_Window , % Target_Window
		Gui,2:add,Edit,xm+80 ym+30 w100 h21  vPos_1 , %X_1%   %Y_1% 
		gui,2:add, button, x10 ym+0 gset_window, Set Window
		gui,2:add, button, x10 ym+30 w70 gset_pos, Set Pos
		Gui,2:add,Button,xm+319 ym+0 w61 gUpdate_Window,Update
		Gui,2:add,Button,xm+380 ym+0 w61 gClear_Target_Window,Clear
		Gui,2:add,Button,xm+199 ym+30 w122 gClear_Pos,Clear
		Gui,2:add,Button,xm+0 ym+90 w122 gHide_Window,Hide/Show Window
		if (hidewin == 1){
			Gui,2:add, checkbox, x11 ym+65 checked vhidewin gHide_Window_Hotkey, Ctrl+H Show/HideWindow
		} else {
			Gui,2:add, checkbox, x10 ym+65 vhidewin gHide_Window_Hotkey, Ctrl+H Show/HideWindow
		}
		if (background_hotkey == 1){
			Gui,2:add, checkbox, x+10 ym+65 checked vbackground_hotkey gRun_As_Background, Ctrl+O RunAsBackground
		} else {
			Gui,2:add, checkbox, x+10 ym+65 vbackground_hotkey gRun_As_Background, Ctrl+O RunAsBackground
		}
		if (ghost_clicking == 1){
			Gui,2:add, checkbox, x+10 ym+65 checked vghost_clicking gGhost_Clicking_Toggle, EnableGhostClicking
		} else {
			Gui,2:add, checkbox, x+10 ym+65 vghost_clicking gGhost_Clicking_Toggle, EnableGhostClicking
		}
		gui, 2:add, text,xm+132 ym+95, You Must Set A Window And Position For Ghost Clicking To Work
		gui,2:show, % "x" x1+ghost_window_offsetx "y" y1+ghost_window_offsety "w"+ghost_window_width "h"+ ghost_window_height, Super Secret Ghost Window Very Stealth TeeHee
		;ghost_mode_active := True
		}
	if(ghost_mode==0)
		gui,2:Destroy
		
	return
set_pos:
    Get_Click_Pos(X_1,Y_1)       
    GuiControl,,Pos_1,%X_1%   %Y_1%  
    return
Run_As_Background:
	Gui, 2:Submit, NoHide 
	if (background_hotkey == 1){
		hotkey, ^o, run_background_hotkey,  on
	}
	if (background_hotkey == 0){
		hotkey, ^o, run_background_hotkey,  off
	}
	return
run_background_hotkey:
	WinGet, Style, Style,  AutoClicker - By Minnowo 
	If (Style & 0x10000000){
		WinHide, AutoClicker - By Minnowo
		ifwinexist, Super Secret Ghost Window Very Stealth TeeHee 
		{
			WinHide, Super Secret Ghost Window Very Stealth TeeHee
		}				
	} else {
		WinShow, AutoClicker - By Minnowo
		ifwinexist, Super Secret Ghost Window Very Stealth TeeHee 
		{
			WinShow, Super Secret Ghost Window Very Stealth TeeHee
		}
	}
	
Ghost_Clicking_Toggle:
	Gui, 2:Submit, NoHide 
    return
Hide_Window:
	WinGet, Style, Style,  %Target_Window% 
	a = AutoClicker - By Minnowo
	if (Target_Window = a){
		If (Style & 0x10000000){
			if(Target_Window!=null)
				WinHide,%Target_Window%
				ifwinexist, Super Secret Ghost Window Very Stealth TeeHee 
				{
					WinHide, Super Secret Ghost Window Very Stealth TeeHee
				}
		} else {
			if(Target_Window!=null)
				WinShow,%Target_Window%
				ifwinexist, Super Secret Ghost Window Very Stealth TeeHee 
				{
					WinShow, Super Secret Ghost Window Very Stealth TeeHee
				}
		}
	} else {
		WinGet, Style, Style,  %Target_Window%
		If (Style & 0x10000000){
			if(Target_Window!=null)
				WinHide,%Target_Window%
		} else {
			if(Target_Window!=null)
				WinShow,%Target_Window%
		}
	}
	return
Hide_Window_Hotkey:
	Gui, 2:Submit, NoHide
	if (hidewin == 1){
		hotkey, ^h, hide_win_hotkey,  on
	}
	if (hidewin == 0){
		hotkey, ^h, hide_win_hotkey,  off
	}
	return
hide_win_hotkey:
	WinGet, Style, Style,  %Target_Window% 
	a = AutoClicker - By Minnowo
	if (Target_Window = a){
		If (Style & 0x10000000){
			if(Target_Window!=null)
				WinHide,%Target_Window%
				WinHide, Super Secret Ghost Window Very Stealth TeeHee
		} else {
			if(Target_Window!=null)
				WinShow,%Target_Window%
				WinShow, Super Secret Ghost Window Very Stealth TeeHee
		}
	} else {
		WinGet, Style, Style,  %Target_Window%
		If (Style & 0x10000000){
			if(Target_Window!=null)
				WinHide,%Target_Window%
		} else {
			if(Target_Window!=null)
				WinShow,%Target_Window%
		}
	}
	
	return
Toggle:
	Gui,1:Submit,NoHide
	return
Update_Window:
    Gui,Submit,NoHide
    return
Clear_Target_Window:
	Gui,2:Submit,NoHide
	Target_Window := null 
	guicontrol,, Target_Window, % Target_Window
	return
Clear_Pos:
	Gui,2:Submit,NoHide
	X_1 := null 
	Y_1 := null
	guicontrol,, Pos_1, %X_1%   %Y_1%  
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
	guicontrol,1:enable, ghost_mode
	stop = True
	if button = Left
		button = LButton
	if button = Right
		button = RButton
	if button = Middle
		button = MButton
	if button1 = Left
		button1 = LButton
	if button1 = Right
		button1 = RButton
	if button1 = Middle
		button1 = MButton
	if button2 = Left
		button2 = LButton
	if button2 = Right
		button2 = RButton
	if button2 = Middle
		button2 = MButton
	if button != None
		hotkey, *$%button%, buttonhotkey, *~$ off
	if button1 != None
		hotkey, *$%button1%, buttonhotkey1, *~$ off
	if button2 != None
		hotkey, *$%button2%, buttonhotkey2, *~$ off
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
	guicontrol,1:disable, ghost_mode
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
	if button = Left
		button = LButton
	if button = Right
		button = RButton
	if button = Middle
		button = MButton
	if button1 = Left
		button1 = LButton
	if button1 = Right
		button1 = RButton
	if button1 = Middle
		button1 = MButton
	if button2 = Left
		button2 = LButton
	if button2 = Right
		button2 = RButton
	if button2 = Middle
		button2 = MButton
	if button != None
		hotkey, *$%button%, buttonhotkey,  on
	if button1 != None
		hotkey, *$%button1%, buttonhotkey1,  on
	if button2 != None
		hotkey, *$%button2%, buttonhotkey2,  on

	buttonhotkey:
		global stop
		if (toggle == 0){
			if (ghost_clicking == 1){
				While GetKeyState(button, "P"){
					ControlClick,x%X_1% y%Y_1%,%Target_Window%,,LEFT,%clicktype1%, NA x%X_1% y%Y_1%
					random, x, %MinSleep%, %MaxSleep%
					sleep, %x%
				}
			} else {
				While GetKeyState(button, "P"){
					mouseclick, left, , , %clicktype1%
					random, x, %MinSleep%, %MaxSleep%
					sleep, %x%
				}
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
			if (ghost_clicking = 1){
				while (keep_looping == 1 && stop == False)
				{
					ControlClick,x%X_1% y%Y_1%,%Target_Window%,,LEFT,%clicktype1%, NA x%X_1% y%Y_1%
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
			} else {
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
		}
		return
	buttonhotkey1:
		global stop
		if (toggle == 0){
			if (ghost_clicking = 1){
				While GetKeyState(button1, "P"){
					ControlClick,x%X_1% y%Y_1%,%Target_Window%,,RIGHT,%clicktype2%, NA x%X_1% y%Y_1%
					random, y, %MinSleep1%, %MaxSleep1%
					sleep, %y%
				}
			} else {
				While GetKeyState(button1, "P"){
					mouseclick, right, , , %clicktype2%
					random, y, %MinSleep1%, %MaxSleep1%
					sleep, %y%
				}
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
			if (ghost_clicking = 1){
				while (keep_looping1 == 1 && stop == False)
				{
					ControlClick,x%X_1% y%Y_1%,%Target_Window%,,RIGHT,%clicktype2%, NA x%X_1% y%Y_1%
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
			} else {
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
		}
		return
	buttonhotkey2:
		global stop
		if (toggle == 0){
			if (ghost_clicking = 1){
				While GetKeyState(button2, "P"){
					ControlClick,x%X_1% y%Y_1%,%Target_Window%,,MIDDLE,%clicktype3%, NA x%X_1% y%Y_1%
					random, z, %MinSleep2%, %MaxSleep2%
					sleep, %z%
				}
			} else {
				While GetKeyState(button2, "P"){
					mouseclick, middle, , , %clicktype3%
					random, z, %MinSleep2%, %MaxSleep2%
					sleep, %z%
				}
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
			if (ghost_clicking = 1){
				while (keep_looping2 == 1 && stop == False)
				{
					ControlClick,x%X_1% y%Y_1%,%Target_Window%,,MIDDLE,%clicktype3%, NA x%X_1% y%Y_1%
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
			} else {
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
		}
		return
Get_Click_Pos(ByRef X,ByRef Y)
    {
	Pressed:=0
	Loop
	{
		Left_Mouse := GetKeyState("LButton")
		MouseGetPos,X,Y,
		ToolTip, Select click position
		if(Left_Mouse == False && Pressed == 0)
			Pressed:=1
		else if(Left_Mouse == True && Pressed == 1)
		{
			MouseGetPos,X,Y,
			ToolTip,
			break
		}
		sleep, 25
	}
}  
Set_Window(Target_Window)
{
	Pressed :=0
	i1 := 0
	loop, {
		tooltip, Double click a window to select
		Left_Mouse := GetKeyState("LButton")
		if(Left_Mouse==False && Pressed==0)
			Pressed:=1
		else if(Left_Mouse==True && Pressed==1)
		{
			i1++
			Pressed:=0
			if(i1>=2)
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
		ifwinexist, Super Secret Ghost Window Very Stealth TeeHee
			{	
				wingetpos, x1, y1, , ,A 
				x2 :=x1 + ghost_window_offsetx
				y2 :=y1 + ghost_window_offsety 
				gui,2:show, % "x" + x2 "y" + y2

			}
}

;^p::Pause
^p::
	suspend, toggle
	pause, toggle
	return
^esc::exitapp
