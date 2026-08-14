effect effects/levels/terminal/brain_electricity
{
	size	15

	emitter "core2"
	{
		duration	1,1
		count		1,1

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue"

			start
			{
				size { box 10,15 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope linear }
			}
		}
	}
}




