#Requires AutoHotkey v2.0
#SingleInstance Force

; Initialize variables
SnoozeTime := 15  ; Default snooze time in minutes

; Set timer to check every day
SetTimer CheckForFriday, 60000  ; Check every minute

; CheckForFriday() {
;     if (A_WDay = 7) && (A_Hour = 11) && (A_Min = 0) {  ; Friday at 11:00 AM
;         ShowReminder()
;     }
; }

CheckForFriday()

CheckForFriday() {
    if (A_WDay = 7){
        ShowReminder()
    }
}

ShowReminder() {
    ; Create reminder GUI
    reminderGui := Gui("+AlwaysOnTop", "Timesheet Reminder")
    reminderGui.SetFont("s10")
    reminderGui.Add("Text",, "Don't forget to fill your timesheet!")
    
    ; Add buttons
    reminderGui.Add("Button", "x10 y60 w80", "Done").OnEvent("Click", (*) => reminderGui.Destroy())
    reminderGui.Add("Button", "x100 y60 w80", "Snooze").OnEvent("Click", (*) => Snooze(reminderGui))
    reminderGui.Add("Button", "x190 y60 w80", "Cancel").OnEvent("Click", (*) => reminderGui.Destroy())
    
    ; Show the GUI
    reminderGui.Show()
    
    ; Play notification sound
    SoundPlay("*-1")
}

Snooze(gui) {
    global SnoozeTime
    gui.Destroy()
    
    ; Set timer to show reminder again after snooze time
    SetTimer () => ShowReminder(), -SnoozeTime * 60000
}
