effect effects/monsters/strogg_flyer/blaster_burst
{
	size	105

	spawner "unnamed0"
	{
		count		2,2

		sprite
		{
			duration	0.02,0.02
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				position { point 40,0,0 }
				size { line 20,20,60,60 }
				tint { point 0.67451,0.611765,0.501961 }
				fade { point 0.2 }
				rotate { box 0,3 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { point 3 relative }
			}
		}
	}
	sound "segment02"
	{
		soundShader	"strogg_flyer_fire"
	}
}


