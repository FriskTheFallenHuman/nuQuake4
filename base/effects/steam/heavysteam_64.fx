effect effects/steam/heavysteam_64
{
	size	157

	sound "sound"
	{
		soundShader	"effects_blowtorch"
	}
	emitter "steam"
	{
		duration	1,1
		count		4,6

		sprite
		{
			duration	0.75,1
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		0.06,0.16

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 30,-10,-10,120,10,10 }
				size { box 10,10,20,20 }
				tint { point 0.682353,0.67451,0.568627 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 60,60,70,70 }
				fade { point 0.3 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "steam2"
	{
		duration	1,1
		count		4,6

		sprite
		{
			duration	0.75,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.06,0.16

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 30,-10,-10,120,10,10 }
				size { box 10,10,20,20 }
				tint { point 0.682353,0.67451,0.568627 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 60,60,70,70 }
				fade { point 0.3 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
}




