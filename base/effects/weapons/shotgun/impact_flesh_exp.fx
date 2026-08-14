effect effects/weapons/shotgun/impact_flesh_exp
{
	size	15

	sound "sound"
	{
		soundShader	"bullet_impact_flesh"
	}
	spawner "flash3"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { point 10,10 }
			}

			motion
			{
				tint { envelope "linear" }
			}
		}
	}
}
