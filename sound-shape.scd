s.internal;
s.boot;



// rectangle synthDef with triggers for when values change.
(
SynthDef(\rectSound, {
	arg out=0, freq=440, pwm=0.5, panning=0, amp=0.5;

	var signal;

	signal = Pulse.ar(freq, pwm, amp);
	signal = Pan2.ar(signal, panning);
	Out.ar(out,signal);

	// triggers to send back information to the langauge
	//when an argument is updated. 1 trigger for each argument.
	SendTrig.kr(Changed.kr(freq), 1, freq);
	SendTrig.kr(Changed.kr(pwm), 2, pwm);
	SendTrig.kr(Changed.kr(panning), 3, panning);
	SendTrig.kr(Changed.kr(amp), 4, amp);

	SendTrig.kr(freq, 1, freq);
	SendTrig.kr(pwm, 2, pwm);
	SendTrig.kr(panning, 3, panning);
	SendTrig.kr(amp, 4, amp);

}).add;
)

(
b = NetAddr.new("127.0.0.1", 57150);
// register to receive this message
o = OSCFunc({ arg msg, time;
    [time, msg].postln;
	msg[1].postln;

	// send an OSC message to processing.
	// Format required by the Processing sketch is as follows:
	// /shape, shapeId, shapeFreq, shapePwm, panning, amp



	//b.sendMsg("/test", msg[2], msg[3]); // this just sends a test OSC message with the

},'/updatesynth', b);
)

// To make the sounds - testing
	x = Synth(\rectSound);
x.set(\freq, 90);
x.free;

i = 50;

do(5){ |i|
	i.postln;

};


y = Synth(\rectSound, [\freq, 350, \pwm, 0.2, \panning, 0.5, \amp, 0.1]);
y.set(\freq, 200, \panning, -1);


NetAddr.localAddr

// Sending information to Processing.
b = NetAddr.new("127.0.0.1", 12000);
b.sendMsg("/test", 4, 2);

// setup OSCFunc to listen to OSC messages coming from anywhere.

o = OSCFunc.trace(true); // turns on

x = 440.1;
x = 440.0.asInt;
x.asInt;




// OSC reciever from Processing Sketch!
(
OSCdef(\synthListener, {
	arg msg;
	msg.postln; // post the message.

	// need to have a test to check the synth ID with an identityDictionary.

	// if it is false a new synth is made, if not the correct synth is updated.

}, '/updatesynth');

)