effect effects/levels/convoy/focus_mflash
{
	size	435

	emitter "flash"
	{
		duration	1,1
		count		3,5
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point -4,0,0 }
				size { point 300,300 }
				tint { point 0.501961,0.501961,1 }
				offset { point 8,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.5,0.5 relative }
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
				size { line 50,50,25,25 }
				tint { point 0.501961,0.501961,1 }
				fade { line 0.5,0.75 }
				offset { point 8,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope circle_pulse3 }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"mcc_landing_charge"
		freqshift	1.3,1.3
	}
}



