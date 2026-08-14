effect effects/weapons/dmg/pickup
{
	size	41

	emitter "trail2"
	{
		duration	1,1
		count		8,10

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.005,-0.001

			start
			{
				position { sphere -5,-5,-5,5,5,5 }
				size { line 8,8,15,15 }
				tint { line 0.568627,0.447059,0.619608,0.372549,0.176471,0.635294 }
				fade { line 0.4,1 }
				offset { point 0,0,15 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}
		}
	}
}

