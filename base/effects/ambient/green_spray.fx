effect effects/ambient/green_spray
{
	size	462

	emitter "steamcore"
	{
		duration	5.5,5.5
		count		5,10
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				tint { line 0.411765,0.47451,0.0156863,0.384314,0.466667,0.223529 }
				length { point 155,125,155 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 33 }
				length { point 55,100,55 }
			}
		}
	}
	emitter "end"
	{
		duration	5.5,5.5
		count		1.5,1.5

		sprite
		{
			duration	1,10
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.01,0.01
			generatedOriginNormal

			start
			{
				position { line 25,0,0,45,0,0 }
				velocity { box 30,-15,-15,30,15,15 }
				size { box 40,40,60,60 }
				tint { point 0.603922,0.631373,0.164706 }
				fade { point 0 }
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
				size { box 100,100,130,130 }
				fade { point 0.2 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "start"
	{
		duration	5.5,5.5
		count		4,4

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 0,-3,-3,20,3,3 }
				size { box 1,1,2,2 }
				tint { line 0.509804,0.678431,0.337255,0.505882,0.6,0.27451 }
				fade { point 0 }
				rotate { box -0.125,-0.25 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 12,12,20,20 }
				fade { point 0.4 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"putra_fatguy_acid_spray1"
		freqshift	0.3,0.3
	}
	sound "unnamed6"
	{
		soundShader	"putra_fatguy_acid_spray2"
	}
	sound "unnamed6"
	{
		soundShader	"putra_fatguy_acid_spray3"
		freqshift	0.6,0.6
	}
}


