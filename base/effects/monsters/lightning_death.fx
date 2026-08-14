effect effects/monsters/lightning_death
{
	size	21

	spawner "unnamed0"
	{
		count		1,1
		locked

		electricity
		{
			duration	1,1
			blend	add
			fork	1
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electricity"

			start
			{
				size { box 0.5,1 }
				tint { line 0.501961,1,0,1,1,0.501961 }
				length { box 10,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope cosine offset 0.5 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		1,1
		locked

		electricity
		{
			duration	1,1
			blend	add
			fork	2
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electricity"

			start
			{
				size { point 0.5 }
				tint { point 0.313726,0.890196,0.282353 }
				fade { line 0.5,1 }
				length { box -10,0,0,-20,0,0 }
			}
		}
	}
}


