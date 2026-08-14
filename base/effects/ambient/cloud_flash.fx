effect effects/ambient/cloud_flash
{
	size	87

	spawner "unnamed0"
	{
		count		1,1

		electricity
		{
			duration	0.25,0.25
			fork	0
			jitterRate	0.5
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"
			flipNormal

			start
			{
				position { sphere 0,-20,-70,0,20,70 }
				size { point 0.125 }
				length { point 50,0,0 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		15,30

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { sphere 0,-50,-80,0,50,80 }
				size { box 10,10,20,20 }
				tint { point 0.733333,1,1 }
				fade { point 0.125 }
			}

			motion
			{
				tint { envelope "lightningflicker" }
				fade { envelope "linear" }
			}
		}
	}
	delay "unnamed2"
	{
		duration	0.25,15
	}
}


