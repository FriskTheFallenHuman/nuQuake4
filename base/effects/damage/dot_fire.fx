effect effects/damage/dot_fire
{
	size	84

	sound "sound"
	{
		soundShader	"effects_fire_small"
	}
	emitter "smoke"
	{
		duration	0.5,0.5
		count		10,20

		sprite
		{
			duration	3,5
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { cylinder 0,-30,-30,30,30,30 }
				acceleration { point 0,0,10 }
				size { line 8,8,12,12 }
				tint { point 0.317647,0.282353,0.2 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { line 0.25,0.75 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	spawner "fire3"
	{
		count		5,5

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder -40,-10,-10,40,10,10 }
				velocity { box 0,-5,-5,0,5,5 }
				angle { box 0,0,0,1,1,1 }
				acceleration { point 0,0,10 }
				size { box 5,5,8,8 }
				fade { point 0 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "edgealpha" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 1,1,4,4 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	0.5,0.5
		count		5,5

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder -10,-10,-10,10,10,10 }
				angle { box 0,0,0,1,1,1 }
				acceleration { point 0,0,10 }
				size { box 4,4,8,8 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 1,1,3,3 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}

