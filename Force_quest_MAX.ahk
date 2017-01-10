#Include tf.ahk
#Include screencap.ahk

xOffset := 15
yOffset := 28
questingSmurfs = \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\questingSmurfs.txt
rerollSmurfs = \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\rerollSmurfs.txt
;rerollSmurfs = \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\testSmurfs.txt
friendSmurfs = \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\friendSmurfs.txt
premades = \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\premades.txt
transfers = \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\transfers.txt
;friend = bottlerocket#1956
friend = kap#1187
;friend = hroll#1490
;friend = yoyotimes5#1868

#a::Reload

#z::
Loop, {
    if IsNextDay()
    {
        DoAllRerolls(rerollSmurfs)
        UpdateRerollDate()
    }
    else
    {
        if NeedMoreQuesters()
        {
            if PremadeSmurfsReady(premades)
            {
                MoveFromAToB(premades, questingSmurfs)
            }
            else
            {
                MakeSmurfHearthRanger()
            }
        }
        DoQuestHearthRanger()
    }
}
return

#x::
;ProcessTransfers(transfers, premades)
;MoveFromAToB(premades, questingSmurfs)
if HasArenaQuest() 
{
    MsgBox, has arena
}
else
{
    MsgBox, no arena
}
return

#v::
;CaptureScreen()
;HasFriendQuest()
;RemoveFriend()
;AddFriend()
;FriendDuelSpam()
;DoReroll()
Loop, 2
{
CashInFriendQuest()
}
return

ProcessTransfers(transfers, premades) {
    Loop, Read, %transfers%
    {
        total_lines = %A_Index%
    }
    Loop, %total_lines% {
        LaunchBNet(10000)
        last := TF_Tail("!" . transfers, -1)
        StringSplit, split1, last, %A_Space%
        LogIn(split11)
        MsgBox, input code, then close this
        MoveFromAToB(transfers, premades)
        LogOut()
    }
}

PremadeSmurfsReady(premades) {
    Loop, Read, %premades%
    {
        total_lines = %A_Index%
    }
    if total_lines > 1
    {
        return true
    }
    else
    {
        return false
    }
}

DoAllRerolls(rerollSmurfs) {
    Loop, Read, %rerollSmurfs%
    {
        total_lines = %A_Index%
    }
    Loop, %total_lines% {
        DoReroll()
    }
}

IsNextDay() {
    diff = %A_Now%
    FileReadLine, lastReroll, C:\lastReroll.txt, 1
    diff -= %lastReroll%, days
    if diff > 0
    {
        return true
    }
    else
    {
        return false
    }
}

UpdateRerollDate() {
    now = %A_Now%
    day := SubStr(now, 1, 8)
    TF_ReplaceLine("!" . "C:\lastReroll.txt", "1", "1", day)
}

; waitTime of 15000 for safe and 10000 for tight, fast, supervised loops
LaunchBNet(waitTime) {
    ;RunWait C:\Program Files\Battle.net\Battle.net Launcher.exe ; tiny xp
    RunWait C:\Program Files (x86)\Battle.net\Battle.net Launcher.exe ; win 7 
    WinWait, Battle.net Login, 
    IfWinNotActive, Battle.net Login, , WinActivate, Battle.net Login, 
    WinWaitActive, Battle.net Login, 
    ;Sleep, 15000
    Sleep, %waitTime%
}

