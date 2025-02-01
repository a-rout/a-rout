#Requires AutoHotkey v2.0
#SingleInstance Force

; Initialize variables
global SnoozeTime := 2  ; Default snooze time in minutes

; Set timer to check every minute
; SetTimer CheckForFriday, 60000

CheckForFriday() {
    if (A_WDay = 7) {  ; Friday at 11:00 AM
        ShowReminder()
    }
}

ShowReminder() {
    reminderGui := Gui("+AlwaysOnTop +ToolWindow -MinimizeBox", "Reminder!")
    reminderGui.SetFont("s10 cBlack", "Segoe UI")  ; Default font
    reminderGui.SetFont("s12 Bold cRed", "Segoe UI")
    reminderGui.MarginX := 20
    reminderGui.MarginY := 20

    reminderGui.SetFont("s10")
    reminderGui.Add("Text",, "PLEASE FILL THE TIMESHEET & SUBMIT!")
    
    reminderGui.Add("Button", "x40 y60 w80", "Done").OnEvent("Click", (*) => (
        reminderGui.Destroy(),
        ExitApp()
    ))
    reminderGui.Add("Button", "x150 y60 w80", "Snooze").OnEvent("Click", (*) => Snooze(reminderGui))
    ; reminderGui.Add("Button", "x190 y60 w80", "Cancel").OnEvent("Click", (*) => (
    ;     reminderGui.Destroy(),
    ;     ExitApp()
    ; ))
    
    reminderGui.Show() 
    SoundPlay("*-1")
}



Snooze(gui) {
    global SnoozeTime
    gui.Destroy()
    SetTimer () => ShowReminder(), -SnoozeTime * 60000
}

CheckForFriday()
