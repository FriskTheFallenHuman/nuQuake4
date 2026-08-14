effect effects/mapobjects/pistonb_arc
{
	size	91

	spawner "electricity"
	{
		count		1,1
		locked

		line
		{
			duration	2,2
			blend	add
			material	"gfx/test/lgun"

			start
			{
				position { point -2,0,0 }
				size { point 30 }
				fade { point 0 }
				length { line 10,0,0,10,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope random count 0.2 }
				tint { envelope flickerblink count 8,8,8 }
				fade { envelope decalfade }
			}

			end
			{
				size { point 80 }
				tint { point 0.247059,0.247059,0.247059 }
				fade { point 1 }
			}
		}
	}
	sound "unnamed1"
	{
		soundShader	"effects_arc_loop"
	}
}