ResumeSmurf() {
    FileReadLine, smurfEmail, C:\currentHsSmurf.txt, 1
    ;MsgBox, %smurfEmail%
    if ErrorLevel ; currentHsSmurf.txt does not exist, so create it
    {
        FileAppend, None, C:\currentHsSmurf.txt
        FileAppend, `nNone, C:\currentHsSmurf.txt
        smurfEmail = None
    }
    if (smurfEmail = "None") ; make new smurf
    {
        MakeNewAcct()
        return
    }
    else ; if currentHsSmurf.txt is populated, resume where we left off
    {
        LogIn(smurfEmail)
    }
}

QuestingLogIn() {
    global questingSmurfs
    FileReadLine, smurfEmail, %questingSmurfs%, 1
    FileAppend, %smurfEmail%`n, %questingSmurfs%
    TF_RemoveLines("!" . questingSmurfs, 1, 1)
    StringSplit, questArray, smurfEmail, %A_Space%
    LogIn(questArray1)
}

NeedMoreQuesters() {
    global questingSmurfs
    Loop, Read, %questingSmurfs%
    {
        total_lines = %A_Index%
    }
    if total_lines < 16
    {
        return true
    }
    else
    {
        return false
    }
}

RerollLogIn() {
    global rerollSmurfs
    FileReadLine, smurfEmail, %rerollSmurfs%, 1
    FileAppend, %smurfEmail%`n, %rerollSmurfs%
    TF_RemoveLines("!" . rerollSmurfs, 1, 1)
    LogIn(smurfEmail)
    return smurfEmail
}

LogIn(smurfEmail) {
    Send, {SHIFTDOWN}{TAB}{SHIFTUP} ; go up to username input
    Send, samsungpackman{+}%smurfEmail%@gmail.com
    ;Send, %smurfEmail%@aol.com
    Send, {TAB}password1
    Send, {TAB}{TAB}{TAB}{ENTER}
    Sleep, 15000
}

MakeNewAcct() {
    MouseClick, left,  151, 405 ; click "create new account"
    Sleep, 10000
    WinWait, Battle.net, 
    IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    WinWaitActive, Battle.net, 
    Random, smurfRand, 100000, 999999
    smurfName := "Prisoner" . smurfRand 
    SetKeyDelay, 100
    Send, first{TAB}last{TAB}samsungpackman{+}%smurfName%{SHIFTDOWN}2{SHIFTUP}gmail.com{TAB}samsungpackman{+}%smurfName%{SHIFTDOWN}2{SHIFTUP}gmail.com{TAB}password1{TAB}password1{TAB}{DOWN}{TAB}firstcar{TAB}69{TAB}{SPACE}{TAB}{SPACE}{TAB}{TAB}{ENTER}
    SetKeyDelay, 10
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "1", "1", smurfName)
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "2", "2", "tutorial")
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
    IfWinExist, Battle.net
    {
        MouseClick, left,  29,  157
        Sleep, 100
        MouseClick, left,  305,  222
        LogOut()
    }
}

ClickHSPlay() {
    WinWait, Battle.net, 
    IfWinNotActive, Battle.net, , WinActivate, Battle.net, 
    WinWaitActive, Battle.net, 
    MouseClick, left,  172,  49 ; select "games" tab
    Sleep, 3000
    MouseClick, left,  45,  419 ; select hearthstone on left bar, 4th entry
    Sleep, 2000
    ; MouseClick, left,  266,  472 ; click high play button
    MouseClick, left,  266,  518 ; click low play button
    WinWait, Hearthstone, , 15
    if ErrorLevel {
        ClickHSPlay() ; keep trying until we get it
    }
}

LaunchHS() { ; trying to launch from the hs.exe with Run gives a black screen
    ClickHSPlay()
    IfWinNotActive, Hearthstone, , WinActivate, Hearthstone, 
    WinWaitActive, Hearthstone, , 15
    if ErrorLevel {
        ClickHSPlay() ; keep trying until we get it
    }
    Sleep, 30000
    WinMaximize
    MouseClick, left,  405,  355 ; dismiss quests/DC notification
    Sleep, 5000
    MouseClick, left,  405,  355 ; dismiss quests
    Sleep, 5000
    IfWinNotExist, Hearthstone 
    {
        LaunchHS()
    }
}

CloseHS() {
    Concede() ; otherwise it will reconnect us to our game
    IfWinExist, Hearthstone
    {
        WinKill
    }
    Sleep, 10000
    return
}

BringUpSmurf() {
    LaunchHS()
    DoTutorial()
    CloseHS()
    LaunchHS()
    ;MakePracticeDeck()
    MakeHearthrangerPracticeDeck()
    DoPracticeGamesHearthranger()
    CloseHS()
    LaunchHS()
    DoPlayMode()
    ; smurf is now ready to do 10 daily quests - add to questing smurfs
    FileReadLine, smurfEmail, C:\currentHsSmurf.txt, 1
    FileAppend, %smurfEmail% 0`n, \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\questingSmurfs.txt
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "1", "1", "None")
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "2", "2", "None")
    CloseHS()
    LogOut()
}

