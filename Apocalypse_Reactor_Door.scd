//Here is SoundFX Instrument that imagines a storm being held at bay by a door that is controlled by your mouseY position. You are in a post-apocalyptic nuclear fallout world, there's a storm outside, and you are inside a nuclear reactor building with the ability to close/open the door by moving your mouse up and down.

//Don't forget to start your sound engine by hitting Command-B.

//Add the Sound to the library by highlighting the following block and hitting Command-Enter.
SynthDef("Sound",{
	arg storm;
	var stormFx,reactor,output;
	reactor = LPF.ar(LFTri.ar(MouseY.kr(50,38)),100,0.13);
	stormFx = Resonz.ar(WhiteNoise.ar,MouseY.kr(20,800),0.2,storm);
	stormFx = stormFx + Dust.ar(10,storm*0.15);
	stormFx = stormFx + LPF.ar(CombN.ar(stormFx,1,0.55,5,storm*0.5),5000);
	stormFx = FreeVerb.ar(stormFx,0.5,1,0.7,storm);
	output = reactor + stormFx;
	output = Pan2.ar(output);
	Out.ar(0,output*3);
}).add;

//The storm routine. Do the same as above, highlight the statement and hit Command-Enter.
~stormBegins=Routine({
		var stormComing;
		stormComing = 0.01;
		99.do{
		~reactorOn.set(\storm,stormComing);
		stormComing = stormComing + 0.01;
		stormComing.postln
		(0.45).wait;
	};
});

//Turn on the reactor.
~reactorOn=Synth("Sound",[\storm,0.0]);

//Storm is coming. Start it up by clicking in the line below and hitting Command-Enter. Close the door!
~stormBegins.reset; ~stormBegins.play;


	