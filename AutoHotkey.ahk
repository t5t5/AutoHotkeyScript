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
    TimeString := FormatTime(,"yyyy-MM-dd")
    Send (TimeString)
}

; [CapsLock] : Если активное окно "понимает" vim, переключает язык на английский, выключает CapsLock на всякий случай и отправляет [Esc]
CapsLock:: {
	If WinActive("GVIM") or WinActive("Qt Creator") or WinActive("QT_CREATOR") {
		Send("{Esc}")
	}
	SendMessage(0x50,, 0x4090409,, "A") ; английский
	SetCapsLockState("Off")
}
