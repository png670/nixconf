//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"",	"/home/png76/.local/bin/statusbar/sb-volume",	1,	10},
	{"",	"/home/png76/.local/bin/statusbar/sb-battery",	5,	3},
        {"",    "/home/png76/.local/bin/statusbar/sb-cpu",  30,      1},
        {"🖥️",    "/home/png76/.local/bin/statusbar/sb-usagecpu",  30,      1},
        {"🧠",    "/home/png76/.local/bin/statusbar/sb-memory",  5,      3},
        {"",    "/home/png76/.local/bin/statusbar/sb-disk",  20000,      3},
	{"📅",	"/home/png76/.local/bin/statusbar/sb-clock",	60,	1},
};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char *delim = " ";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
