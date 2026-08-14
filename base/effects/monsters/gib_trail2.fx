effect effects/monsters/gib_trail2
{
	size	30

	emitter "goo"
	{
		duration	5,5
		count		50,100

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/gore_spray/bloodhit4"

			start
			{
				position { sphere 0,-2,-2,0,2,2 }
				size { line 15,15,20,20 }
				tint { line 0.12549,0,0,0.25098,0,0 }
				fade { point 0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { line 0.125,0.25 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
}
