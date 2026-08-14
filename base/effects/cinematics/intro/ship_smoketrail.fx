effect effects/cinematics/intro/ship_smoketrail
{
	size	70

	sound "sound"
	{
		soundShader	"effects_fire_small"
	}
	emitter "smoke"
	{
		duration	20,20
		count		120,120

		line
		{
			duration	2,3
			material	"gfx/effects/smoke/soft_alpha_trail.tga"

			start
			{
				velocity { box -5,-5,-5,5,5,5 }
				size { box 2,5 }
				tint { line 0.568627,0.564706,0.486275,0.254902,0.247059,0.203922 }
				fade { point 0 }
				offset { point -20,0,0 }
				length { point 30,0,0 }
			}

			motion
			{
				size { envelope cosine count 0.8 offset 0.2 }
				fade { envelope fast_in_slow_out }
			}

			end
			{
				size { box 6,8 }
				fade { point 0.4 }
			}
		}
	}
	emitter "smoke2"
	{
		duration	20,20
		count		60,60

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { sphere -10,-2,-2,0,2,2 }
				size { line 4,4,6,6 }
				tint { line 0.380392,0.380392,0.337255,0.333333,0.329412,0.258824 }
				fade { point 0 }
				offset { point 0.65,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { line 2,2,4,4 }
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "bright trail"
	{
		duration	20,20
		count		200,200

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { point 1,0,0 }
				size { line 4,4,6,6 }
				fade { point 0.2 }
				offset { point -2,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 2,2,3,3 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}





