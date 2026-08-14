effect effects/weapons/rocketlauncher/vent
{
	size	3

	emitter "fast"
	{
		start		0.1,0.1
		duration	0.5,0.5
		count		5,5
		locked

		sprite
		{
			duration	2,2
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 0,-0.4,0 }
				velocity { box 0.25,-0.6,-0.2,0.25,-0.7,0 }
				size { line 0.75,0.75,1,1 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { line 1,1,1.25,1.25 }
				fade { point 1 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "slow"
	{
		start		0.3,0.3
		duration	0.5,0.5
		count		5,5
		locked

		sprite
		{
			duration	2,2
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 0,-0.4,0 }
				velocity { box 0.25,-0.3,-0.1,0.25,-0.4,0.1 }
				size { line 1,1,1.25,1.25 }
				tint { point 0.321569,0.321569,0.321569 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { line 1.25,1.25,1.5,1.5 }
				fade { point 1 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
}




