effect effects/weapons/lightninggun/trail_noimpact
{
	size	10

	spawner "bolt core"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/lgun"
			tiling	256

			start
			{
				position { point -2,-2.5,-1.5 }
				size { point 8 }
				fade { point 0.6 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
}
