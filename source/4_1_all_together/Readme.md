All Together
============

Goal
----
This exercise binary reads in a file called "Readme.md" that is in the same directory as the exe.
Your job is to write a number of functions to gather statistics about the file that is read in.
This will require you to apply the knowledge you have learnt in the previous exercises.
Note: Do not skip step 1.2 or 2.2!

Building
--------
1. cd 0-Assembly\build
2. cmake --build . --target 4_1_all_together
3. Debugging build errors:
	3.1.	Make sure the binary is not open in wndbg
	3.2.	You may have to reconfigure: "cmake .." from within build directory

Running
-------
1. Run binary
	1.1.	cd 0-Assembly\out\bin\x86\
	1.2.	Copy 0-Assembly\Readme.md to 0-Assembly\out\bin\x86\Readme.md	
	1.2.	4_1_all_together.exe
2. Run in windbg
	2.1.	open windbg.exe
	2.2.	Ensure you set the "start directory" to the output directory when loading 
	2.3.	"File" -> "Open executable" -> choose "0-Assembly\out\bin\x86\4_1_all_together.exe"
	2.4.	Setup workspace:
		2.4.1.	"View" -> "Dissassembly"
		2.4.2. 	Drag the dissassembly window title bar to dock it with the main window.
		2.4.3.	"View" -> "Registers"
		2.4.4.	Drag the registers windows title bar to dock it with the main window.
		2.4.5.	"View" -> "Memory"
		2.4.6.	Drag the memory windows title bar to dock it with the main window.
		2.4.7.	In the memory window, change the address to "esp"
		2.4.8.	Change the display format to "Pointer and Symbol"
	2.4.	Set a breakpoint on entry and start program:
		2.5.1.	In the commands window type "bp main", press enter
		2.5.2. 	In the commands windows type "g", press enter

Tasks
-----
1. Open 0-Assembly\out\bin\x86\4_1_all_together\source\filefun.asm in notepad++
	1.1.	spend some time familiarizing yourself with the program
	1.2.	add some assembly to call "count_lines"
2. Open 0-Assembly\out\bin\x86\4_1_all_together\source\countlines.asm
	2.1.	Implement a countlines function
	2.2.	Debug your solution in windbg
3. Open 0-Assembly\out\bin\x86\4_1_all_together\source\longestline.asm
	3.1.	Implement a longestline function and call it from filefun.asm
	3.2.	Debug your solution in windbg
4. Open 0-Assembly\out\bin\x86\4_1_all_together\source\countwords.asm
	4.1.	Implement a countwords function and call it from filefun.asm
	4.2.	Debug your solution in windbg
