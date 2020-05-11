Hello World
===========

Goal
----
This excercise is designed to get you up and running in assembly quickly.
At the end of the excercise we should have verified that nasm and windbg are configured 
and running correctly and that you know how to use cmakeS.
You should be able to step through an assembly program.
Hopefully, you will begin to familiarize yourself with assembly as you modify the program to print 
out your name.

Building
--------
1. cd 0-Assembly\build
2. cmake --build . --target 1_1_hello_world
3. Debugging build errors:
	3.1.	Make sure the binary is not open in wndbg
	3.2.	You may have to reconfigure: "cmake .." from within build directory

Running
-------
1. Run binary
	1.1.	cd 0-Assembly\out\bin\x86\
	1.2.	1_1_hello_world.exe
2. Run in windbg
	2.1.	open windbg.exe
	2.2.	"File" -> "Open executable" -> choose "0-Assembly\out\bin\x86\1_1_hello_world.exe"
	2.3.	Setup workspace:
		2.3.1.	"View" -> "Dissassembly"
		2.3.2. 	Drag the dissassembly window title bar to dock it with the main window.
		2.3.3.	"View" -> "Registers"
		2.3.4.	Drag the registers windows title bar to dock it with the main window.
	2.4.	Set a breakpoint on entry and start program:
		2.4.1.	In the commands window type "bp main", press enter
		2.4.2. 	In the commands windows type "g", press enter
	3.5		Step through in Windbg
		3.5.1.	"Step Over" (F10) jumps over an instruction skipping the contents of a "call".
		3.5.2.	"Step Into" (F11) steps into an instruction diving into the contents of a "call".
		3.5.3.	For instructions other than "call" step over and step into are basically the same

Tasks
-----
1. Open the source in Notepad++:
	1.1.	open 0-Assembly\source\1_1_hello_world\src\hello.asm
2. Extension: modify source to print out your name using the provided format string
3. Extension: use the strlen function to print the length of the hello world string (modify the fmt string as necessary)