DoTutorial() {
    WinWait, Hearthstone,  
    IfWinNotActive, Hearthstone, , WinActivate, Hearthstone, 
    WinWaitActive, Hearthstone, 
    Loop, 78 { 
    ;Loop, 15 { 
        DumbSpam()
        IfWinNotExist, Hearthstone ; re-launch HS if it crashes and run for longer
        {
            LaunchHS()
            Loop, 13 {
                DumbSpam()
            }
        }
        IfWinExist, Oops!
        {
            IfWinNotActive, Oops!, , WinActivate, Oops!, 
            WinWaitActive, Oops!, 
            Sleep, 2000
            MouseClick, left,  183,  102
            Sleep, 10000
            LaunchHS()
            Loop, 13 {
                DumbSpam()
            }
        }
        IfWinExist, Blizzard Error
        {
            IfWinNotActive, Blizzard Error, , WinActivate, Blizzard Error, 
            WinWaitActive, Blizzard Error, 
            Sleep, 2000
            MouseClick, left,  20,  405 ; don't send to blizz (lol)
            Sleep, 2000
            MouseClick, left, 522, 409 ; close window
            Sleep, 5000
            LaunchBNet(15000)
            ResumeSmurf()
            LaunchHS()
            Loop, 13 {
                DumbSpam()
            }
        }
    }
}

DoPracticeGames() {
    WinWait, Hearthstone,  
    IfWinNotActive, Hearthstone, , WinActivate, Hearthstone, 
    WinWaitActive, Hearthstone, 
    Loop,  9 { ; try doing 9 games
        CloseHS()
        LaunchHS()
        MouseClick, left,  368,  223 ; click "solo adventures"
        Sleep, 10000
        MouseClick, left,  398,  363 ; dismiss "requires unlocking all 9 classes in practice/adventure lobby"
        Sleep, 3000
        MouseClick, left,  608,  78 ; select practice mode
        Sleep, 3000
        Loop, 13 {
            DumbSpam()
        }
        IfWinNotExist, Hearthstone ; re-launch HS if it crashes and run for longer
        {
            LaunchHS()
            Loop, 13 {
                DumbSpam()
            }
        }
        IfWinExist, Oops!
        {
            IfWinNotActive, Oops!, , WinActivate, Oops!, 
            WinWaitActive, Oops!, 
            Sleep, 2000
            MouseClick, left,  183,  102
            Sleep, 10000
            LaunchHS()
            Loop, 13 {
                DumbSpam()
            }
        }
        IfWinExist, Blizzard Error
        {
            IfWinNotActive, Blizzard Error, , WinActivate, Blizzard Error, 
            WinWaitActive, Blizzard Error, 
            Sleep, 2000
            MouseClick, left,  20,  405 ; don't send to blizz (lol)
            Sleep, 2000
            MouseClick, left, 522, 409 ; close window
            Sleep, 5000
            LaunchBNet(15000)
            ResumeSmurf()
            LaunchHS()
            Loop, 13 {
                DumbSpam()
            }
        }
    }
}

EndTurn() {
    MouseClick, left,  721,  277 ; end turn
}

DumbSpam() {
    HandToFace()
    DumpHand()
    ;ClickChoose()
    ;Sleep, 1000
    ;SelectJaina()
    ;ClickChoose()
    SpamHeroPower()
    GoFace()
    Trade()
    Sleep, 1000
    EndTurn()
    Sleep, 1000
    SpamOpponents()
    Sleep, 25000
}

DumpHand() {
    global yOffset
    Loop, 8 {
        MouseClick, left, 202+45*a_index, 570-yOffset
        Sleep, 100
        MouseClick, left, 372+10*a_index, 230
        Sleep, 100
    }
    Loop, 8 {
        MouseClick, left, 202+45*a_index, 570-yOffset
        Sleep, 100
        MouseClick, left, 452-10*a_index, 230
        Sleep, 100
    }
}

SpamHeroPower() {
    global xOffset
    global yOffset
    MouseClick, left,  503-xOffset,  460-yOffset
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
            MouseClick, left, 50+65*a_index, 324
            Sleep, 150
            MouseClick, left, 408, 109
            Sleep, 30
            Loop, 8 {
                ;MouseClick, left, 300+30*a_index, 214
                ;MouseClick, left, 540-30*a_index, 214
                ;MouseClick, left, 630-30*a_index, 214
                MouseClick, left, 740-65*a_index, 223
                Sleep, 20
            }
            MouseClick, left, 408, 109
        } 
}

