effect effects/levels/storage/drop_pod_intro
{
	size	825

	emitter "mainFill"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	1.1,1.1
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { box -800,-100,-100,-800,100,100 }
				velocity { box 1200,-10,-10,1500,10,10 }
				size { line 80,80,100,100 }
				tint { line 0.74902,0.74902,0.74902,1,1,1 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" count 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 80,80 }
				fade { line 0.4,1 }
				rotate { box -0.833333,0.833333 relative }
			}
		}
	}
	emitter "sideFill1"
	{
		duration	1,1
		count		60,60

		sprite
		{
			duration	0.6,0.6
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { box -800,-400,-250,-800,-150,250 }
				velocity { box 2000,-10,-10,2000,10,10 }
				size { point 150,150 }
				tint { line 0.709804,0.635294,0.576471,1,1,1 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { line 0.3,0.6 }
				rotate { box -0.444444,0.444444 relative }
			}
		}
	}
	emitter "sideFill2"
	{
		duration	1,1
		count		60,60

		sprite
		{
			duration	0.6,0.6
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { box -800,150,-250,-800,400,250 }
				velocity { box 2000,-10,-10,2000,10,10 }
				size { point 150,150 }
				tint { line 0.721569,0.643137,0.596078,1,1,1 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { line 0.3,0.6 }
				rotate { box -0.444444,0.444444 relative }
			}
		}
	}
	emitter "mainFill2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	1.1,1.1
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { point -800,0,0 }
				velocity { box 1200,-10,-10,1500,10,10 }
				size { point 300,300 }
				tint { line 0.576471,0.447059,0.423529,0.890196,0.886275,0.87451 }
				fade { line 0.5,0.8 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box -0.444444,0.444444 relative }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"vehicle_gev_engine_loop"
		volume	0.5,0.5
		freqshift	2,2
	}
	sound "unnamed5"
	{
		soundShader	"ambient_planet_surface05"
		volume	5,5
		freqshift	2,2
	}
	sound "unnamed6"
	{
		soundShader	"convoy_jetfire2"
		volume	0.8,0.8
	}
	shake "unnamed8"
	{
		duration	1,1
		scale		0.2
		attenuateEmitter
	}
	sound "unnamed8"
	{
		soundShader	"battle01_stereo"
	}
}




