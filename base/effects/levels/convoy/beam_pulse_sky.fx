effect effects/levels/convoy/beam_pulse_sky
{
	size	1050

	emitter "Pulse"
	{
		duration	1,1
		count		2,2

		sprite
		{
			duration	2,2
			blend	add
			material	"gfx/effects/weapons/flash_blue.tga"

			start
			{
				position { line 0,0,0,30,0,0 }
				velocity { box 180,0,0,200,0,0 }
				angle { point 0,0,0.5 }
				size { line 400,500,40,80 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 0 }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box 0.25,-0.25 }
			}

			motion
			{
				fade { envelope "cosine" }
				offset { envelope "sintable" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.5 }
				offset { box 0,-5,-5,0,5,5 }
				angle { box 0,0,0,0,0,1 }
			}
		}
	}
	spawner "unnamed10"
	{
		count		1,1
		constant

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash_half_blue.tga"

			start
			{
				size { point 300 }
				tint { point 0.74902,0.74902,0.74902 }
				offset { point -250,0,0 }
				length { point 500,0,0 }
			}
		}
	}
}