GoFace() {
    Loop, 7 {
        MouseClick, left, 50+75*a_index, 324
        Sleep, 150
        MouseClick, left, 408, 109
        Sleep, 150
    }
}

SpamOpponents() {
    MouseClick, left,  164,  420
    Sleep, 100
    MouseClick, left,  241,  420
    Sleep, 100
    MouseClick, left,  355,  420
    Sleep, 100
    MouseClick, left,  400,  420
    Sleep, 100    
    MouseClick, left,  439,  420
    Sleep, 100
    MouseClick, left,  526,  420
    Sleep, 100
    MouseClick, left,  614,  420
    Sleep, 100
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
    Sleep, 20000
    Loop, 4 { ; need to do 4 play games to get rid of quests
        MouseClick, left, 290, 400 ; select bottom middle hero
        Sleep, 5000
        ClickChoose() ; this is also where the Play button is
        Sleep, 80000 ; wait a long time for matchmaking
        Concede()
        DismissQuests()
    }
    MouseClick, left,  740,  556 ; go back to main menu
    Sleep, 5000
}

Concede() {
    global xOffset
    global yOffset
    IfWinNotActive, Hearthstone, , WinActivate, Hearthstone, 
    WinWaitActive, Hearthstone, 
    MouseClick, left,  784-xOffset,  585-yOffset ; click menu gear
    Sleep, 2000
    MouseClick, left,  429,  215 ; click "concede" Button
    Sleep, 7000 ; let hero blow up
}

DismissQuests() {
    MouseClick, left,  511,  60 ; dismiss exp screen
    Sleep, 10000
    MouseClick, left,  511,  50 ; dismiss completed quest
    Sleep, 10000
    MouseClick, left,  511,  40 ; dismiss new quest
    Sleep, 5000
    MouseClick, left,  511,  60 ; extra clicks to dismiss settings menus in case opponent conceded first
    Sleep, 3000
    MouseClick, left,  511,  50 ; 
    Sleep, 3000
}

CheckQuests() {
    MouseClick, left,  180,  500 ; click quest button
    Sleep, 3000
}

RollForFriendQuest(currentSmurf) {
    CheckQuests()
    CaptureScreen(currentSmurf)
    if HasFriendQuest() {
        AddToFriendSmurfs()
    }
    else
    {
        RerollAllQuests()
        if HasFriendQuest() {
            CaptureScreen(currentSmurf)
            AddToFriendSmurfs()
        }
    }
}

