; Переключение раскладки по CapsLock (Shift+Alt)
CapsLock::Send("{LShift down}{LAlt down}{LShift up}{LAlt up}")

; Переключение виртуальных рабочих столов (Win + колесо)
#WheelUp::Send("^#{Left}")    ; Win + Колесо вверх → предыдущий рабочий стол
#WheelDown::Send("^#{Right}") ; Win + Колесо вниз → следующий рабочий стол

; Закрытие активного окна
#q::WinClose("A")

; Win + X → свернуть/восстановить все окна
#x::Send("#d")

; Win + Z → тайлинг

; Win + W → восстановить/развернуть (переключает состояние)
#w::
{
    if WinGetMinMax("A")
        WinRestore("A")
    else
        WinMaximize("A")
}

; Win + E → проводник

; Win + S → свернуть активное окно
#s::WinMinimize("A")  

; Win + A → пристыковать влево
#a::Send("#{Left}")

; Win + D → пристыковать вправо
#d::Send("#{Right}") 
