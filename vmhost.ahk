yOffset := 28

#a::reload

#v::
;WinMove, Hearthstone, , , , 813, 579

LaunchBNet()
ClickHSPlay()
Sleep, 20000
WinActivate, Windows7x64 ; so that bnet windows doesn't cover it up
; accept duel + in game face spam
Loop
{
	IfWinExist, Sponsored session
	{
		WinActivate
		Send, {enter}
		;WinKill
	}
	IfWinNotActive, Hearthstone, , WinActivate, Hearthstone, 
	WinWaitActive, Hearthstone, , 15
	AcceptFriend()
	Loop, 2
	{
	    MouseClick, left, 410, 446 ; click confirm for mulligan
	    Sleep, 100
	}
    MouseClick, left,  405,  342 ; dismiss cancellation notices
    Sleep, 100
	HandToFace()
	MouseClick, left, 70, 292 ; go to decks 1-9 on deck select screen
	Sleep, 100
	DumpHand()
	AcceptChallenge()
	GoFace()
	EndTurn()
	EndTurn()
	ClickChoose()
}
return

#z::
CloseHSandBNet()
return

LaunchBNet() {
    RunWait C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe ; win 7 
    WinWait, Battle.net, 
    IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    WinWaitActive, Battle.net, 
    Sleep, 10000
}

ClickHSPlay() {
    WinWait, Battle.net, 
    IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    WinWaitActive, Battle.net, 
    MouseClick, left,  172,  49 ; select "games" tab
    Sleep, 3000
    MouseClick, left,  45,  419 ; select hearthstone on left bar, 4th entry
    Sleep, 2000
    MouseClick, left,  266,  655 ; click play button
    WinWait, Hearthstone, , 15
    if ErrorLevel {
        ClickHSPlay() ; keep trying until we get it
    }
}

AcceptFriend() {
    MouseClick, left,  30,  558 ; open friends list
    Sleep, 500
    MouseClick, left,  155,  262 ; accept friend request
    Sleep, 500
}

AcceptChallenge() {
	MouseClick, left, 365, 387
}

ClickChoose() { ; for practice mode battles
    MouseClick, left,  638,  491
    Sleep, 2000
}

HandToFace() {
    global yOffset
    Loop, 8 {
        MouseClick, left, 202+45*a_index, 570-yOffset
        Sleep, 100
        MouseClick, left, 408, 109
        Sleep, 100
    }
}

DumpHand() {
    global yOffset
    Loop, 8 {
        MouseClick, left, 202+45*a_index, 570-yOffset
        Sleep, 100
        MouseClick, left, 372+10*a_index, 253
        Sleep, 100
    }
}

GoFace() {
    Loop, 13 {
        MouseClick, left, 58+46*a_index, 324
        Sleep, 100
        MouseClick, left, 408, 109
        Sleep, 100
    }
}

EndTurn() {
    MouseClick, left,  721,  277 ; end turn
    Sleep, 100
}

CloseHSandBNet() {
    IfWinExist, Hearthstone
    {
        WinKill
    }
    Sleep, 10000
    IfWinExist, Battle.net
    {
    	WinKill
    }
    return
}