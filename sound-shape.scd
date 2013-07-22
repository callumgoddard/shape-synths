s.boot;

// SynthDef that shapeSynth processing project communicates with.
// only needs to be ran once, then only the server is needed to be booted
(
SynthDef(\rectSound, {
	arg out=0, freq=440, pwm=0.5, panning=0, amp=0.5;

	var signal;

	signal = Pulse.ar(freq, pwm, amp);
	signal = Pan2.ar(signal, panning);
	Out.ar(out,signal);
}).store;

SynthDef(\circSound, {
	arg out=0, freq=440, pwm=0.5, panning=0, amp=0.5;

	var signal;

	signal = Pulse.ar(freq, pwm, amp);
	signal = Pan2.ar(signal, panning);
	Out.ar(out,signal);
}).store;

)