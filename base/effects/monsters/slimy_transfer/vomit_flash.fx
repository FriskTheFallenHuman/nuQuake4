effect effects/monsters/slimy_transfer/vomit_flash
{
	size	517

	emitter "spew 1"
	{
		duration	1,1
		count		80,80

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/monsters/slimy_transfer/puke_fly"
			gravity		0.2,0.2

			start
			{
				velocity { point 200,0,0 }
				size { point 2,2 }
				tint { line 0.615686,0.615686,0,0.596078,0.368627,0.0196078 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "arch" count 0.7,0.7 }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 15,15,30,30 }
			}
		}
	}
	emitter "spew 2"
	{
		detail		0.5
		duration	1,1
		count		80,80

		sprite
		{
			duration	1,3
			persist
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.2,0.2

			start
			{
				velocity { box 200,-20,-20,200,20,20 }
				size { point 2,2 }
				tint { line 0.654902,0.74902,0.117647,0.415686,0.0823529,0.0823529 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope "arch" count 0.7,0.7 }
				fade { envelope "linear" }
			}

			end
			{
				size { line 20,20,30,30 }
			}
		}
	}
}



















