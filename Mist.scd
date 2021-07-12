s.boot;
s.quit;
s.reboot;

Buffer.freeAll;
s.freeAll;

s.newBusAllocators;
s.options.memSize;
s.options.memSize = 6.pow(9);           // maximizing the available memory space



//      1)                             Arrays/Buffers: Storing basic data (audio files, waveforms,env shapes)

(
// i)  Loading my recorded sounds ..
~rec = Array.new;
~folder = PathName.new("/Users/lefff/OneDrive/Desktop/ΠΤΥΧΙΑΚΗ/Ήχος/SuperCollider/Factory/Records");
(
	    ~folder.entries.do({
		arg path;
	    ~rec = ~rec.add(Buffer.readChannel(s, path.fullPath,channels:[0]));
});
);
)



//       2)                                                     Sources ( SynthDefs / Functions )

(
SynthDef.new(\fmDef, {
	var bufferMap,carr,mod,mRatio,cRatio, indexOfModulation, ratioArray, freqs, tf,synthDur, cBuffer = \cBuf.kr(~b[0].bufnum),mBuffer = \mBuf.kr(~b[1].bufnum);
	synthDur = Env.linen(\att.kr(10),\stay.kr(4),\rls.kr(15),\level.ir(1),\lin).kr(doneAction:2);
	ratioArray = [\r1.kr(1/6), \r2.kr(1/5),\r3.kr(1/4),\r4.kr(1/3), \r5.kr(1/2),\r6.kr(1)];
	freqs = \fund.kr(120) * ratioArray;
	mRatio = Env.circle([\mBottom.kr(1), \mPeak.kr(1)],[\mPer.kr(2),\mReset.kr(5)], \lin).kr(doneAction:2);
	cRatio = Env.circle([\cBottom.kr(1), \cPeak.kr(1)],[\cPer.kr(2),\cReset.kr(5)], \lin).kr(doneAction:2);
	indexOfModulation = freqs * mRatio * \index.kr(1);
	mod = Osc.ar(mBuffer, freqs * mRatio, 0, indexOfModulation);
	carr = Osc.ar(cBuffer,freqs * cRatio + mod, 0, \carrHz.kr(1/5), 0) * synthDur;
	carr = LPF.ar( carr.sum!2, \cutOff.kr(400), 1, 0);
	carr = LeakDC.ar(carr, \dcFilter.kr(0.895), \mute.kr(1/15), 0);
	Out.ar(\out.kr(0),carr);
}).add;
)


//       3)                                                           Products ( Synths/Groups/ Patterns )

(
~m1 = Pbind(
	\instrument, \fmDef,
	\dur, Pser([10], 3),
	\dcFilter, 0.985,
	\att,Pser([10],3) ,\stay, Pser([10,15,10],3) ,\rls, Pser([75,55,50],3),
	\mute, Pser([1/14], 3), \carrHz, Pser([1/11], 3),
	\fund, Pser([110],3), \cutOff, Pser([300],3),
	\mBottom, Pser([1/3],3), \mPeak, Pser([1/3],3),
	\mPer, Pser([10],3), \mRes, Pser([5],3),
	\cBottom, Pser([2/5,4/5,3/5],3), \cPeak, Pser([2/5,4/5,3/5],3),
	\cPer, Pser([10],3), \cRes, Pser([5],3),
);

~m2 = Pbind(
	\instrument, \fmDef,
	\dur, Pser([8], 3), \dcFilter, 0.980,
	\att, Pser([7],3) ,\stay, Pser([0],3) ,\rls, Pser([20,18,16],3),
	\mute, Pser([1/24], 3), \carrHz, Pser([1/7], 3),
	\fund, Pser([250],3), \cutOff, Pser([1000],3),
	\mBottom, Pser([1/6,1/11,1/18],3), \mPeak, Pser([1/6,1/11,1/18], 3),
	\mPer, Pser([2],3), \mRes, Pser([2],3),
	\cBottom, Pser([3], 3), \cPeak, Pser([3], 3),
	\cPer, Pser([2],3), \cRes, Pser([2],3),
);

~m3 = Pbind(
	\instrument, \fmDef,
	\dur, Pser([5], 3), \dcFilter, 0.980,
	\att, Pser([8,6, 4],3) ,\stay, Pser([3],3) ,\rls, Pser([5],3),
	\mute, Pser([1/24,1/27,1/30], 3), \carrHz, Pser([1/7], 3),
	\fund, Pser([4000],3), \cutOff, Pser([700],3),
	\mBottom, Pser([1/17,1/16,1/15],3), \mPeak, Pser([1/17,1/16,1/15], 3),
	\mPer, Pser([2],3), \mRes, Pser([2],3),
	\cBottom, Pser([1/17], 3), \cPeak, Pser([1/17], 3),
	\cPer, Pser([2],3), \cRes, Pser([2],3),
);

~m4 = Pbind(
	\instrument, \fmDef,
	\dur, Pser([5], 4), \dcFilter, 0.980,
	\att, Pser([5,5,3,3],4) ,\stay, Pser([0,0,0],4) ,\rls, Pser([7,9,10,20],4),
	\mute, Pser([1/7], 4), \carrHz, Pser([1/4], 4),
	\fund, Pser([7000,7000,7000,7000],4), \cutOff, Pser([600],4),
	\mBottom, Pser([4/5,4/5,4/5,4/5],4), \mPeak, Pser([4/5,4/5,4/5,4/5], 4),
	\mPer, Pser([2],4), \mRes, Pser([2],4),
	\cBottom, Pser([2,3,1/2,3], 4), \cPeak, Pser([2,3,1/2,3], 4),
	\cPer, Pser([2],4), \cRes, Pser([2],4), \index, Pser([1,1,1,0.25], 4),
);

~m5 = Pbind(
	\instrument, \fmDef,
	\dur, Pser([6,4], 3), \dcFilter, 0.980,
	\att, Pser([3],3) ,\stay, Pser([0,0,0],3) ,\rls, Pser([5,10,10],3),
	\mute, Pser([1/15,1/6,1/13], 3), \carrHz, Pser([1/4], 3),
	\fund, Pser([2000,3000,3000],3), \cutOff, Pser([700,300,700],3),
	\mBottom, Pser([2/5,2,2/5],3), \mPeak, Pser([2/5,2,2/5], 3),
	\mPer, Pser([2],3), \mRes, Pser([2],3),
	\cBottom, Pser([1/3], 3), \cPeak, Pser([1/3], 3),
	\cPer, Pser([2],3), \cRes, Pser([2],3), \index, Pser([1,1,1,1,1], 3),
);
)




//    4)                                                          Compositions  ( Tasks / Routines )


(
~mist = Routine.new({

	~m1.play;
	10.yield;
	~m4.play;
	15.yield;
	~m2.play;
	15.yield;
	~m3.play;
	15.yield;
	~m5.play;

});
)

~mist.play;

(
fork({
});
)

(
{
}.r;
)

(
~r = Routine.new({
});
)

(
~t = Task.new({
});
)


//      5:                                          Notes(Ideas,strategies, creative approaches, afterthoughts )