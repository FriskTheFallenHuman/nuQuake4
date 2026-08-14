effect effects/monsters/lightning_death_netguardian
{
	size	202

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
			jitterSize	3,32,32
			jitterTable	halfsintable
			material	"gfx/effects/electricity/electricity"

			start
			{
				size { box 1,2 }
				tint { line 0.501961,1,0,1,1,0.501961 }
				length { box 100,0,0,200,0,0 }
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
			jitterTable	halfsintable
			material	"gfx/effects/electricity/electricity"

			start
			{
				tint { point 0.313726,0.890196,0.282353 }
				fade { line 0.5,1 }
				length { box -100,0,0,-200,0,0 }
			}
		}
	}
}
