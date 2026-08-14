effect effects/monsters/scientist/fire_bomb_fly
{
	size	57

	emitter "segment062"
	{
		duration	1,1
		count		25,25
		locked

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
	emitter "segment0"
	{
		duration	1,1
		count		12,12
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 5,5 }
				rotate { box 0,7 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.1,0.1 relative }
			}
		}
	}
}


