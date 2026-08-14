effect effects/monsters/grunt/bullet_mflash
{
	size	347

	spawner "unnamed0"
	{
		count		20,20
		locked

		line
		{
			duration	0.15,0.15
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				position { point 5,0,0 }
				size { box 2,5 }
				tint { line 0.262745,0.258824,0.196078,0.341176,0.345098,0.254902 }
				length { box 0,-15,-15,15,15,15 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		3,3
		locked

		sprite
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				position { box 10,-3,-3,10,3,3 }
				size { point 30,30 }
				tint { point 0.121569,0.121569,0.0862745 }
			}
		}
	}
	light "unnamed3"
	{
		detail		0.5

		light
		{
			duration	0.2,0.2
			blend	add
			material	"lights/defaultPointLight"

			start
			{
				size { point 200,200,200 }
				tint { point 0.576471,0.580392,0.419608 }
			}
		}
	}
}






