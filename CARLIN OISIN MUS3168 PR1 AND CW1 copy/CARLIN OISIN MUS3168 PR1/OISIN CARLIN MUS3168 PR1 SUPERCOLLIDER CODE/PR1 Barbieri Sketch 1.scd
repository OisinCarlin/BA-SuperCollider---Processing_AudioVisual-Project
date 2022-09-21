s.boot;
s.freqscope;
s.meter;
s.scope;

//************Bell Arpeggio Synth********************************
(
SynthDef("BellArp", { //Initate SynthDef

	arg amp = 0.5, freq = 300, attack = 0.01, decay = 1, pos = 0; //Declare arguments for synthesis parameters

	var env, snd; //Declare variables for envelope and send

	env = EnvGen.ar( //Declare percussive envelope
		Env.perc(attack, decay), 1, amp, doneAction: 2 //DoneAction 2 saves CPU power
	);

	snd = //Send audio to output

	RLPF.ar( // Resonant low-pass filter
		Mix(SinOsc.ar( //Sine Oscillator
			[freq, freq * 2.01, freq * 4.03], 0.5, [0.2, 0.3, 0.1])), // input
		SinOsc.ar(1, 0, 5000, 500).abs, // cut-off, LFO

		0.5, // quality / rq / resonance
		env //Amplitude envelope
	);

	Out.ar(0, Pan2.ar(snd, pos)); //Pan output left and right

}).add; //Add SynthDef

//******************************************************************


//************Pulse Stab Synth********************************

SynthDef("PulseStab", { //Declare PulseStab SynthDef

	arg amp = 0.5, freq = 300, attack = 0.01, decay = 1, pos = 0; //Declare arguments for synthesis parameters


	var env, snd; //Declare variables for envelope and send

	env = EnvGen.ar( //Declare percussive envelope
		Env.perc(attack, decay), 1, amp, doneAction: 2 //DoneAction 2 saves CPU power
	);

	snd = //Send audio to output

	RLPF.ar( // Resonant low-pass filter
		Mix(Pulse.ar( //Pulse wave oscillator
			[freq, freq * 2.01, freq * 4.03], 0.5, [0.2, 0.3, 0.1])), // input
		MouseX.kr(minval: 100, maxval: 10000, warp: 0, lag: 0.2), //Control cut-off using mouse
		0.5, // quality / rq / resonance

		env //Amplitude envelope
	);

	Out.ar(0, Pan2.ar(snd, pos)); //Pan output left and right

}).add; //Add SynthDef

//******************************************************************



//************Saw Pad Synth*****************************************

SynthDef("SawPad", { //Declare Saw Pad SynthDef

	arg freq = 300, attack = 0.01, decay = 0.8, amp = 0.3, rq = 0.75, rate = 2, ampMul = 2; //Declare arguments for synthesis parameters

	var env, snd; //Declare variables for envelope and send

	env = EnvGen.ar( //Declare percussive envelope
		Env.perc(attack, decay), 1, amp, doneAction: 2 //Declare percussive envelope
	);

	snd = //Send audio to output

	RLPF.ar( // Resonant low-pass filter
		Mix(Saw.ar([freq / 2, freq, freq*2], ampMul*[0.8, 0.6, 0.4])), // input
		MouseX.kr(minval: 100, maxval: 10000, warp: 0, lag: 0.2), //Control cut-off using mouse
		MouseY.kr(minval: 0.25, maxval: 3, warp: 0, lag: 0.2), //Control envelope using mouse
		env //Amplitude envelope
	);

	Out.ar([0, 1], snd); //Output audio send

}).add; //Add SynthDef
)



//******************************************************************


//>>>>>>>>>>>>>>PATTERN GENERATORS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<





//*********Bell Arpeggio Pattern First Instance***********************
(
TempoClock.tempo = 80/60; //Set tempo to 80 BPM

//swits.recordching between normal and double time every other bar, with a 1 in 4 chance.
d = Pstutter(5, Pwrand([1/2, 1/4], [3/4, 1/4], inf)); //Relative tempo divisor (delta) stuttered and weighted randomised sequence, plays chosen delta 5 times. Weighted 3/4 to 1/4.


p = Pbind( //Pattern generator
	\instrument, \BellArp,
	\midinote, Pseq([ //Infinite sequence
		Pseq([56, 63, 64, 66, 68], 2), //Defined nested sequences of notes
		Pseq([54, 63, 64, 66, 68], 1),
		Prand([54, 63, 64, 66, 68, 75, 76, 78, 80], 5), //Defined random note selector
		Pseq([52, 63, 64, 66, 68], 2),
		Pseq([54, 63, 64, 66, 68], 2),
		], inf),
	\attack, 0.01, //Set attack
	\delta, d, //relative tempo divisor
	// \pos, Pwhite(-0.75, 0.75),
	\pos, Pseq([1, 0, -1, 0], inf), //panning
	\amp, 0.46 //Set amplification
).play(quant: 1);  //Quantising, tells instrument to wait until the next bar before starting the process.

//********************************************************************


//************Saw Pad Pattern*****************************************

q = Pbind( //Pattern generator
	\instrument, \SawPad,
	\midinote, Pseq([ //Infinite sequence
		Pseq([56], 10), //Defined nested sequence of notes
		Pseq([54], 10),
		Pseq([52], 10),
		Pseq([54], 10),
	    ], inf),

	\decay, Pwrand([0.5, 1], [3/4, 1/4], inf), //Weighted random decay settings, 3/4 to 1/4 chance
	\attack, Pexprand(0.01, 0.25), //Exponential random generator for attack
	\delta, d, //time between noteOn messages. Try changing to 0.5, or 0.05
).play(quant: 1); //Play and quantise

//********************************************************************

//************Pulse Stab Pattern**************************************

r = Pbind( //Pattern generator
	\instrument, \PulseStab,
	\midinote, Prand([54, 63, 64, 66, 68, 75, 76, 78, 80], inf), //Infinite sequence of random note values
	\attack, 0.01, //Set attack
	\delta, d * 8, //relative tempo divisor, multiplied by 8
	\pos, Pseq([1, 0, -1, 0], inf), //panning
	\amp, 0.26 //Set amplification
).play(quant: 1); //Play and quantise
)

//********************************************************************


//*********Bell Arpeggio Pattern Second Instance***********************

(
s = Pbind(
	\instrument, \BellArp,
	\midinote, Pseq([ //Infinite sequence
		Pseq([56, 63, 64, 66, 68], 2),  //Defined nested sequence of notes
		Pseq([54, 63, 64, 66, 68], 1),
		Prand([54, 63, 64, 66, 68, 75, 76, 78, 80], 5), //Defined random note selector
		Pseq([52, 63, 64, 66, 68], 2),
		Pseq([54, 63, 64, 66, 68], 2),
		], inf),
	\attack, 0.01, //Set attack
	\delta, d, //relative tempo divisor
	\pos, Pseq([1, 0, -1, 0], inf), //panning
	\amp, 0.26 //Set amplification
).play(quant: 1); //Play and quantise
)


p.stop; //Stop first instance of Bell Arpeggio pattern

q.stop; //Stop Saw Pad pattern

r.stop; //Stop Pulse Stab Pattern

s.stop; //Stop second instance of Bell Apreggio pattern



//Recording commands


s.recHeaderFormat = "wav";
s.prepareForRecord("/Users/oisincarlin/Desktop/BarbieriSketchTest2.wav");
s.record;
s.stopRecording;
