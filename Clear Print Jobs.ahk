; If you're having trouble with print jobs getting stuck, this script might help. It stops the print spool service, then it deletes the print job files, then it starts the print spool service.

; If you strip away the error handling code, this is all the script does:

; RunWait, %comspec% /c net stop Spooler, , ; Stop the Print Spooler service
; FileRemoveDir, %dir%, 1 ; Remove all files in the Print Spooler Directory
; FileCreateDir, %dir% ; Create the folder
; RunWait, %comspec% /c net start Spooler, , ; Start the Print Spooler service

;-----------------------------------------

; Icon made by [Madebyoliver](http://www.flaticon.com/authors/madebyoliver) from www.flaticon.com 
; CMD error handling script: https://autohotkey.com/board/topic/23917-errorlevel-of-comspec-does-not-return/

;-----------------------------------------

; This application must be run as Administrator or else it won't be able to stop the Print Spooler service.
if not A_IsAdmin { ; Ensure the program is run as admin
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

;;;;; INIT VARIABLES (edit these if you're getting errors)
dir = C:\Windows\System32\spool\PRINTERS ; The directory where the print job files are stored
StopCommand = net stop Spooler  ; Command to stop the Print Spooler service (change "Spooler" if you are getting errors)
StartCommand = net start Spooler  ; Command to start the Print Spooler service (change "Spooler" if you are getting errors)

;;;;; INIT VARIABLES FOR ERROR CHECKING
ErrorSpoolerStop := false
ErrorDirectory := false
ErrorSpoolerStart := false

;;;;; STOP PRINTER SPOOLER SERVICE
;RunWait, %comspec% /c net stop Spooler , , ; Original command without error handling
file = %A_ScriptDir%\sched_create.txt
RunWait, %comspec% /c "%StopCommand% > `"%file%`" 2>&1", ,  ; Stop the Print Spooler service
Sleep 700 ; Wait for file to be written
FileRead, result, %file%
Sleep 300
FileDelete %file%
HasError := RegExMatch(result, "invalid")
If (HasError) {
	ErrorSpoolerStop := true
}

;;;;; DELETE PRINTER JOB FILES
IfNotExist, %dir% ; If directory doesn't exist
	ErrorDirectory := true
else { ; If the directory does exist
	FileRemoveDir, %dir%, 1 ; Remove all files in the Print Spooler Directory
	FileCreateDir, %dir% ; Create the folder
}

;;;;; START PRINTER SPOOLER SERVICE
;RunWait, %comspec% /c net start Spooler , , ; Original command without error handling
file = %A_ScriptDir%\sched_create.txt
RunWait, %comspec% /c "%StartCommand% > `"%file%`" 2>&1", ,  ; Stop the Print Spooler service
Sleep 700 ; Wait for file to be written
FileRead, result, %file%
Sleep 300
FileDelete %file%
HasError := RegExMatch(result, "invalid")
If (HasError) {
	ErrorSpoolerStop := true
}

;;;;; OUTPUT MESSAGE
if ErrorSpoolerStop  or ErrorDirectory or ErrorSpoolerStart {
	error_message := "Error(s):"
	if ErrorSpoolerStop {
		error_message = %error_message%`nThe Print Spooler service could not be stopped.
	}
	if ErrorDirectory {
		error_message = %error_message%`nThe Print Job directory could not be located.
	}
	if ErrorSpoolerStart {
		error_message = %error_message%`nThe Print Spooler service could not be started.
	}
	MsgBox % error_message
} else {
	MsgBox, "Print jobs sucessfully cleared. Try printing now."
}