effect effects/weapons/railgun/reflect
{
	size	178

	sound "sound"
	{
		soundShader	"weapon_railgun_impact"
	}
	decal "wall mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/railgun_decal"

			start
			{
				size { point 6,6 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "embers"
	{
		count		5,15

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/weapons/blue_spark"
			gravity		0.5,0.75
			generatedOriginNormal

			start
			{
				position { sphere 1,-10,-10,1,10,10 }
				velocity { box 250,-200,-200,200,200,200 }
				size { point 3,3 }
				rotate { box 0.251,-0.25 }
			}

			motion
			{
				size { envelope random }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 5,5 }
			}
		}
	}
	spawner "streaks"
	{
		count		5,5
		locked

		line
		{
			duration	0.08,0.08
			blend	add
			material	"gfx/effects/weapons/flash_half_blue"
			generatedOriginNormal

			start
			{
				position { sphere 0.1,-0.5,-0.5,0.1,0.5,0.5 }
				size { box 5,8 }
				tint { line 0,0.501961,1,0.25098,0.756863,1 }
				fade { point 0.5 }
				length { box 15,0,0,25,0,0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"
			generatedOriginNormal

			start
			{
				position { point 5,0,0 }
				velocity { box 300,-50,-50,400,50,50 }
				size { point 5,5 }
				fade { point 0.15 }
			}

			motion
			{
				size { envelope pop_hold }
				tint { envelope linear }
			}

			end
			{
				size { point 35,35 }
			}
		}
	}
}



