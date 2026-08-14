effect effects/mp/jumppad
{
	size	179

	emitter "smoke"
	{
		duration	1,1
		count		5,10
		locked

		oriented
		{
			duration	1,2
			material	"gfx/effects/smoke/CLOUD_alpha3"
			gravity		-0.05,-0.05
			generatedNormal

			start
			{
				position { cylinder 0,-32,-32,0,32,32 surface }
				size { point 40,40 }
				tint { point 0.968628,0.623529,0.415686 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope convexfade }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 60,60 }
				fade { point 0.15 }
				rotate { box 0,0,-0.694444,0,0,0.694444 relative }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
		count		16,16

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 1,0,0 }
				velocity { point 75,0,0 }
				size { line 100,100,120,120 }
				tint { point 1,0.501961,0.25098 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 40,40,60,60 }
				fade { point 0.25 }
			}
		}
	}
}
