effect effects/levels/tram/turretflash
{
	size	457

	spawner "Smoke"
	{
		detail		0.5
		count		5,10

		sprite
		{
			duration	6,6
			material	"gfx/effects/smoke/cloud_alpha"
			generatedNormal

			start
			{
				position { box -5,-5,-5,5,5,5 }
				velocity { box 20,-10,-10,30,10,10 }
				angle { box 0,0,0.0833333,0,0,0.166667 }
				size { line 10,10,15,15 }
				tint { line 0.466667,0.466667,0.466667,0.403922,0.27451,0.188235 }
				fade { point 0.5 }
				offset { point 12,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "fire_smokefade" count 2,2,2 }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 250,250 }
				tint { line 0.164706,0.164706,0.164706,0.286275,0.258824,0.137255 }
				angle { point 0,0,0.222222 relative }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	spawner "Flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.4,0.4
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { point 1,0,0 }
				size { point 5,5 }
				tint { point 0,0,0 }
				offset { point 12,0,0 }
				rotate { box 1,2 }
			}

			motion
			{
				size { envelope "fastinslowout" }
				tint { envelope "fastinslowout" }
				rotate { envelope "random" }
			}

			end
			{
				size { point 45,45 }
				tint { point 0.686275,0.686275,0.686275 }
			}
		}
	}
}


