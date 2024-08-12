run: particles.c3
	clear
	c3c compile -g0 particles.c3 -l ./raylib-5.0_linux_amd64/lib/libraylib.a ./raylib.c3
	./particles