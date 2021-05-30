s.boot;
s.quit;

s.scope;
s.meter;

(
~rec = Array.new;
~folder = PathName.new ("/Users/lefff/OneDrive/Desktop/ΠΤΥΧΙΑΚΗ/Ήχος/SuperCollider/Factory/Records");
(
	~folder.entries.do({
		arg path;
	~rec = ~rec.add(Buffer.readChannel(s, path.fullPath,channels:[0]));
});
)
)

~rec[1].query;
~rec[1].duration;
~rec[1].play;

/*  

 Question2: Στο πρωτο synthDef(\buf): Έχω ένα envelope που ελέγχει την ταχύτητα ανάγνωσης(rate) του εκάστοτε αρχείου.
 (αναφέρομαι στην μεταβλητή "var rateEnv")
 Όταν κάνει τον κύκλο του, πώς μπορώ να προσθέσω μία διαδικασία loop, ώστε το Envelope να ξανακάνει τον κύκλο, και να μην σταματάει στο τελευταίο level?
 Το πρώτο βήμα είναι να θέσω το doneAction σε 0, ώστε να μην διακοπεί. Αλλά αυτό από μόνο του απλά συνεχίζει τον ήχο στο τελευταίο rate level του Envelope.
 Εγώ θέλω ,με το που φτάσει το τελευταίο segment, να ξανααρχίσει από την αρχή ξανακάνοντας τον κύκλο κ.ο.κ.
 Τα envelopes, δεν έχουν κάποια παράμετρο loop , οπότε ψάχνω τρόπους να επαναλαμβάνει ενα envelope τον εαυτό του,
 δίχως να φτιάχνω τεχνητά παρόμοια segments.
 
 
 */

(
SynthDef.new(\buf, {
	var bufPlay, framePointer, cutPointer,firstFrame, lastFrame, rateEnv,buffer = \buffer.kr(0);
	cutPointer = EnvGen.kr(
		Env.pairs([
			[0, 3000],
			[2, 3000],
			[3, 3000]
		], 0,
	), 1, 1, 0, 1, doneAction:0);
	rateEnv = EnvGen.kr(
		Env.xyc([
			[\t1.kr(0),\l1.kr(1),\c1.kr(0)],
			[\t2.kr(5),\l2.kr(2),\c2.kr(0)],
			[\t3.kr(10),\l3.kr(4),\c3.kr(0)],
			[\t4.kr(15),\l4.kr(0.5),\c4.kr(0)],
			[\t5.kr(20),\l5.kr(12),\c5.kr(0)],
			[\t6.kr(25),\l6.kr(1/4),\c6.kr(0)]
		]),
		\gate.kr(0), 1, 0, 1, doneAction: Done.freeSelf);
	firstFrame = 0 + \startFactor.kr(0);
	lastFrame = BufFrames.ir(buffer) - \endFactor.kr(0);
	framePointer = Phasor.ar(0, BufRateScale.kr(buffer) * rateEnv, firstFrame, lastFrame, 0);
	bufPlay = BufRd.ar(1, buffer, framePointer, \loop.kr(0), 2);
	bufPlay = BPF.ar(bufPlay, cutPointer, \rq.kr(1), \mute.kr(0), 0);
	bufPlay = bufPlay.dup(2);
	Out.ar(\outBus.ir(0), bufPlay);
}).add;

  SynthDef.new(\echoes, {
  var input, effect;
  input = In.ar(\inBus.ar(0), 2);
  effect = AllpassC.ar(input,\maxDel.ir(2),\del.kr(0.2),\dec.kr(1), \mute.kr(1), 0);
  input = input.blend(effect, \merge.kr(1/2));
  Out.ar(\outBus.ir(0), input);
}).add;
)


