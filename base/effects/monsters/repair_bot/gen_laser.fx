effect effects/monsters/repair_bot/gen_laser
{
	size	78

	emitter "core_beam"
	{
		duration	1,1
		count		1,1
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/red_beam"
			tiling	16

			start
			{
				size { point 5 }
				tint { point 1,1,0 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
	emitter "pulse"
	{
		duration	1,1
		count		5,5
		locked

		line
		{
			duration	0.15,0.15
			blend	add
			persist
			material	"gfx/effects/energy_sparks/red_beam_pulse"

			start
			{
				velocity { box 200,0,0,350,0,0 }
				size { box 2,5 }
				length { box 5,0,0,50,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}
		}
	}
	emitter "fans"
	{
		duration	1,1
		count		20,20
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			persist
			material	"gfx/effects/energy_sparks/red_beam_pulse"
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-0.1,-0.1,0.1,0.1,0.1 }
				tint { line 1,1,0.768628,1,1,0 }
				fade { point 0.8 }
				offset { point -2,0,0 }
				length { point 5,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { point 20,0,0 }
			}
		}
	}
	emitter "light"
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
				size { point 5,5 }
				fade { point 0.8 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 6,6,30,30 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"repair_bot_charge"
	}
}






