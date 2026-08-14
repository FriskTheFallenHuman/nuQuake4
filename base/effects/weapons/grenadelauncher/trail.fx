effect effects/weapons/grenadelauncher/trail
{
	size	104

	emitter "smoke"
	{
		duration	1,1
		count		50,50
		attenuateEmitter

		sprite
		{
			duration	0.5,0.75
			persist
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 14,14,18,18 attenuate }
				tint { line 0.494118,0.478431,0.388235,0.423529,0.411765,0.34902 }
				fade { point 0.3 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 24,24,28,28 attenuate }
				tint { point 0.160784,0.152941,0.129412 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	light "light2"
	{
		detail		0.5
		locked
		constant

		light
		{
			duration	1,1
			material	"lights/grenade_flicker"

			start
			{
				size { point 60,60,60 }
				tint { point 0.972549,0.286275,0.0862745 }
			}
		}
	}
}