AddToFriendSmurfs() {
    global rerollSmurfs
    global friendSmurfs
    last := TF_Tail("!" . rerollSmurfs, -1)
    TF_RemoveLines("!" . rerollSmurfs, -1, -1)
    FileAppend, `n, %rerollSmurfs%
    FileAppend, %last%, %friendSmurfs%
}

HasFriendQuest() {
    ; check if middle quest is now 80g friend quest
    ImageSearch, , , 231, 390, 583, 528, friendLeft.png
    if ErrorLevel = 1
    {
        ImageSearch, , , 231, 390, 583, 528, friendMid.png
        if ErrorLevel = 1
        {
            ;MsgBox, no friend quest
            return false
        }
        else
        {
            ;MsgBox, mid friend found
            return true
        }
    }
    else
    {
        ;MsgBox, left friend quest found
        return true
    }
    ; if it Is
        ; log this username as having the quest
    ; log out
}

RerollAllQuests() {
    MouseClick, left, 337, 403
    Sleep, 2000
    MouseClick, left, 449, 403
    Sleep, 2000
    MouseClick, left, 564, 403
    Sleep, 2000
}

MakePracticeDeck() { ; for blind spam ai; starts from home screen
    global xOffset
    global yOffset
    MouseClick, left,  428,  511 ; click "My Collection" button
    Sleep, 30000
    MouseClick, left,  674-xOffset,  56+yOffset ; click mage deck
    Sleep, 3000
    MouseClick, left,  674-xOffset,  56+yOffset ; click again in case of tutorial popup
    Sleep, 5000
    Loop, 30 {
        MouseClick, left,  731-xOffset,  73+yOffset ; remove cards from deck
        Sleep, 500
    }
    MouseClick, left,  72+2*xOffset,  19+yOffset ; click basic cards tab
    Sleep, 5000
    MouseClick, left,  365,  371 ; acidic slime
    Sleep, 1000
    MouseClick, left,  365,  371
    Sleep, 1000
    MouseClick, left,  497,  383 ; bloodfen raptor
    Sleep, 1000
    MouseClick, left,  497,  383
    Sleep, 1000
    MouseClick, left,  573-xOffset,  278 ; next page
    Sleep, 3000
    MouseClick, left,  87,  157 ; bluegill
    Sleep, 1000
    MouseClick, left,  86,  169
    Sleep, 1000
    MouseClick, left,  211,  404 ; river croc
    Sleep, 1000
    MouseClick, left,  211,  404
    Sleep, 1000
    MouseClick, left,  578-xOffset,  284 ; next page
    Sleep, 3000
    MouseClick, left,  98,  189 ; ironfur
    Sleep, 1000
    MouseClick, left,  98,  189
    Sleep, 1000
    MouseClick, left,  493,  167 ; razorfen hunter
    Sleep, 1000
    MouseClick, left,  492,  171
    Sleep, 1000
    MouseClick, left,  348,  390 ; wolfrider
    Sleep, 1000
    MouseClick, left,  364,  391
    Sleep, 1000
    MouseClick, left,  524,  377 ; chillwind
    Sleep, 1000
    MouseClick, left,  524,  377
    Sleep, 1000
    MouseClick, left,  578-xOffset,  279 ; next page
    Sleep, 3000
    MouseClick, left,  93,  180 ; dragonling mechanic
    Sleep, 1000
    MouseClick, left,  93,  180
    Sleep, 1000
    MouseClick, left,  246,  196 ; gnomish inventor
    Sleep, 1000
    MouseClick, left,  246,  196
    Sleep, 1000
    MouseClick, left,  74,  381 ; sen'jin
    Sleep, 1000
    MouseClick, left,  74,  381
    Sleep, 1000
    MouseClick, left,  509,  379 ; darkscale
    Sleep, 1000
    MouseClick, left,  509,  379
    Sleep, 1000
    MouseClick, left,  577-xOffset,  280 ; next page
    Sleep, 3000
    MouseClick, left,  224,  377 ; boulderfist
    Sleep, 1000
    MouseClick, left,  224,  377 
    Sleep, 1000
    MouseClick, left,  363,  391 ; lord of the arena
    Sleep, 1000
    MouseClick, left,  363,  391
    Sleep, 1000
    MouseClick, left,  472,  396 ; rocketeer
    Sleep, 1000
    MouseClick, left,  474,  397
    Sleep, 1000
    MouseClick, left,  747-xOffset,  557-yOffset ; finish
    Sleep, 5000
    ;MouseClick, left,  747,  557 ; go back to home screen
    ;Sleep, 10000
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "2", "2", "practice")
}

MakeHearthrangerPracticeDeck() { ; starts from home screen
    global xOffset
    global yOffset
    MouseClick, left,  428,  511 ; click "My Collection" button
    Sleep, 30000
    MouseClick, left,  674-xOffset,  56+yOffset ; click mage deck
    Sleep, 3000
    MouseClick, left,  674-xOffset,  56+yOffset ; click again in case of tutorial popup
    Sleep, 5000
    Loop, 30 {
        MouseClick, left,  731-xOffset,  73+yOffset ; remove cards from deck
        Sleep, 500
    }    
    MouseClick, left,  368,  196
    Sleep, 1000
    MouseClick, left,  368,  196
    Sleep, 1000
    MouseClick, left,  473,  198
    Sleep, 1000
    MouseClick, left,  473,  198
    Sleep, 1000
    MouseClick, left,  116,  390
    Sleep, 1000
    MouseClick, left,  119,  389
    Sleep, 1000
    MouseClick, left,  570,  297
    Sleep, 3000
    MouseClick, left,  368,  386
    Sleep, 1000
    MouseClick, left,  368,  386
    Sleep, 1000
    MouseClick, left,  470,  387
    Sleep, 1000
    MouseClick, left,  481,  384
    Sleep, 1000
    MouseClick, left,  574,  295
    Sleep, 3000
    MouseClick, left,  236,  376
    Sleep, 1000
    MouseClick, left,  236,  376
    Sleep, 1000
    MouseClick, left,  567,  291
    Sleep, 3000
    MouseClick, left,  126,  186
    Sleep, 1000
    MouseClick, left,  124,  186
    Sleep, 1000
    MouseClick, left,  118,  386
    Sleep, 1000
    MouseClick, left,  121,  388
    Sleep, 1000
    MouseClick, left,  483,  388
    Sleep, 1000
    MouseClick, left,  484,  388
    Sleep, 1000
    MouseClick, left,  572,  295
    Sleep, 3000
    MouseClick, left,  239,  203
    Sleep, 1000
    MouseClick, left,  245,  203
    Sleep, 1000
    MouseClick, left,  121,  384
    Sleep, 1000
    MouseClick, left,  121,  384
    Sleep, 1000
    MouseClick, left,  481,  385
    Sleep, 1000
    MouseClick, left,  487,  389
    Sleep, 1000
    MouseClick, left,  570,  297
    Sleep, 3000
    MouseClick, left,  245,  385
    Sleep, 1000
    MouseClick, left,  245,  385
    Sleep, 1000
    MouseClick, left,  365,  390
    Sleep, 1000
    MouseClick, left,  365,  390
    Sleep, 1000
    MouseClick, left,  573,  297
    Sleep, 3000
    MouseClick, left,  245,  206
    Sleep, 1000
    MouseClick, left,  245,  206
    Sleep, 1000
    MouseClick, left,  747-xOffset,  557-yOffset ; finish
    Sleep, 5000
    ;MouseClick, left,  747,  557 ; go back to home screen
    ;Sleep, 10000
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "2", "2", "practice")
}

SwitchHearthrangerAcct() {
    global hr_pid
    WinWait, ahk_pid %hr_pid%, 
    IfWinNotActive, ahk_pid %hr_pid%, , WinActivate, ahk_pid %hr_pid%, 
    WinWaitActive, ahk_pid %hr_pid%, 
    FileReadLine, hrName, \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\hearthrangerAccts.txt, 1
    FileAppend, %hrName%`n, \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\hearthrangerAccts.txt
    TF_RemoveLines("!" . "\\vmware-host\Shared Folders\GitHub\Force_quest_MAX\hearthrangerAccts.txt", 1, 1)
    MouseClick, left,  57,  150 ; edit tasks
    WinWait, Task Editor, 
    IfWinNotActive, Task Editor, , WinActivate, Task Editor, 
    WinWaitActive, Task Editor, 
    Sleep, 5000
    MouseClick, left,  195,  69 ; bot account tab
    Sleep, 2000
    MouseClick, left,  324,  128 ; select account name text box
    Sleep, 2000
    Send, {CTRLDOWN}a{CTRLUP}%hrName%{TAB}{CTRLDOWN}a{CTRLUP}password1
    Sleep, 2000
    MouseClick, left,  652,  554 ; save
    Sleep, 2000
}

