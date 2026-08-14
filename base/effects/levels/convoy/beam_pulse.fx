effect effects/levels/convoy/beam_pulse
{
	size	932

	emitter "Pulse"
	{
		duration	1,1
		count		6,6

		sprite
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/flash_blue.tga"

			start
			{
				position { line 0,0,0,30,0,0 }
				velocity { box 280,0,0,300,0,0 }
				angle { point 0,0,0.5 }
				size { line 400,500,40,80 }
				fade { point 0 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0.25,-0.25 }
			}

			motion
			{
				fade { envelope decalfade }
				offset { envelope sintable }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.5 }
				offset { box 0,-5,-5,0,5,5 }
				angle { box 0,0,0,0,0,1 }
			}
		}
	}
	spawner "Startglow"
	{
		count		1,1

		sprite
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/flash_blue.tga"

			start
			{
				position { point 10,0,0 }
				size { point 400,800 }
				fade { point 0 }
			}

			motion
			{
				fade { envelope decalfade }
			}

			end
			{
				fade { point 0.5 }
			}
		}
	}
	emitter "unnamed10"
	{
		duration	1,1
		count		1,1

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash_half_blue.tga"

			start
			{
				size { point 200 }
				length { point 500,0,0 }
			}
		}
	}
}


