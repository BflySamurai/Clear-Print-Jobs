# Clear-Print-Jobs

**This program clears all stuck print jobs so it is possible to continue printing.**
*Only tested on Windows 10.*

See [this page](https://support.hp.com/us-en/document/c02205477) for more details about the problem and how to manually clear the print jobs.

This program replicates the actions you would take to manually clear the print jobs:
1) Stop the PRINT SPOOLER service in SERVICES
2) Delete the files in C:\Windows\System32\spool\PRINTERS
3) Start the PRINT SPOOLER service in SERVICES

---

Options for running:
-

1. Download and run [Clear Print Jobs.exe]().
2. If you have AutoHotkey installed, download [Clear Print Jobs.ahk]() and either run it or compile it into your own EXE if you don't want to trust the EXE file in this repository.

---

Credit
-

Created by [Josh Penn-Pierson](http://pennpierson.com)

Icon made by [Madebyoliver](http://www.flaticon.com/authors/madebyoliver) from www.flaticon.com

CMD error handling script: https://autohotkey.com/board/topic/23917-errorlevel-of-comspec-does-not-return/