;Requires AutoHotkey v2.0

; [Win + C] : Запуск калькулятора
;sc02e => c
#sc02e::run "C:\Progs\Calc\Calculator.exe"

; [Win + F] : Запуск Far в ConEmu, в ConEmu должно быть настроено сочетание клавиш [Win + Shift + F] для запуска Far
;sc021 => f
#sc021:: {
    if WinExist("ahk_class VirtualConsoleClass") {
        WinActivate
        Send("#+F")
    } else {
        local cemuPid
        Run("C:\Progs\ConEmu_Common\ConEmu64.lnk",,, &cemuPid)
        WinWait("ahk_pid " cemuPid)
        WinActivate("ahk_pid " cemuPid)
    }
}

; [Esc] : Переключает язык на английский и посылает [Esc]
$Esc:: {
	SendMessage(0x50,, 0x4090409,, "A") ; английский
	Send("{Esc}")
}

; [Win + Left] : Переход к следующему рабочему столу. Замена [Win + Left] на [Win + Ctrl + Left]
#Left::#^Left

; [Win + Right] : Переход к предыдущему рабочему столу. Замена [Win + Right] на [Win + Ctrl + Right]
#Right::#^Right

; [Win + Ctrl + d] : Отправить текстовую строку с текущей датой
;sc020 => d
#^sc020:: {
    Sleep(150)
    TimeString := FormatTime(,"yyyy-MM-dd")
    Send(TimeString)
    Send("{LCtrl Up}")
    Send("{RCtrl Up}")
    Send("{LWin Up}")
    Send("{RWin Up}")
}

; [CapsLock] : Если активное окно "понимает" vim, переключает язык на английский, выключает CapsLock на всякий случай и отправляет [Esc]
CapsLock:: {
	If WinActive("GVIM") or WinActive("Qt Creator") or WinActive("QT_CREATOR") {
		Send("{Esc}")
	}
	SendMessage(0x50,, 0x4090409,, "A") ; английский
	SetCapsLockState("Off")
}

; [Ctrl + Shift + End] : Переназначить на кнопку [Play/Pause] (Работает для Яндекс.Музыка в браузере)
^+sc14F::Send("{Media_Play_Pause}")

; [Ctrl + Shift + PgDown] : Переназначить на кнопку [Next Track] (Работает для Яндекс.Музыка в браузере)
^+sc151::Send("{Media_Next}")

; [Ctrl + Shift + PgUp] : Переназначить на кнопку [Previous Track] (Работает для Яндекс.Музыка в браузере)
^+sc149::Send("{Media_Prev}")


; [Win + x] : Развернуть окно на весь экран. Для RDCMan окно не должно быть в режиме Maximize, иначе наблюдаются артефакты.
;sc02d => x
#sc02d:: {
    winState := WinGetMinMax("A")
    if (winState == 0) or (winState == -1) {
        if WinActive("Remote Desktop Connection Manager") {
            WinMove(-8,40,2576,1408,"A")           ; Для монитора 2560х1440 и панелью задач сверху
;           WinGetPos(&x,&y,&w,&h, "A")            ; А так можно получить параметры для монитора
;           MsgBox("Window is at " X "," Y " and its size is " W "x" H)
;           -8,32,2576,1416
        } else {
            WinMaximize("A")
        }
    } else if (winState == 1) {
        WinRestore("A")
    }
}

