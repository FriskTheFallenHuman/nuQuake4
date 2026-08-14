effect effects/monsters/strogg_flyer/mflash
{
	size	271

	sound "segment02"
	{
		soundShader	"strogg_flyer_fire"
	}
	spawner "single_streak"
	{
		count		1,1
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 20 }
				length { box 200,0,0,250,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 10 }
				length { box 14,0,0,20,0,0 }
			}
		}
	}
	spawner "flash"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 20,20,50,50 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 80,80,150,150 }
			}
		}
	}
	spawner "flash2"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 60,60 }
				offset { box 10,0,0,20,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 2.5,2.5 }
			}
		}
	}
}
