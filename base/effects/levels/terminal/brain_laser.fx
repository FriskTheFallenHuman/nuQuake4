effect effects/levels/terminal/brain_laser
{
	size	169

	emitter "core_beam"
	{
		duration	1,1
		count		1,1

		line
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/red_beam"

			start
			{
				size { point 30 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
	emitter "pulse"
	{
		duration	1,1
		count		5,5

		line
		{
			duration	0.25,0.35
			blend	add
			material	"gfx/effects/energy_sparks/red_beam_pulse"

			start
			{
				velocity { point 250,0,0 }
				size { box 5,15 }
				length { box 10,0,0,100,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			impact
			{
				remove	1
			}
		}
	}
	emitter "unnamed2"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/spark2_red"

			start
			{
				size { point 20,20 }
				tint { point 1,0.501961,0.501961 }
				rotate { box -1,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { point 0 relative }
			}
		}
	}
	emitter "unnamed4"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/spark2_red"

			start
			{
				position { point 1,0,0 }
				size { point 20,20 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"process_laser_loop"
	}
}








