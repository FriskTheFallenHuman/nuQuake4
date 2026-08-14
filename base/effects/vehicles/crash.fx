effect effects/vehicles/crash
{
	size	150

	sound "sound"
	{
		soundShader	"effects_weld"
	}
	spawner "smoke"
	{
		start		0.06,0.06
		count		1,1

		sprite
		{
			duration	1,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.12,-0.06
			generatedOriginNormal

			start
			{
				position { line 4,0,12,12,0,12 }
				size { line 1,3,2,4 }
				tint { point 0,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 15,15,100,100 }
				tint { point 0.2,0.176471,0.14902 }
			}
		}
	}
	emitter "sparks_trails"
	{
		duration	0.1,0.1
		count		200,200
		locked
		attenuateEmitter

		sprite
		{
			duration	0.12,0.16
			persist
			material	"gfx/effects/particles_shapes/blank"
			generatedOriginNormal
			trailType	motion
			trailTime	0.1,0.1
			trailCount	3,3

			start
			{
				position { cylinder 0.01,-0.1,-0.1,0.01,0.1,0.1 }
				velocity { box 200,0,0,300,0,0 }
				size { box 0.5,0.5,1,1 }
				tint { point 0.917647,0.858824,0.733333 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				tint { line 0.933333,0.796079,0.32549,0.909804,0.517647,0.384314 }
			}
		}
	}
	spawner "center"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 11,11 }
			}

			motion
			{
				size { envelope random }
			}

			end
			{
				size { point 25,25 }
			}
		}
	}
}




