effect effects/monsters/scientist/fire_bomb_mflash
{
	size	142

	emitter "segment06"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	2,2
			blend	add
			material	"gfx/effects/smoke/blacksmokepuff"
			gravity		-0.2,-0.05

			start
			{
				size { point 20,20 }
				tint { line 1,1,1,0.592157,0.545098,0.407843 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	emitter "segment62"
	{
		duration	1,1
		count		25,25

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/embers"

			start
			{
				size { point 5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 40,40 }
				rotate { box -0.0833333,0.0833333 relative }
			}
		}
	}
}


