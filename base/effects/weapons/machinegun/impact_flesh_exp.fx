effect effects/weapons/machinegun/impact_flesh_exp
{
	size	9

	sound "sound"
	{
		soundShader	"bullet_impact_flesh"
	}
	spawner "flash2"
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
				size { point 6,6 }
			}

			motion
			{
				tint { envelope "linear" }
			}
		}
	}
}