LaunchHearthRanger() {
    global hr_pid
    Run, C:\Users\gxing\Downloads\HearthRanger\HearthRanger\HearthRanger.exe, , , hr_pid
    Sleep, 10000
}

CloseHearthRanger() {
    global hr_pid
    WinClose, ahk_pid %hr_pid%
    WinWaitClose
    Sleep, 5000
}

DoQuestsHearthranger() {
    global hr_pid
    WinWait, ahk_pid %hr_pid%, 
    IfWinNotActive, ahk_pid %hr_pid%, , WinActivate, ahk_pid %hr_pid%, 
    WinWaitActive, ahk_pid %hr_pid%, 
    Sleep, 1000
    MouseClick, left,  57,  150 ; edit tasks
    WinWait, Task Editor, 
    IfWinNotActive, Task Editor, , WinActivate, Task Editor, 
    WinWaitActive, Task Editor, 
    Sleep, 5000
    MouseClick, left,  427,  126 ; change to auto-quest mode
    Sleep, 1000
    MouseClick, left,  652,  554 ; save
    Sleep, 2000
    MouseClick, left, 211, 150 ; start
    Sleep, 10000
    Loop, 1440 {
        IfWinNotActive, ahk_pid %hr_pid%, , WinActivate, ahk_pid %hr_pid%, 
        WinWaitActive, ahk_pid %hr_pid%, 
        PixelSearch, , , 33, 124, 262, 139, 0x00FF00, , Fast
        if ErrorLevel
        {
            break
        }
        Sleep, 5000
    }
    ;Sleep, 3600000 ; wait 60 mins
    ;;Sleep, 60000
    ;MouseClick, left, 285, 150 ; stop
    ;Sleep, 1000
    CloseHS()
    LaunchHS()
    CheckQuests()
    last := TF_Tail("!" . "\\vmware-host\Shared Folders\GitHub\Force_quest_MAX\questingSmurfs.txt", -1)
    StringSplit, lastArray, last, %A_Space%
    lastArray2 +=1
    TF_RemoveLines("!" . "\\vmware-host\Shared Folders\GitHub\Force_quest_MAX\questingSmurfs.txt", -1, -1)
    ;if lastArray2 >= 10 ; smurf can potentially reroll into the 80g friend quest after doing 10 basic quests
    ;{
    ;    FileAppend, %lastArray1%`n, \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\rerollSmurfs.txt
    ;    FileAppend, `n, \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\questingSmurfs.txt
    ;} else 
    ;{
    ;    FileAppend, `n%lastArray1% %lastArray2%`n, \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\questingSmurfs.txt
    ;}
    if HasArenaQuest() ; arena quest implies we can roll 80g friend quest now
    {
        FileAppend, %lastArray1%`n, \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\rerollSmurfs.txt
        FileAppend, `n, \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\questingSmurfs.txt
    } else 
    {
        FileAppend, `n%lastArray1% %lastArray2%`n, \\vmware-host\Shared Folders\GitHub\Force_quest_MAX\questingSmurfs.txt
    }
}

