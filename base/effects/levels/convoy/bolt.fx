effect effects/levels/convoy/bolt
{
	size	708

	spawner "flash"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point -4,0,0 }
				size { point 250,250 }
				tint { point 0.501961,0.501961,1 }
				offset { point 8,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	spawner "deform"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	0.35,0.35
			blend	add
			material	"gfx/effects/energy_sparks/explosion_deform_bolt"

			start
			{
				size { point 500,500 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	emitter "flash2"
	{
		duration	1,1
		count		4,4
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { point -4,0,0 }
				size { line 150,150,100,100 }
				tint { point 0.501961,0.501961,1 }
				fade { line 0.5,0.75 }
				offset { point 8,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope circle_pulse3 }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		5,5
		locked

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	halfsintable
			material	"gfx/effects/energy_sparks/energy1"
			generatedOriginNormal

			start
			{
				position { sphere -1,-1,-1,1,1,1 surface }
				size { point 2 }
				length { box 100,0,0,150,0,0 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"mcc_landing_bolt"
		freqshift	1.5,1.5
	}
}



