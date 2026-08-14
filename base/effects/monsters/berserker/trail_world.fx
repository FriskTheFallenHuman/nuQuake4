effect effects/monsters/berserker/trail_world
{
	size	45

	spawner "bolt core"
	{
		count		1,1
		locked

		line
		{
			duration	0.4,0.4
			blend	add
			material	"gfx/effects/weapons/lgun"
			tiling	256

			start
			{
				position { point 10,0,0 }
				size { point 20 }
				tint { point 0.866667,1,1 }
				fade { point 0 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope "random" count 0.2 }
				tint { envelope "flickerblink" count 8,8,8 }
				fade { envelope "decalfade" }
			}

			end
			{
				size { point 40 }
				tint { point 0.247059,0.247059,0.247059 }
				fade { point 1 }
			}
		}
	}
}


