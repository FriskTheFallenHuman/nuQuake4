effect effects/monsters/strogg_marine/shotgun_mflash
{
	size	208

	emitter "smoke"
	{
		duration	1.5,1.5
		count		10,10

		sprite
		{
			duration	0.75,1
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.1,-0.06

			start
			{
				position { point 0,0,5 }
				velocity { box 0,-3,-3,10,3,3 }
				size { line 2,2,4,4 }
				tint { line 0.47451,0.458824,0.419608,0.203922,0.192157,0.176471 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				size { line 16,16,22,22 }
				fade { point 0.25 }
			}
		}
	}
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
				tint { point 0.576471,0.580392,0.419608 }
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
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { point 3,0,0 }
				size { point 45,45 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	spawner "side_streaks"
	{
		detail		0.5
		count		9,12
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { cylinder 0.2,-0.3,-0.3,0.2,0.3,0.3 surface }
				velocity { point 50,0,0 }
				size { box 10,15 }
				fade { point 0 }
				length { box 26,0,0,30,0,0 }
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
		detail		0.5
		count		5,5
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { cylinder -2,-2,-2,-2,2,2 }
				size { point 6 }
				length { box 40,0,0,46,0,0 }
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
				length { box 14,0,0,20,0,0 }
			}
		}
	}
}









