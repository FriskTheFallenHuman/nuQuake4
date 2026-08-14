effect effects/monsters/repair_bot/gen_laser_impact
{
	size	85

	emitter "fans"
	{
		duration	1,1
		count		20,20
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/red_beam_pulse"
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-0.1,-0.1,0.1,0.1,0.1 }
				tint { line 1,1,0.768628,1,1,0 }
				fade { point 0.8 }
				offset { point -1,0,0 }
				length { point 5,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { point 30,0,0 }
			}
		}
	}
	emitter "light"
	{
		duration	1,1
		count		2,2
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 5,5 }
				tint { line 1,1,0,1,0.501961,0.25098 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 25,25,35,35 }
			}
		}
	}
	emitter "light2"
	{
		duration	1,1
		count		2,2
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 5,5 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 20,20,60,60 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		5,5

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 1,0,0 }
				size { line 5,5,10,10 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 20,20,50,50 }
			}
		}
	}
}