DoPracticeGamesHearthranger() {
    global hr_pid
    WinWait, ahk_pid %hr_pid%, 
    IfWinNotActive, ahk_pid %hr_pid%, , WinActivate, ahk_pid %hr_pid%, 
    WinWaitActive, ahk_pid %hr_pid%, 
    MouseClick, left,  57,  150 ; edit tasks
    WinWait, Task Editor, 
    IfWinNotActive, Task Editor, , WinActivate, Task Editor, 
    WinWaitActive, Task Editor, 
    Sleep, 5000
    MouseClick, left,  333,  126 ; change to queue mode
    Sleep, 3000
    MouseClick, left,  682,  209 ; reset #1 (druid)
    Sleep, 1000
    MouseClick, left,  691,  285 ; reset #2 (hunter)
    Sleep, 1000
    MouseClick, left,  682,  358 ; reset #3 (paladin)
    Sleep, 1000
    Send, {WheelDown} ; 3 down keys == one scroll wheel down
    Sleep, 1000
    MouseClick, left,  693,  382 ; reset #4 (priest)
    Sleep, 1000
    Send, {WheelDown}
    Sleep, 1000
    MouseClick, left,  683,  410 ; reset #5 (shaman)
    Sleep, 1000
    Send, {WheelDown}
    Sleep, 1000
    Send, {WheelDown}
    Sleep, 1000
    MouseClick, left,  682,  391 ; reset #6 (warlock)
    Sleep, 1000
    Send, {WheelDown}
    Sleep, 1000
    Send, {WheelDown}
    Sleep, 1000
    MouseClick, left,  683,  376 ; reset #7 (warrior)
    Sleep, 1000
    Send, {WheelDown}
    Sleep, 1000
    MouseClick, left,  698,  415 ; reset #8 (rogue)
    Sleep, 1000
    MouseClick, left,  652,  554 ; save
    Sleep, 2000
    MouseClick, left,  208,  150 ; play
    Sleep, 4000000 ; let bot run
    TF_ReplaceLine("!" . "C:\currentHsSmurf.txt", "2", "2", "play")
}

MakeSmurfHearthRanger() {
    LaunchHearthRanger()
    LaunchBNet(15000)
    ResumeSmurf()
    Sleep, 20000
    MouseClick, left,  70,  492 ; auto update games for new acct
    Sleep, 5000
    BringUpSmurf()
    CloseHearthRanger()
}

