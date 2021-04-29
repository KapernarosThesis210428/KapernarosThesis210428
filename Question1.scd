/*
Mπορώ εδώ να βάζω απλές ερωτήσεις/απορίες, που δεν απαιτούν ένα συνολικό τμήμα, αλλά τεχνικές λεπτομέρειες του SC? Θα τις σημειώνω με ημερομηνία, και
αν θέλετε μου αφήνετε σχόλια/απάντηση:

*/


- ΝΟ1 (29/04/2021)
[Καθαρά τεχνική απορία]
Απλή Function που κάνω δοκιμές με function.play και μέθοδο set.

//Εδώ λειτουργεί:

(
 f =
{
	arg mute=0.1, ampDens=1, freqDens=1, ampScale=0.05,freqScale=50, ampDC=0.1, freqDC=100, fadeIn=10, hold=20, fadeOut=30;
	var  basic, ampCtrl, freqCtrl, synthCycle;
	synthCycle= Env.linen(fadeIn,hold,fadeOut).ar(2);
	freqCtrl = LFSaw.kr(freqDens, 0, freqScale, freqDC);
	ampCtrl = SinOsc.kr(ampDens, 0,ampScale,ampDC );
	basic= SinOsc.ar(freqCtrl, 0, ampCtrl, 0);
	basic = basic.dup(2) * synthCycle;
	basic = basic * mute;
};
)

//Proof:

(
x = f.play( args:
	                      [
		                       \fadeIn, 3, \hold, 10, \fadeOut, 20,
		                       \freqScale, 90, \freqDC, 130,
		                       \ampScale, 1/15, \ampDC, 1/8,
		                       \ampDens, 7,
	                      ]
)
)

/*
... αλλά αν την κάνω πιο σύνθετη, βάζοντας στην μεταβλητή ελέγχου της συχνότητας(freqCtrl), envelopes για να δημιουργήσω περαιτέρω έλεγχο:
*/

(
 f =
{
	arg mute=0.1,ampDens=1,freqDens=1,ampScale=0.05, ampDC=0.1,dc1=50,dc2=100,dc3=80,dcAtk=7,dcRel=10, scale1=20,scale2=70,scale3=50,scaleAtk=7,scaleRel=10, dens1=1,dens2=7,dens3=1,dAtk=5,dRel=5,fadeIn=10,hold=20,fadeOut=30;
	var basic, ampCtrl, freqCtrl, scaleEnv, dcEnv, densEnv, synthDur;
	synthDur = Env.linen(fadeIn,hold,fadeOut).ar(2);
	densEnv = Env.new([dens1,dens2,dens3],[dAtk,dRel],[0,0],2,0).ar(0);
	dcEnv = Env.new([dc1,dc2,dc3],[dcAtk,dcRel],[0,0],2,0).ar(0);
	scaleEnv = Env.new([scale1,scale2,scale3], [scaleAtk,scaleRel] ,[0,0],2,0).ar(0);
	freqCtrl = LFSaw.kr(densEnv, 0, scaleEnv, dcEnv);
	ampCtrl = SinOsc.kr(ampDens, 0,ampScale,ampDC );
	basic = SinOsc.ar(freqCtrl, 0, ampCtrl, 0);
	basic = basic!2 * synthDur;
	basic = basic * mute;
};
)

// ...ενώ με Function.play αρχικά δουλεύει, όταν δοκιμάζω live επεξεργασία των arguments που υπάρχουν σε densEnv,dcEnv,scaleEnv με μέθοδο set, δεν ανταποκρίνονται οι αλλαγές. 
Παρόλο που το post window δεν βγάζει error στον υπολογισμό της f, και το μήνυμα play εκτελείται κανονικά.


// Proof:

x = f.play(args:[\fadeIn, 10, \hold, 70, \fadeOut,20]);                 // οκ αρχικά
x.set(\mute, 0.7);                                                     //και εδώ οκ, το πρόβλημα είναι μόνο στις νέες παραμέτρους

x.set(\scale1, 10, \scale2, 50,\scale3, 100);   // Δεν ανταποκρίνεται
x.set(\dc1, 100, \dc2, 110,\dc3, 120);    // ούτε εδώ
x.set(\dens1, 10, \dens2, 50,\dens3, 100);     // ούτε εδώ


// Any ideas? Τι δεν του αρέσει?
