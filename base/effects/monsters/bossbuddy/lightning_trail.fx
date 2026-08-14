effect effects/monsters/bossbuddy/lightning_trail
{
	size	106

	spawner "bolt core"
	{
		count		1,1
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/lgun"
			tiling	128

			start
			{
				position { point -2,0,0 }
				size { point 20 }
				tint { point 0.866667,1,1 }
				fade { point 0 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope "random" count 0.2 }
				tint { envelope "flickerblink" count 8,8,8 }
				fade { envelope "pop_fade" }
			}

			end
			{
				size { point 40 }
				tint { point 0.247059,0.247059,0.247059 }
				fade { point 1 }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
		count		1,1

		electricity
		{
			duration	0.25,0.25
			blend	add
			fork	0
			jitterRate	0
			jitterSize	1,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/lgun"
			generatedOriginNormal

			start
			{
				position { cylinder 0.5,-0.1,-0.1,0.5,0.1,0.1 }
				size { point 5 }
				fade { point 0 }
				length { point 100,0,0 }
			}

			motion
			{
				fade { envelope "pop_fade" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	spawner "elect2"
	{
		count		1,1

		electricity
		{
			duration	0.1,0.1
			fork	0
			jitterRate	0
			jitterSize	5,15,15
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/lgun_smallbolt"
			generatedNormal

			start
			{
				position { line 0,0,0,0,0,0 useEndOrigin }
				size { box 1,2 }
				length { box 10,0,0,50,0,0 }
			}
		}
	}
}



