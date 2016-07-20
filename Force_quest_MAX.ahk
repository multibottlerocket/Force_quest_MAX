#r::Reload

#w::
;LaunchBNet()
;LogIn()
;LogOut()
;MakeNewAcct()
;LaunchHS()
;DoTutorial()
;Loop {
;    DumbSpam()
;}
;DoPlayMode()
return

LaunchBNet() {
    RunWait C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe
    WinWait, Battle.net Login, 
    IfWinNotActive, Battle.net Login, , WinActivate, Battle.net Login, 
    WinWaitActive, Battle.net Login, 
    Sleep, 15000
}

LogIn() {
    Send, {SHIFTDOWN}{TAB}{SHIFTUP} ; go up to username input
    FileReadLine, smurfEmail, Z:\Code\Hearthstone\hsSmurfs.txt, 1
    Send, %smurfEmail%@aol.com
    Send, {TAB}password1
    Send, {TAB}{TAB}{TAB}{ENTER}
    Sleep, 15000
}

MakeNewAcct() {
    MouseClick, left,  151,  330 ; click "create new account"
    Sleep, 10000
    WinWait, Battle.net, 
    IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    WinWaitActive, Battle.net, 
    Random, smurfRand, 100000, 999999
    smurfName := "Prisoner" . smurfRand 
    Send, first{TAB}last{TAB}%smurfName%{SHIFTDOWN}2{SHIFTUP}aol.com{TAB}password1{TAB}password1{TAB}{DOWN}{TAB}firstcar{TAB}69{TAB}{SPACE}{TAB}{SPACE}{TAB}{TAB}{ENTER}
    FileAppend, %smurfName%`n, Z:\Code\Hearthstone\hsSmurfs.txt
    Sleep, 5000
    Send, {TAB}{TAB}Prisoner{TAB}{ENTER}
    Sleep, 40000
}

LogOut() {
    ;WinWait, Battle.net, 
    ;IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    ;WinWaitActive, Battle.net, 
    ;MouseClick, left,  75,  56
    ;Sleep, 2000
    ;MouseClick, left,  69,  235
    ;Sleep, 2000
    ;WinClose, Battle.net
    WinKill, Battle.net
    Sleep, 1000
    IfWinExist, ahk_class Qt5QWindowIcon 
    {
        MouseClick, left,  29,  157
        Sleep, 100
        MouseClick, left,  305,  222
        Sleep, 100
    }
    Sleep, 2000
}

LaunchHS() { ; trying to launch from the hs.exe with Run gives a black screen
    WinWait, Battle.net, 
    IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    WinWaitActive, Battle.net, 
    MouseClick, left,  45,  419 ; select hearthstone on left bar, 4th entry
    Sleep, 2000
    ; MouseClick, left,  266,  472 ; click high play button
    MouseClick, left,  266,  518 ; click low play button
    Sleep, 40000
    MouseClick, left,  511,  110 ; dismiss quests
}

DoTutorial() {
    WinWait, Hearthstone,  
    IfWinNotActive, Hearthstone, , WinActivate, Hearthstone, 
    WinWaitActive, Hearthstone, 
}

EndTurn() {
    MouseClick, left,  731,  277 ; end turn
}

DumbSpam() {
    DumpHand()
    ClickChoose()
    Sleep, 1000
    SelectJaina()
    ClickChoose()
    SpamHeroPower()
    GoFace()
    Trade()
    HandToFace()
    Sleep, 1000
    EndTurn()
    Sleep, 1000
    SpamOpponents()
    Sleep, 25000
}

DumpHand() {
        Loop, 8 {
            MouseClick, left, 202+45*a_index, 580
            Sleep, 100
            MouseClick, left, 372+10*a_index, 230
            Sleep, 100
        }
        Loop, 8 {
            MouseClick, left, 202+45*a_index, 580
            Sleep, 100
            MouseClick, left, 452-10*a_index, 230
            Sleep, 100
        }
}

SpamHeroPower() {
    MouseClick, left,  503,  460
    Sleep, 200
    MouseClick, left,  352,  215
    Sleep, 100
    MouseClick, left,  401,  221
    Sleep, 100
    MouseClick, left,  467,  216
    Sleep, 100
    MouseClick, left,  408,  106
    Sleep, 100
}

Trade() {
        Loop, 8 {
            MouseClick, left, 232+30*a_index, 318
            Sleep, 100
            Loop, 8 {
                ;MouseClick, left, 300+30*a_index, 214
                MouseClick, left, 540-30*a_index, 214
                Sleep, 20
            }
            MouseClick, left, 408, 109
        } 
}

GoFace() {
    Loop, 8 {
        MouseClick, left, 232+40*a_index, 318
        Sleep, 100
        MouseClick, left, 408, 109
        Sleep, 100
    }
}

SpamOpponents() {
    MouseClick, left,  164,  436
    Sleep, 100
    MouseClick, left,  241,  441
    Sleep, 100
    MouseClick, left,  355,  424
    Sleep, 100
    MouseClick, left,  439,  443
    Sleep, 100
    MouseClick, left,  526,  443
    Sleep, 100
    MouseClick, left,  634,  443
    Sleep, 100
}

HandToFace() {
        Loop, 8 {
            MouseClick, left, 202+45*a_index, 580
            Sleep, 100
            MouseClick, left, 408, 109
            Sleep, 100
        }
}

ClickChoose() { ; for practice mode battles
    MouseClick, left,  638,  491
    Sleep, 2000
}

SelectJaina() {
    MouseClick, left,  277,  407
    Sleep, 2000
}

DoPlayMode() {
    MouseClick, left,  370,  184 ; go to play mode
    Sleep, 5000
    Loop, 4 { ; need to do 4 play games to get rid of quests
        ClickChoose() ; this is also where the Play button is
        Sleep, 60000 ; wait a long time for matchmaking
        Concede()
        DismissQuests()
    }
}

Concede() {
    MouseClick, left,  784,  590 ; click menu gear
    Sleep, 2000
    MouseClick, left,  429,  215 ; click "concede" Button
    Sleep, 7000 ; let hero blow up
}

DismissQuests() {
    MouseClick, left,  511,  91 ; dismiss exp screen
    Sleep, 5000
    MouseClick, left,  511,  100 ; dismiss completed quest
    Sleep, 5000
    MouseClick, left,  511,  110 ; dismiss new quest
    Sleep, 5000
}

RollForFriendQuest() {
    MouseClick, left,  162,  529 ; click quest button
    Sleep, 3000
    MouseClick, left,  449,  415 ; re-roll middle quest
    Sleep, 3000
    CheckForFriendQuest(username)
}

CheckForFriendQuest(username) {
    ; check if middle quest is now 80g friend quest
    ; if it Is
        ; log this username as having the quest
    ; log out
}