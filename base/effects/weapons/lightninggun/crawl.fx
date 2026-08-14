effect effects/weapons/lightninggun/crawl
{
	size	64

	sound "sound"
	{
		soundShader	"effects_sparks02"
	}
	spawner "elec1"
	{
		count		1,1
		locked

		electricity
		{
			duration	1,1
			fork	1
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/lgun_smallbolt"

			start
			{
				size { box 6,7 }
				length { box 10,0,0,20,0,0 }
			}
		}
	}
	emitter "smoke"
	{
		detail		0.5
		duration	1,1
		count		15,15

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.02,-0.01

			start
			{
				velocity { box -5,-5,-5,5,5,5 }
				size { line 10,10,20,20 }
				tint { line 0.54902,0.776471,1,0.74902,0.74902,0.74902 }
				fade { line 0.2,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "fire_smokefade" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 20,20,40,40 }
			}
		}
	}
	spawner "elec2"
	{
		detail		0.5
		count		1,1
		locked

		electricity
		{
			duration	1,1
			fork	2
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/lgun_smallbolt"

			start
			{
				size { box 6,7 }
				length { box -10,0,0,-20,0,0 }
			}
		}
	}
}















