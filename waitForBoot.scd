s.boot;
s.quit;

s.reboot;

//        Calculating all the necessary data for all my Compositions(shapes,buffers,synthDefs)


(
s.waitForBoot({

s.sync;
Server.freeAll;
s.sync;
s.options.memSize = 6.pow(10);
s.sync;
s.newBusAllocators;
Buffer.freeAll;
s.sync;

// i)  Loading my recorded sounds ..
~rec = Array.new;
~folder = PathName.new("/Users/lefff/OneDrive/Desktop/ΠΤΥΧΙΑΚΗ/Ήχος/SuperCollider/Factory/Records");
(
	    ~folder.entries.do({
		arg path;
	    ~rec = ~rec.add(Buffer.readChannel(s, path.fullPath,channels:[0]));
});
);

s.sync;


// ii) Making buffer arrays for my shapes

~b = Buffer.allocConsecutive(100, s, 4096);     //        0-49 for Osc/VOsc/COsc.ar, 50-99 for Shaper.ar()

s.sync;

~shape = Array.newClear(50);
~tf = Array.newClear(50);

s.sync;

//                                          Normal wavetable format(Osc,COsc,VOsc UGens)

~shape[0] =  Signal.sineFill(
	     2048,
	     [0,1/9,1,1/3,1/3,1/9,1/3,2,1],
	     [0,pi/6,2pi, pi/2,2pi,pi/4, pi,2pi,0]
);
~b[0].loadCollection(~shape[0].asWavetable);

~shape[1] =  Env.new([0,0.25,-0.35,0.15,0.6,-0.45,-0.2,1,-0.5,0.85,0.25,0],[1,3,2,2,6,4,1,3,4,6,7,2],[-1,7,0,12,-10,3,0,2,-2,9,0,1]).asSignal(2048);
~b[1].loadCollection(~shape[1].asWavetable);

~shape[2] = Signal.chebyFill(
	     2048,
	     [0,1/11,1/13,1/5,1/15,1/4,-2/3,1/4,1/14,-1],
	      normalize:true,zeroOffset:true,
);
~b[2].loadCollection(~shape[2].asWavetable);

~shape[3] = Signal.chebyFill(
	     2048,
	     [0,1/17,1/3,-1/5,-1/5,1/2,1/9,1/10,1/7,-1/6,-1/3,0],
	      normalize:true,zeroOffset:true,
);
~b[3].loadCollection(~shape[3].asWavetable);

~shape[4] =  Signal.sineFill(
	     2048,
	     [0,1/5,1,-1/3,1/3,-1/9,1/6,1/3,2,0],
	     [0,pi/6,2pi, pi/2,pi/3,pi/4, pi,2pi,0]
);
~b[4].loadCollection(~shape[4].asWavetable);

~shape[5] =  Env.new([0,1/6,1/7,1/9,1/3,-1/8,-1/3,1/5,1/9,-2/5,1/7,0],[1,7,2,3,11,6,2,2,5,10,5,7],[-1,7,-8,6,10,0,2,-12,9,0,1]).asSignal(2048);
~b[5].loadCollection(~shape[5].asWavetable);

~shape[6] =  Env.xyc([
	[0,0,-18],[2,1/8,9],[4,-1/2,-2],[7, 2/7,-7],[8.5,1,13],[10,-2/5,5],
	[11,-1/3,-2],[15,1/7,-12],[16,-1/4,10],[18,1/5,-16],[10,2/5,7],[11,-1/3,20],
]);
~b[6].loadCollection(~shape[6].discretize(2048).asWavetable);

~shape[7] =  Env.pairs([
	[0,0],[2,1/3],[3,1/7],[4.5,-2/7],[6,1/3],[9,1/7],
	[10,0],[12,1/2],[15,-1/5],[16.5,0],[19,2.5/3],[23,1/9],
], [-17,6,-2,11,9,-8,0,16,-19,2,-3,6]).asSignal(2048);
~b[7].loadCollection(~shape[7].asWavetable);

~shape[8] = Signal.chebyFill(
	     2048,
	     [0,1/9,-2/8,-4/6,-1/3,2/5,-5/3,1/2,1/7,2/6,-1/8,1/9,1/6,2/7,2/6,-1/8,0],
	      normalize:true,zeroOffset:true,
);
~b[8].loadCollection(~shape[8].asWavetable);

~shape[9] =  Signal.sineFill(
	     2048,
	     [0,1/6,1/2,-1/3,1/5,1/9,-3/5,-6/7,2/5,0],
	     [0,2pi,pi,pi/6,pi/3,pi/2,pi,3pi/2,0]
);
~b[9].loadCollection(~shape[9].asWavetable);

~shape[10] =  Env.xyc([
	[0,0,13],[2,1/7,5],[3.5,-4/6,-13],[4,1/3,4],[6,2/3,11],[10,0,-16],
	[11,1/5,3],[15,1/7,15],[18,-2/6,-11],[20,-1/3,14],[26,-2/3,-11],[30,0,19],
	[32,1/11,-3],[34,1/7,5],[37,4/6,-11],[40,-1/3,4],[46,-2/3,7],[50,0,-16],
]).asSignal(2048);
~b[10].loadCollection(~shape[10].asWavetable);

~shape[11] = Env.new([0,1,0.3,0,-1,0.4,-0.3,0],[1,2,1,2,1,1,1],[1,6,-4,4,2,-9,4]).discretize(2048).asWavetable;
~b[11].sendCollection(~shape[11]);

~shape[12] = Env.new([0,0.3,-0.2,0.9,0.6,-0.5,0],[1,1,3,1,4,1],[1,-7,5,-13,0,3]).discretize(2048).asWavetable;
~b[12].sendCollection(~shape[12]);

~shape[13] = Env.new([0,0.1,-0.2,-0.6,0.3,0.9,-0.4,0],[1,2,1,3,1,4,1],[11,-5,0,-6,7,9,2]).discretize(2048).asWavetable;
~b[13].sendCollection(~shape[13]);

~shape[14] = Env.new([0,0.3,0.4,-0.8,0.1,0.7,-0.2,-0.8,0.6,0],[1,2,3,6,3,5,1,4,1],[1,-7,-2,0,6,5,-8,-7,3]).discretize(2048).asWavetable;
~b[14].sendCollection(~shape[14]);

~shape[15] = Env.new([0,-0.4,-0.8,0.1,0.7,-0.5,0.2,-0.6,-0.3,0],[2,1/4,1,1/2,2,6,3,5,1],[0,6,11,-12,15,-4,2,5,-4]).discretize(2048).asWavetable;
~b[15].sendCollection(~shape[15]);

~shape[16] = Env.new([0,-0.3,0.1,0.5,-0.1,-0.7,0.3,0.8,0.7,0],[1,2,3,4,1,2,3,2,1],[0,13,-12,7,5,-4,15,-9,-1]).discretize(2048).asWavetable;
~b[16].sendCollection(~shape[16]);

~shape[17] = Env.new([0,0.3,0.7,-0.2,0.9,-0.2,0.4,-0.6,0.1,0],[1,3,4,3,2,5,2,1,4],[0,4,12,-7,6,10,2,-12,7]).discretize(2048).asWavetable;
~b[17].sendCollection(~shape[17]);

~shape[18] = Env.new([0,0.1,0.5,-0.6,-0.8,0,0.4,0.7,0.5,0],[1,3,2,3,2,4,2,1,4],[0,4,12,-7,6,-4,2,-12,7]).discretize(2048).asWavetable;
~b[18].sendCollection(~shape[18]);

~shape[19] = Env.new([0,0.9,0.3,-0.4,-0.8,0.5,0.1,-0.6,0.8,0],[5,2,2,3,1,4,1,2,4],[-2,4,12,-7,6,-4,2,-12,7]).discretize(2048).asWavetable;
~b[19].sendCollection(~shape[19]);

~shape[20] = Env.new([0,0.6,0.8,-0.1,0.5,-0.5,0.1,0.6,-0.4,0],[5,2,2,3,1,4,1,2,4],[-2,4,12,-17,6,-7,2,-12,7]).discretize(2048).asWavetable;
~b[20].sendCollection(~shape[20]);

~shape[21] = Env.new([0,0.2, -0.3, 0.1, 0.7, 0.5, -0.5, -0.9,0.2,0],[3,6,4,3,1,2,3,2,4],[-2,4,12,-7,6,-4,2,-12,7]).discretize(2048).asWavetable;
~b[21].sendCollection(~shape[21]);

~shape[22] = Env.new([0,-0.6,0.2, -0.3, 0.3, 0.2, 0.8, 0, -0.6,0.4,0],[2,3,5,2,3,3,3,3,2,6],[0,-7,6,12,-7,6,-4,2,-12,7]).discretize(2048).asWavetable;
~b[22].sendCollection(~shape[22]);

~shape[23] = Env.new([0,-0.4,0.5, -0.8, 0.1, 0.2, 0.4, 0, -0.6,0.1,0],[2,3,5,1,4,3,2,7,2,6],[0,7,-11,12,-2,6,-1,2,-9,7]).discretize(2048).asWavetable;
~b[23].sendCollection(~shape[23]);

~shape[24] = Env.xyc([
	[0, 0, 0],[2, -0.2, 4],[6, 0.7, 3],[9, 0.9, 0],[10, -0.2, 14],[16, -0.6, 3],
	[17, 0.1, 10],[19, -0.5, -8],[21, -0.7, 13],[24, 0.9, -9],[25, -0.2, 14],[30, -0, 3],
]).discretize(2048).asWavetable;
~b[24].sendCollection(~shape[24]);

 ~shape[25] = Env.xyc([
	[0, 0, 0],[5, -0.4, 4],[6, 0.25, 13],[8, 0.6, 0],[12, 0.9, -6],[13, -0.4, 7],
	[16, 0.1, -11],[19, -0.8, 8],[20, 0.75, 13],[25, 0.3, -9],[28, 0.6, 14],[33, -0, -7],
]).discretize(2048).asWavetable;
~b[25].sendCollection(~shape[25]);

  ~shape[26] = Env.xyc([
	[0, 0, 0],[2, -0.7, 4],[3, 0.4, 13],[8, 0.9, 0],[10, 0.2, -6],[11, 0.8, 7],
	[13, 0.1, -6],[15, -0.5, 18],[20, -0.9, 0],[22, 0.3, -9],[24, 0.6, 12],[28, -0, 2],
]).discretize(2048).asWavetable;
~b[26].sendCollection(~shape[26]);

  ~shape[27] = Env.pairs([
	[0, 0],[6, 0.7],[8,0.2],[11, 0.45],[13,-0.6],[15, -0.3],[18, 0.5], [22, 0.75],[24, 0],
	[26, 0.6],[28, -0.3],[30, 0]
], [0,1,12,-6,7,8,-9,-4,10,-9, -2, 4]).discretize(2048).asWavetable;
~b[27].sendCollection(~shape[27]);

 ~shape[28] = Env.xyc([
	[0, 0, 0],[3, 0.6, 13],[5, 0.2, -3],[7, 0.75, 3],[8.5, 0.2, 17],
	[11, -0.65, -7],[16, 0.85, 8],[17, 0.35, -8],[20, -0.3, -6],
	[22, -0.3, 13],[24, 0.65, 9],[28, -0.25, 8],[30, 0, -1]
]).discretize(2048).asWavetable;
~b[28].sendCollection(~shape[28]);

 ~shape[29] = Env.xyc([
	[0, 0, 0],[2, 0.3, 13],[4, -0.2, -3],[7, 0.9, -10],[10, 0.2, 7],
	[12, 0.65, 14],[15, 0.4, -8],[18, -0.4, 6],[22, 0.1, -6],
	[25, -0.3, 13],[27, 0.3, -1],[29, -0.75, 3],[30, 0, -1]
]).discretize(2048).asWavetable;
~b[29].sendCollection(~shape[29]);

 ~shape[30] = Env.xyc([
	[0, 0, 0],[3, 0.3, 13],[5, 0.6, -3],[7, 0.55, 3],[8.5, 0.2, 7],
	[11, 0.65, -7],[13, 0.85, 10],[17, -0.4, -8],[20, 0.3, -6],
	[22, -0.2, 2],[25, 0.3, -11],[28, -0.45, 2],[30, 0, -1]
]).discretize(2048).asWavetable;
~b[30].sendCollection(~shape[30]);

~shape[31] = Env.xyc([
	[0, 0, 0],[1, 0.3, 3],[5, 0.7, 11],[7, 0.9, -8],[10, 0.2, 6],
	[13, -0.3, -9],[14, 0.6, 19],[20, -0.4, 16],[22, -0.1, 5],[25, -0.6, -7],
	[30, -0.3, 13],[34, 0.7, 18],[39, 0.2, 5],[40, 0, -4]
]).discretize(2048).asWavetable;
~b[31].sendCollection(~shape[31]);

 ~shape[32] = Env.xyc([
	[0, 0, 0],[1, 0.3, 3],[4, 0.7, 11],[6, 0.9, -8],[9, 0.2, -6],
	[11, -0.3, 9],[15, -0.5, -8],[16, 0.4, 15],[18, -0.6, 9],[21, 0.1, -7],
	[23, 0.3, 3],[27, 0.6, -8],[30, -0.3, 12],[35, 0, -4]
]).discretize(2048).asWavetable;
~b[32].sendCollection(~shape[32]);

  ~shape[33] = Env.xyc([
	[0, 0, 0],[2, 0.3, 4],[5, 0.7, 11],[6, 0.9, -14],[10, 0.2, 6],
	[13, -0.3, 2],[15, -0.5, 8],[17, 0.4, -15],[20, -0.6, 9],[24, 0.1, -7],
	[27, 0.3, 3],[32, 0.6, -8],[34, -0.3, 12],[38, -0.75, -13],[40, 0, -2]
]).discretize(2048).asWavetable;
~b[33].sendCollection(~shape[33]);

   ~shape[34] = Env.pairs([
	[0, 0],[2, 0.8],[6,0.4],[9, 0.65],[13,-0.2],[16, -0.7],[21, 0.5], [24, 0.25],[25, 0],
	[27, 0.6],[32, -0.3],[35, 0],[38, 0.4],[42, -0.7],[45, 0],
], [0,-7,12,-6,7,8,-9,-1,-10,9, -2, 14,-5,6,8]).discretize(2048).asWavetable;
~b[34].sendCollection(~shape[34]);

   ~shape[35] = Env.new(levels:[0,0.2, -0.3, 0.2,0.8,0.6,-0.1,0.7,0.3, -0.2, 0.1, 0.5,-0.8,-0.4,0],
	times: [1,1,3,2,5,4,1,2,1,7,8,1,6,1], curve: [0,3,7,2,-13,4,-17,12,1,9,4,0,5,0]).discretize(2048).asWavetable;
  ~b[35].sendCollection(~shape[35]);

s.sync;


//                                        Transfer Functions (Shaper UGen)

~tf[0] = Signal.sineFill(
	  2049,
	  [0,-1/4,1/3,1/2,-1/5,1/8,4/7,0],
	  [0,pi,pi/6,-pi,pi,3pi/4,-pi,0]
);
~b[50].loadCollection(~tf[0].asWavetableNoWrap);

~tf[1] = Signal.chebyFill(
	    2049,
	[0, -1/3, 1/2, 1/5,-1/4, 0],
	normalize: true, zeroOffset:true
);
~b[51].loadCollection(~tf[1].asWavetableNoWrap);

~tf[2] = Signal.newClear(2049);
~tf[2].waveFill({
   arg x, z, cnt;
   var out;
	out = sin(x).cubed.fold(-1, 1);
}, 0, 4pi);
~b[52].loadCollection(~tf[2].asWavetableNoWrap);

~tf[3] = Signal.chebyFill(
	    2049,
	[0, 1/6,1/7, -1/4,1/3,-1/5,-1/8, 1/11,1/2, 1/5,-1/4, 0],
	normalize: true, zeroOffset:true
);
~b[53].loadCollection(~tf[3].asWavetableNoWrap);

~tf[4] = Signal.chebyFill(
	    2049,
	[0, -1/4,1/5, -1/4,1/3,1/5,-1/8,-1/11,1/2, 1/5,-1/4, 0],
	normalize: true, zeroOffset:true
);
~b[54].loadCollection(~tf[4].asWavetableNoWrap);

~tf[5] = Signal.chebyFill(
	    2049,
	[0, 1/11,-2/9,-4/8,-4/6,-1/9,3/11,-2/7,1/7,1/4,-1/5,-1/9,1/4,-2/5,1/6,1/2,0],
	normalize: true, zeroOffset:true
);
~b[55].loadCollection(~tf[5].asWavetableNoWrap);

~tf[6] = Signal.chebyFill(
	    2049,
	[0,-1/10,1/12,1/7,1/8,-1/3,-1/6,1/8,1/5,1/3,1/2,4/5,1,-0.95,-0.65,1/5,0],
	normalize: true, zeroOffset:true
);
~b[56].loadCollection(~tf[6].asWavetableNoWrap);

~tf[7] = Signal.sineFill(
	    2049,
	[0,-3/8,-3/9,-2/11,-7/11,-4/11,3/5,1/7,-1/9,0],
	[0,pi/3,pi/4,-pi/2,pi,2pi/4,-pi,0]
);
~b[57].loadCollection(~tf[7].asWavetableNoWrap);

~tf[8] = Signal.sineFill(
	    2049,
	[0,-4/5,2/7,2/9,3/11,1/2,-1/6,1/7,-2/3,0],
	[0,pi/7,pi/6,-pi/3,pi/4,pi/9,pi/3,3pi/4,2pi/3,-pi,0]
);
~b[58].loadCollection(~tf[8].asWavetableNoWrap);

	~tf[9] = Signal.sineFill(
	    2049,
	[0,-4/5,2/7,2/9,3/11,1/2,-1/6,1/7,-2/3,0],
	[0,0,0,0,0,0,0,0,0,0,0]
);
~b[59].loadCollection(~tf[9].asWavetableNoWrap);

~tf[10] = Signal.sineFill(
	    2049,
	[0,3/5,-2/7,2/9,8/11,3/2,-1/3,5/7,-2/5,0],
	[pi,0,pi/4,pi,pi/3,pi/5,pi,pi/7,3pi,pi,2pi]
);
~b[60].loadCollection(~tf[10].asWavetableNoWrap);


~tf[11] = Signal.chebyFill(
	    2049,
	[0,-0.7,0.2,-0.9,1/3,-0.8,-0.2,-0.6,0.1,0.3,-0.2,0.6,-0.4,-1/5,-0.7,0.8,0.9,0.25,-0.1,0],
	normalize: true, zeroOffset:true
);
~b[61].loadCollection(~tf[11].asWavetableNoWrap);

	~tf[12] = Signal.chebyFill(
	    2049,
	[0,-1/11,-1/9,1/9,1/7,1/11,1/5,-1/9,-1/11,1/13,1/15,-1/5,-1/3,1/9,1/7,1/11,-1/2,0],
	normalize: true, zeroOffset:true
);
~b[62].loadCollection(~tf[12].asWavetableNoWrap);

~tf[13] = Signal.sineFill(
	    2049,
	[0,1/17,1/11,1/9,-1/3,1/5,-1/7,1/3,1/9,-1/5,0],
	[0,pi,pi/3,pi/5,2pi,pi/7,-pi/2,pi/4,pi/11,-2pi/7,0]
);
~b[63].loadCollection(~tf[13].asWavetableNoWrap);

~tf[14] = Signal.sineFill(
	 2049,
	[0,1/17,1/11,1/9,-1/3,1/5,-1/7,1/3,1/9,-1/5,0],
	[0,pi/3,pi/5,pi/8,pi/2,pi/3,0,0,pi,0]
);
~b[64].loadCollection(~tf[14].asWavetableNoWrap);

~tf[15] = Signal.chebyFill(
	2049,
	[0,1/5,1/9,-1/5,1/6,1/4,-1/7,1/5,1/9,-1/5,0],
	normalize: true, zeroOffset:true
);
~b[65].loadCollection(~tf[15].asWavetableNoWrap);

s.sync;

	// my SynthDefs

(

	SynthDef.new(\tf1, {
	var  rawSignal,valueBox,tFunc,output,fundGraph,ampGraph, tfBuffer = \tf.kr(~b[50]), period1 = \prd1.kr(4),period2 = \prd2.kr(4), period3 = \prd3.kr(4), resetPeriod = \resetPrd.kr(4), phase1 = \ph1.kr(90), phase2 = \ph2.kr(90), phase3 = \ph3.kr(90),   phase4 = \ph4.kr(90);
	 valueBox =  [
		\r1.kr(1),\r2.kr(1/2),\r3.kr(1/3),
		\r4.kr(1/4),\r5.kr(2/3),\r6.kr(2/5),
	];
	fundGraph = Env.circle([phase1,phase2,phase3,phase4],[period1,period2,period3,resetPeriod],[0,0,0,0]).kr(timeScale:1,doneAction:2);
	ampGraph = Env.linen(\up.kr(11), \stay.kr(5), \down.kr(15)).kr(doneAction:2);
	rawSignal= LFTri.ar(fundGraph * valueBox);  // multichannel expansion
	tFunc = Shaper.ar(tfBuffer, rawSignal, 1, 0) * ampGraph;
	output = LPF.ar( tFunc, \cut.kr(300),0.5, 1, 1, 0);
	output = LeakDC.ar(Mix.new(output), \cutDC.kr(0.975), \ampVal.kr(1/20));
	Out.ar(\out.kr(0), output);
}).add;

   SynthDef.new(\tf2, {
	var freqBox,initial,tFunc,ampGraph,output,oscBuffer = \main.kr([~b[10]]),tfBuffer = \tf.kr([~b[50]]);
	freqBox = [\frq1.kr(90),\frq2.kr(110),\fr3.kr(300),\frq4.kr(200)];
	ampGraph = Env.linen(\up.kr(11), \stay.kr(5), \down.kr(15)).kr(doneAction:2);
	initial = Osc.ar(oscBuffer, freqBox, 0, 3/4, 0);
	tFunc = Shaper.ar(tfBuffer, initial, 1, 0);
	output = LPF.ar(tFunc.sum, \cut.kr(500), \ampHeight.kr(1/30), 0);
	Out.ar(\out.ir(0), output * ampGraph);
}).add;

	SynthDef.new(\src, {
arg out=0,amp=0.0, da=2, freq=100,pan=0,gate=1,cv=3,att=0.0,sst=0.0,rls=0.0,dR= 0.1;
var sig,env,dtn;
env = EnvGen.kr(
		Env.linen(att,sst,rls,1,cv),
		gate,
		doneAction:da);
dtn = LFNoise1.kr(0.10!7).bipolar(dR).midiratio;
sig = LFTri.ar(freq * dtn);
sig = sig * env;
sig = sig.sum;
sig = Pan2.ar(sig,pan,amp);
Out.ar(out,sig);
}).add;

SynthDef.new(\src2, {
	var output,mod,env,densEnv, fund = \freq.ir(200), cRatio = \cRatio.ir(1), mRatio = \mRatio.ir(1);
	densEnv = Env.new([1,\iMax.ar(3),1],[\densAtt.ir(2),\densRel.ir(4)],[\dc1.ir(2),\dc2.ir(-2)]).kr(doneAction:0);
	env = Env.new([0,1,1,0],[\fadeIn.ir(2),\sus.ir(1),\fadeOut.ir(4)],[\c1.ir(2),\c2.ir(3),\c3.ir(-4)]).kr(doneAction:2);
	mod = Saw.ar(fund * mRatio, 0, mul:(fund * mRatio) * densEnv);
	output = VarSaw.ar(fund * cRatio + mod, 0);
	output = GVerb.ar(output, \rSize.ir(10),\revT.ir(3),\damp.ir(1/2),0.5,15,\dryL.ir(1),\earlyL.ir(0.7),\tailL.ir(1/2),300);
	output = LPF.ar(output, 700);
	output = output * env;
	output = Pan2.ar(output, \pan.ir(0),\amp.ir(1/10));
	output = Out.ar(\out.kr(0),output);
}).add;

SynthDef.new(\src3, {
	var output,mod,env,densEnv, fund = \freq.ir(200), cRatio = \cRatio.ir(1), mRatio = \mRatio.ir(1);
	densEnv = Env.new([1,\iMax.ar(3),1],[\densAtt.ir(2),\densRel.ir(4)],[\dc1.ir(2),\dc2.ir(-2)]).kr(doneAction:0);
	env = Env.new([0,1,1,0],[\fadeIn.ir(2),\sus.ir(1),\fadeOut.ir(4)],[\c1.ir(2),\c2.ir(3),\c3.ir(-4)]).kr(doneAction:2);
	mod = LFPar.ar(fund * mRatio, 0, mul:(fund * mRatio) * densEnv);
	output = SinOsc.ar(fund * cRatio + mod, 0);
	output = GVerb.ar(output, \rSize.ir(10),\revT.ir(3),\damp.ir(1/2),0.5,15,\dryL.ir(1),\earlyL.ir(0.7),\tailL.ir(1/2),300);
	output = output * env;
	output = Pan2.ar(output, \pan.ir(0),\amp.ir(1/10));
	output = Out.ar(\out.kr(0),output);
}).add;

 SynthDef.new(\src4, {   // for Granular Synthesis
	arg rate=1,buf=0,gDur = 0.1,pan=0,amp=0.1,out=0,spos=0, dens=1,att=1,sust=0.5,rls=2,tScale=1,gate=1,cv=2;
	var signal,env;
	env = EnvGen.kr(
		Env.new([0,1,1,0],[att,sust,rls],cv),
		gate,1,0,tScale,doneAction:2);
	signal = GrainBuf.ar(2,Impulse.ar(dens),gDur,buf,BufRateScale.ir(buf) * rate,spos,2,pan,-1,512,amp);
	signal = signal * env;
	Out.ar(out,signal);
}).add;

	SynthDef.new(\granDef, {
    var  iRate, iDur, totalFrames, synthDur,rateEnv, delay,grains, firstFrame, lastFrame, activeArea, buffer = \buffer.kr(0);
	iRate = BufRateScale.ir(buffer);
	totalFrames = BufFrames.ir(buffer);
	iDur = BufDur.ir(buffer);
	synthDur = Env.sine(\sineDur.kr(10), 1).kr(doneAction:2);
	rateEnv = Env.circle([\r1.kr(2),\r2.kr(1),\r3.kr(1),\r4.kr(1)], [\t1.kr(1),\t2.kr(2),\t3.kr(2),\rTime.kr(3)], \lin).kr(doneAction:2);
	firstFrame = ( totalFrames - totalFrames ) + \start.kr(0);
	lastFrame = totalFrames - \end.kr(0);
	activeArea = Phasor.ar(0, iRate *  \warp.kr(1) , firstFrame, lastFrame, 0) / totalFrames;
	grains = GrainBuf.ar(
		numChannels:2,
		trigger: Impulse.kr(\dens.kr(1)),
		dur: \gDur.kr(1/10),
		sndbuf: buffer,
		rate: iRate * rateEnv,
		pos: activeArea,
		interp: 2,
		pan: \pan.ir(0),
		envbufnum: -1,
		maxGrains: 512,
		mul: 1,
		add: 0
	);
	grains = LeakDC.ar(grains, 0.995, 1, 0) * synthDur;
    delay = CombN.ar(grains, \maxDel.kr(2),\del.kr(1/7),\dec.kr(1), \amp.kr(1), 0);
	grains = grains.blend(delay, \mix.kr(1/2));
	grains = BHiPass.ar(grains, \cut.kr(600), \rq.kr(1/2), 1, 0);
	Out.ar(\outBus.ir(0), grains!2);
}).add;
)
});
)

~rec[4].numFrames;