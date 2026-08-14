effect effects/mp/item_teleport
{
	size	73

	spawner "smoke"
	{
		detail		0.5
		count		3,3

		sprite
		{
			duration	1.5,1.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.02,-0.02

			start
			{
				position { line -20,-5,-5,-16,5,5 }
				size { line 10,10,20,20 }
				tint { line 0.768628,0.8,0.792157,0.607843,0.74902,0.694118 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 30,30,40,40 }
				fade { point 0.5 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	sound "sound"
	{
		soundShader	"mp_item_teleport"
	}
}

