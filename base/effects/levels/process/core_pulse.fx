effect effects/levels/process/core_pulse
{
	size	269

	spawner "Pulse"
	{
		count		10,10

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { line 0,0,0,30,0,0 }
				velocity { box 280,0,0,300,0,0 }
				angle { point 0,0,0.5 }
				size { box 30,30,40,40 }
				fade { point 0.5 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0.25,-0.25 }
			}

			motion
			{
				offset { envelope sintable }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
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
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 10,0,0 }
				size { point 100,100 }
				fade { point 0.5 }
			}
		}
	}
	spawner "Pulse2"
	{
		count		10,10

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { line 30,0,0,-40,0,0 }
				velocity { box 300,0,0,320,0,0 }
				angle { point 0,0,0.5 }
				size { point 50,50 }
				fade { point 0.3 }
				offset { box 0,-30,-30,0,30,30 }
				rotate { box 0.25,-0.25 }
			}

			motion
			{
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				angle { box 0,0,0,0,0,1 }
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
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { point -40,0,0 }
				size { point 50 }
				length { point 100,0,0 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"process_pulse"
	}
	sound "unnamed5"
	{
		soundShader	"effects_energy_burst"
		freqshift	0.8,0.8
	}
}





