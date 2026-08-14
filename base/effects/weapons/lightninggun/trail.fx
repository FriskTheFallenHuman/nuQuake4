effect effects/weapons/lightninggun/trail
{
	size	14

	spawner "bolt core"
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
				position { point -2,-2.5,-1.5 }
				size { point 12 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
}


















