effect effects/levels/terminal/distort
{
	size	725

	emitter "unnamed0"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.5,0.5
			material	"gfx/effects/energy_sparks/explosion_deform"

			start
			{
				position { point 1,0,0 }
				size { point 100,100 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 512,512 }
			}
		}
	}
}
