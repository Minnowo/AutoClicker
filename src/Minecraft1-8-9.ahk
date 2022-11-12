/*

    this is what i use for minecraft 1.8 pvp

*/

#NoEnv  
SendMode Input
#singleinstance, force

setBatchLines -1
SetMouseDelay,-1
SetControlDelay, -1

holdButton := "0"

counter = 1

hotkey, *~$%holdButton%, clickLoop,  on

clickLoop:
    While getkeystate(holdButton, "D") 
    {
        Click, Left
        counter += 1
        if(counter = 8)
        {
            Click, Right
            counter = 0
        }
        sleep, 50
    }
return 