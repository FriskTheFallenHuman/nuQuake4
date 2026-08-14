effect effects/ships/sflyer_high
{
	size	27529

	spawner "ShipModel"
	{
		count		3,5

		model
		{
			duration	5,5
			material	"gfx/effects/ships/sflyer_high"
			model		"gfx/effects/ships/SFlyer_sprite.lwo"

			start
			{
				velocity { box 10000,0,0,11000,0,0 }
				tint { point 0.501961,0.501961,0.501961 }
				offset { box -2000,-2000,-2000,2000,2000,2000 }
			}
		}
	}
}


