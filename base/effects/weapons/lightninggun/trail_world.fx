effect effects/weapons/lightninggun/trail_world
{
	size	21

	spawner "bolt core2"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/weapons/lgun"
			tiling	256

			start
			{
				position { point 10,0,0 }
				size { point 16 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
}



















