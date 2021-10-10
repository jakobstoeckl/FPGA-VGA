all:
	yosys -p 'synth_ice40 -top top -device u -json ../out/file.json' top.v
	nextpnr-ice40 --seed 12 --freq 12 --up5k --package sg48 --asc ../out/file.asc --pcf icebitsy1.pcf  --json ../out/file.json
	icepack ../out/file.asc ../out/file.bin

prog:
	dfu-util -a 0 -D ../out/file.bin
clean:
	rm ../out/file.*
