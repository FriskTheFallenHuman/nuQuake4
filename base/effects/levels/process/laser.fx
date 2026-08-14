effect effects/levels/process/laser
{
	size	124

	spawner "core_beam"
	{
		count		1,1

		line
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/blue_beam2"

			start
			{
				size { point 30 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope senescrollightable }
			}

			end
			{
				size { point 10 }
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
				velocity { point 350,0,0 }
				size { box 10,20 }
				length { box 10,0,0,50,0,0 }
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

