s.reboot; //Boot Server



//*************************Drum SynthDef******************************************************
(
SynthDef("drum", {

	arg freq = 75, rate = 0; //Declare arguments
	var signal; //Declare signal variable

	signal = Formlet.ar( //On signal bus, open Formlet Filter
		Impulse.ar(rate), //Impulse Oscillator with frequency rate set to zero
		[freq, freq * 1.6], //Two formlet filter frequency bands set, to "freq" argument and "freq" * 1.6
		0.01, //attack
		1, //decay
		[0.2, 0.05] //amplitude
	);

	//doneActions help to reduce the CPU load.
	DetectSilence.ar(signal, doneAction: 2);  //Will monitor the strength of signal, allowing you to apply a doneAction


	Out.ar([0, 1], signal); //output assigning to L&R channels

}).add; //Add SynthDef to server
//*********************************************************************************************




//************************Subtractive Saw SynthDef*********************************************
SynthDef(\subtractiveSaw, { arg freq = 220, rate = 10, decay = 0.5, amp = 0.5, pos = 0, rq = 0.5; //Declare arguments

	var env, snd; //Declare envlope and send variables

	env = EnvGen.ar(Env.perc(0.01, decay), doneAction: 2); // 0, 2

	snd = RLPF.ar( //Resonant Low-Pass filter on audio send
		Mix(Saw.ar([freq/4, freq/2], [1, 0.5]*amp)), //Saw-tooth oscillator, two octaves, second half amplitude of first oscillator
		LFSaw.ar(rate, 0, 10000, 100).abs, //Saw-shape LFO on cut-off
		rq, //resonance
		env //Envelope
	);

	Out.ar(0, Pan2.ar(snd, pos)); //Pan output

}).add; //Add SynthDef
)
//*********************************************************************************************





(
//*************************Drum Pattern Generator*************************************************

t = TempoClock.default.tempo = 50/60; //Set tempo to 50 BPM
Pbind( //Pattern generator
	\instrument, \drum,
	\freq, Pwrand([87.3, 110], [0.7, 0.3], inf), //Weighted randomised frequencies, drum tuned to synth
	\delta, Pseq([ //Infinite pattern
		        Pseq([1], 4), //Defined pattern
		        Prand([1/8, 1/8, 1/4, 1/2], 16), //Defined random note selector
	], inf),



).play;
//************************************************************************************************



//************************Subtractive Saw Pattern Generator***************************************
Pbind( //Pattern generator
	\instrument, \subtractiveSaw,
	\midinote,
	Pseq([ //Sequencer
		Pseq([ //Infinite sequence
		Pwrand([77, 89], [0.9, 0.1], 10), //Defined weighted randomised sequence
	    Prand([84, 82, 80], 2), //Defined randomised sequence
		], 2),
		Pseq([77, 77, 84, 82, 82, 80], 1), //Defined sequence
		Prand([77, 77, 89, 80, 82, 84], 1),
		Prand([82, 82, 82, 84, 85, 87], 1),
		Pseq([84, 84, 84, 82, 82, 80], 1),

], inf),
	\dur,
	Pseq([ //Infinite sequence for duration
		Pseq([0.125], 1),
		Pseq([0.5], 1)
	], inf),

	\decay, Pwhite(0.1, 0.7), //Random values for decay with uniform distribution within range
	\delta, Pstutter(4, Prand([1/4, 1/8], inf)), //Plays each randomly selected tempo divisor 4 times
	\pos, Pseq([0.5, -0.5], inf), //Panning position sequence
	\rate, Pwhite(1, 10), //Random values for impulse rate with uniform distribution within range
	\rq, Pwhite(0.5, 1), //Random values for resonance with uniform distribution within range


).play;
)
//************************************************************************************************

s.recHeaderFormat = "wav";
s.prepareForRecord("/Users/oisincarlin/Desktop/Semester1Sketch.wav");
s.record;
s.stopRecording;

