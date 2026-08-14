effect effects/monsters/bossbuddy/crawl
{
	size	63

	spawner "unnamed0"
	{
		count		1,1
		locked

		electricity
		{
			duration	1,1
			fork	1
			jitterRate	0.03
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electricity"

			start
			{
				size { box 1,3 }
				length { box 10,0,0,20,0,0 }
			}
		}
	}
	emitter "smoke"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/impact_smoke3"
			gravity		-0.04,-0.03

			start
			{
				velocity { box -8,-8,-8,8,8,8 }
				size { line 6,6,10,10 }
				tint { line 0.411765,0.729412,0.760784,0.552941,0.592157,0.729412 }
				fade { line 0.2,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 20,20,40,40 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		1,1
		locked

		electricity
		{
			duration	1,1
			fork	1
			jitterRate	0.02
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electricity"

			start
			{
				size { box 1,2.5 }
				length { box -10,0,0,-20,0,0 }
			}
		}
	}
	sound "unnamed5"
	{
		soundShader	"effects_sparks02"
	}
}
