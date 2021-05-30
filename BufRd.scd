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

 Question2: Φτιάχνω μοτίβα ήχων από δικούς μου ήχους, χρησιμοποιώντας Buffers. Έχω ένα envelope που ελέγχει την ταχύτητα ανάγνωσης(rate) του εκάστιτε αρχείου.
 Όταν κάνει τον κύκλο του, πώς μπορώ να προσθέσω μία διαδικασία loop, ώστε το Envelope να ξανακάνει τον κύκλο, και να μην σταματάει στο τελευταίο level?
 Το πρώτο βήμα είναι να θέσω το doneAction σε 0, ώστε να μην διακοπεί. Αλλά αυτό από μόνο του απλά συνεχίζει τον ήχο στο τελευταίο rate level του Envelope.
 
 
 */

(
SynthDef.new(\buf, {
	arg out = 0, mute = 0, buffer = 0,  rate = 1, startFactor = 0, endFactor = 1, loop = 0, cut = 300, gate = 1, t1 = 0, t2 = 3, t3 = 6,l1 = 0.5, l2 = 2, l3 = 0.25, c1= 0, c2 = 0, c3 = 0;
   var bufPlay, framePointer, firstFrame, lastFrame, rateEnv;
	rateEnv =Env.xyc([[t1,l1,c1],[t2,l2,c2],[t3,l3,c3]]).kr(doneAction:0, gate: 1, levelBias:0, levelScale:1, timeScale:1);
	firstFrame = 0 + startFactor;
	lastFrame = BufFrames.ir(buffer) - endFactor;
	framePointer = Phasor.ar(0, BufRateScale.kr(buffer) * rateEnv, firstFrame, lastFrame, 0);
	bufPlay = BufRd.ar(1, buffer, framePointer, loop, 2);
	bufPlay = HPF.ar(bufPlay, cut, mute, 0);
	bufPlay = bufPlay.dup(2);
   Out.ar(out, bufPlay);
}).add;
)

