Egg Hunter
==========

Goal
----
This exercise is designed to get you using basic arithmetic, memory and logical instructions.
Your goal is to "pop calc". The shellcode to "pop calc" is already written for you in the file
shellcode.bin.
At the start of the example program this shellcode will be read in for you and placed in memory.
Your job is to search some memory to locate and decode the shellcode to "pop calc".

There are 3 levels to this challenge. The first level has been done for you.
0. The shellcode is placed at the beginning of the memory region, you just need to call into it.
1. The shellcode is randomly placed with a unique identifier at the beginning. You must search for
the unique identifier.
2. The shellcode is also XOR encoded using a known value. You must also decode it.

Note: don't skip step 2.2

Building
--------
1. cd 0-Assembly\build
2. cmake --build . --target 2_2_egg_hunter
3. Debugging build errors:
	3.1.	Make sure the binary is not open in wndbg
	3.2.	You may have to reconfigure: "cmake .." from within build directory

Running
-------
1. Run binary
	1.1.	cd 0-Assembly\out\bin\x86\
	1.2.	2_2_egg_hunter.exe
2. Run in windbg
	2.1.	open windbg.exe
	2.2.	Ensure you set the "start directory" to the output directory when loading 
	2.3.	"File" -> "Open executable" -> choose "0-Assembly\out\bin\x86\2_2_egg_hunter.exe"
	2.4.	Setup workspace:
		2.4.1.	"View" -> "Dissassembly"
		2.4.2. 	Drag the dissassembly window title bar to dock it with the main window.
		2.4.3.	"View" -> "Registers"
		2.4.4.	Drag the registers windows title bar to dock it with the main window.
		2.4.5.	"View" -> "Memory"
		2.4.6.	Drag the memory windows title bar to dock it with the main window.
	2.5.	Set a breakpoint on entry and start program:
		2.5.1.	In the commands window type "bp main", press enter
		2.5.2. 	In the commands windows type "g", press enter
	2.6		Step through in Windbg
		3.6.1.	"Step Over" (F10) jumps over an instruction skipping the contents of a "call".
		3.6.2.	"Step Into" (F11) steps into an instruction diving into the contents of a "call".
		3.6.3.	For instructions other than "call" step over and step into are basically the same
	2.7.	View the allocated memory
		3.7.1.	In the memory window, you can type an address or an expression to view
		3.7.2.	Try typing the name of a register: e.g. "eax"
		3.7.3.	Try using the memory window to view the allocated buffer
	
Tasks
-----
1. Open the source in Notepad++:
	1.1.	open 0-Assembly\source\2_2_egg_hunter\source\egg.asm
2. Change the level to '1'
	2.1.	Modify your egg.asm on line 56 to level '1'
	2.2.	Build and debug again in windbg, try and use the memory window to examine the memory.
	2.3.	Write some assembly code to search through the memory region for the magic value.
		2.3.1.	You will need a loop and a comparison to check if you have found it.
	2.4.	If you get stuck, ask for some help. This is hard and new!
3. Change the level to '2'
	3.1.	After you have located your shellcode, you now need to decode it.