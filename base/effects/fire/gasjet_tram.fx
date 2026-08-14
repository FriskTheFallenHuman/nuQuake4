effect effects/fire/gasjet_tram
{
	size	1384

	emitter "smoke"
	{
		duration	1,1
		count		15,30
		attenuateEmitter

		sprite
		{
			duration	1,3
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.01,0.01
			generatedOriginNormal

			start
			{
				position { point 40,0,0 }
				velocity { box 200,-15,-15,500,15,15 }
				size { line 10,10,20,20 attenuate }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
				fade { point 0 attenuate }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 250,250,500,500 attenuate }
				fade { line 0.4,0.8 attenuate }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "fire"
	{
		duration	1,1
		count		25,30
		attenuateEmitter

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire4a"
			gravity		-0.02,0

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 800,-20,-20,1000,20,20 }
				size { box 30,30,50,50 attenuate }
				fade { point 0 attenuate }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 150,150,200,200 attenuate }
				fade { point 1 attenuate }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		8,10
		attenuateEmitter

		sprite
		{
			duration	0.5,0.75
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.02,0

			start
			{
				position { line 15,-10,-10,15,10,10 }
				velocity { box 800,0,0,1000,0,0 }
				size { line 50,50,70,70 attenuate }
				fade { point 0 attenuate }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 150,150,400,400 attenuate }
				fade { point 1 attenuate }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		30,30
		attenuateEmitter

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.02,0

			start
			{
				position { line 6,-1,-1,6,1,1 }
				velocity { box 300,-10,-10,500,10,10 }
				size { line 50,50,60,60 attenuate }
				tint { line 1,1,1,0.501961,0.501961,1 }
				fade { point 0 attenuate }
				offset { point -50,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 80,80,100,100 attenuate }
				fade { point 1 attenuate }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"effects_fire_gas2"
		freqshift	1.5,1.5
	}
	emitter "heathaze"
	{
		detail		0.4
		duration	1,1
		count		2,2

		sprite
		{
			duration	3,3
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				velocity { box 80,0,0,200,0,0 }
				size { point 400,400 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
	sound "unnamed8"
	{
		soundShader	"effects_fire_pipe"
	}
}









