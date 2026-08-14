effect effects/monsters/strogg_flyer/blaster_collide
{
	size	36

	spawner "unnamed0"
	{
		count		2,2

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				position { point 1,0,0 }
				size { point 25,25 }
				tint { point 0.741176,0.647059,0.54902 }
				rotate { box 0,3 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { point 3 relative }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"effects_blaster_hit01"
	}
	spawner "unnamed3"
	{
		count		10,10

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/muzzleflash2"
			generatedOriginNormal

			start
			{
				position { cylinder 1,-10,-10,1,10,10 surface }
				velocity { box 50,0,0,200,0,0 }
				size { line 2,2,4,4 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}
		}
	}
}


