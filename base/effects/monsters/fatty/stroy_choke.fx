effect effects/monsters/fatty/stroy_choke
{
	size	81

	emitter "unnamed2"
	{
		duration	2,2
		count		30,30

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/gore_spray/bloodhit1"

			start
			{
				velocity { box 60,-50,-50,60,50,50 }
				size { line 10,10,50,50 }
				tint { line 0.501961,1,0.501961,0,1,0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	2,2
		count		10,10

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/gore_spray/bloodhit2"

			start
			{
				velocity { box 50,-25,-25,50,25,25 }
				size { line 10,10,30,30 }
				tint { line 0.501961,1,0.501961,0,1,0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}
