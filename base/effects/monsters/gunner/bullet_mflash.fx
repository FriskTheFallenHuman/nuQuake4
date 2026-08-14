effect effects/monsters/gunner/bullet_mflash
{
	size	208

	light "light"
	{
		detail		0.5

		light
		{
			duration	0.05,0.05
			blend	add
			material	"lights/defaultPointLight"

			start
			{
				size { point 120,120,120 }
				tint { point 0.67451,0.607843,0.376471 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.09,0.09
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 3,0,0 }
				size { point 30,30 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	spawner "side_streaks"
	{
		count		9,12
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { cylinder 0.02,-0.03,-0.03,0.02,0.03,0.03 surface }
				velocity { point 50,0,0 }
				size { box 2,10 }
				fade { point 0 }
				length { box 10,0,0,24,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { point 0 }
				fade { point 0.75 }
			}
		}
	}
	spawner "single_streak"
	{
		count		5,5
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { cylinder -2,-2,-2,-2,2,2 }
				size { point 6 }
				length { box 20,0,0,36,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 2 }
				length { box 12,0,0,16,0,0 }
			}
		}
	}
}











