effect effects/monsters/light_tank/destroy_arm_trail
{
	size	70

	emitter "smoke"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	2,2.5
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.05,-0.05

			start
			{
				position { box 0,-5,0,0,5,5 }
				velocity { box -5,-5,-5,5,5,5 }
				size { line 10,10,15,15 }
				tint { line 0.380392,0.337255,0.278431,0.388235,0.384314,0.270588 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,40,40 }
				fade { point 1 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "sparks_trails"
	{
		duration	1,1
		count		6,6

		sprite
		{
			duration	0.35,0.5
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.5,0.5
			trailType	motion
			trailTime	0.1,0.1
			trailCount	5,5

			start
			{
				velocity { box 0,-150,-150,300,150,150 }
				size { box 2,2,4,4 }
				tint { point 0.913726,0.858824,0.729412 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
				tint { line 0.929412,0.796079,0.321569,0.909804,0.501961,0.364706 }
			}
		}
	}
}