DoQuestHearthRanger() {
    LaunchHearthRanger()
    LaunchBNet(15000)
    QuestingLogIn()
    LaunchHS()
    DoQuestsHearthranger()
    CloseHS()
    LogOut()
    CloseHearthRanger()
}

DoReroll() {
    LaunchBNet(10000)
    currentSmurf := RerollLogIn()
    LaunchHS()
    RollForFriendQuest(currentSmurf)
    CloseHS()
    LogOut()
}

HasArenaQuest() {
    ;PixelSearch, , , 231, 390, 583, 528, 0x213863, , Fast
    ;;PixelSearch, , , 231, 450, 583, 477, 0x98BFD5, , Fast
    ;if ErrorLevel ; arena quest not found
    ;{
    ;    return false
    ;    ;MsgBox, no arena
    ;}
    ;else ; arena quest found - we're done doing quests
    ;{
    ;    return true
    ;    ;MsgBox, arena found
    ;}
    ImageSearch, , , 231, 390, 583, 528, arenaLeft.png
    if ErrorLevel = 1
    {
        ImageSearch, , , 231, 390, 583, 528, arenaMid.png
        if ErrorLevel = 1
        {
            ;MsgBox, no friend quest
            return false
        }
        else
        {
            ;MsgBox, mid friend found
            return true
        }
    }
    else
    {
        ;MsgBox, left friend quest found
        return true
    }
}

FriendLogIn() {
    global friendSmurfs
    FileReadLine, smurfEmail, %friendSmurfs%, 1
    FileAppend, %smurfEmail%`n, %friendSmurfs%
    TF_RemoveLines("!" . friendSmurfs, 1, 1)
    LogIn(smurfEmail)
}

AddFriend() {
    global friend
    MouseClick, left,  30,  558 ; open friends list
    Sleep, 1000
    MouseClick, left,  61,  521 ; add friend
    Sleep, 1000
    SendRaw, %friend%
    Send, {ENTER}
    Sleep, 1000
}

RemoveFriend() {
    MouseClick, left,  30,  558 ; open friends list
    Sleep, 1000
    MouseClick, left, 121, 260 ; select top friend
    Sleep, 1000
    MouseClick, left,  169,  521 ; remove friend
    Sleep, 1000
    MouseClick, left,  169,  521 ;
    Sleep, 1000
    MouseClick, left, 313, 359 ; confirm
    Sleep, 1000
}

AddBackToRerolls() {
    global rerollSmurfs
    global friendSmurfs
    last := TF_Tail("!" . friendSmurfs, -1)
    TF_RemoveLines("!" . friendSmurfs, -1, -1)
    FileAppend, `n, %friendSmurfs%
    FileAppend, %last%, %rerollSmurfs%
}

MoveFromAToB(listA, listB) {
    last := TF_Tail("!" . listA, -1)
    TF_RemoveLines("!" . listA, -1, -1)
    FileAppend, `n, %listA%
    FileAppend, %last%, %listB%
}

FriendDuelSpam() {
    while true 
    {
        PixelSearch, , , 382, 347, 428, 347, 0x73DBE8, , Fast
        if ErrorLevel ; no challenge canclled box, so keep spamming
        {
            MouseClick, left,  30,  558 ; open friends list
            Sleep, 500
            MouseClick, left,  179,  260 ; click challenge button in friends list
            Sleep, 500
            MouseClick, left,  296,  264 ; click standard challenge
            Sleep, 100
            MouseClick, left, 410, 446 ; click confirm for mulligan
            Sleep, 100
            MouseClick, left,  638,  491 ; click play
            Sleep, 100
            EndTurn()
            Sleep, 100
        }
        else ; challenge cancelled - we're done
        {
            Loop, 2 ; dismiss cancellation notifications - need to mod this to account for delayed second cancellation
            {
                MouseClick, left,  405,  335
                Sleep, 2000
            }
            return
        }
    }
}

CashInFriendQuest() {
    global friendSmurfs
    LaunchBNet(10000)
    FriendLogIn()
    LaunchHS()
    AddFriend()
    FriendDuelSpam()
    RemoveFriend()
    CloseHS()
    LogOut()
    AddBackToRerolls()
}