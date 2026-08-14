effect effects/ships/marine_fighter_engine
{
	size	632

	emitter "smoke"
	{
		duration	0.75,0.75
		count		4,4

		sprite
		{
			duration	2,2
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 20,-5,-5,40,5,5 }
				size { point 50,50 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				offset { point 30,0,0 }
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
				size { point 400,400 }
				tint { point 0.501961,0.501961,0.501961 }
				fade { point 0.5 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "side_streaks"
	{
		duration	1,1
		count		20,20
		locked
		attenuateEmitter

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"
			generatedOriginNormal

			start
			{
				position { cylinder 0.5,-0.5,-0.5,0.5,0.5,0.5 surface }
				size { point 30 attenuate }
				tint { point 0.333333,0.333333,1 }
				fade { point 0 attenuate }
				length { box 80,0,0,100,0,0 attenuate }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 1 attenuate }
				length { box 120,0,0,150,0,0 attenuate }
			}
		}
	}
	emitter "line"
	{
		duration	1,1
		count		10,10
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				position { point -20,0,0 }
				size { box 25,35 }
				length { box 175,0,0,200,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 225,0,0,275,0,0 }
			}
		}
	}
	emitter "flash"
	{
		duration	1,1
		count		3,3
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				velocity { box 10,0,0,50,0,0 }
				size { point 50,50 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
}

