Assembly
========

Requirements:
-------------
- Windows SDK
- Cmake

Building:
---------
1. Open "Windows SDK Command Prompt"		# This is a command prompt with the correct environment variables configured
2. Navigate to 0-Assembly/ folder			# This is where the source files reside
3. "mkdir build"							# We want to put all of our build artifacts in a separate folder to keep the source clean
4. "cd build"								# Change to our build directory.
5. "cmake ../"								# Trigger cmake on our source directory
6. "cmake --build ."						# Once configuring is complete, trigger a build in our build directory

Testing:
--------
1. After building a new folder should have appeared in "env" called "out"
2. Navigate to 0-Assembly/env/out/bin/x86
3. Run srelib_tests.exe
4. Run 1_1_hello_world.exe

Course
------
If you ran 1_1_hello_world.exe and it printed out "Hello, World!", navigate to source/1_1_hello_world
