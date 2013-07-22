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
)

(
// updatedSynth with panning over a virtual 10 channel speaker array.
SynthDef(\rectSound, {
	arg out=0, freq=440, pwm=0.5, panning=0, amp=0.5, width =2.0;

	var signal;

	signal = Pulse.ar(freq, pwm, amp);

	signal = PanX.ar(
		10,
		signal,
		panning,
		width
	);

	signal = Splay.ar(signal, 1);

	// signal = Pan2.ar(signal, panning);
	Out.ar(out,signal);
}).store;

)