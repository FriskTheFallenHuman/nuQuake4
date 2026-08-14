effect effects/mapobjects/casket_doorsteam_inv
{
	size	55

	emitter "unnamed0"
	{
		duration	0.5,2
		count		20,20

		sprite
		{
			duration	1.25,2
			material	"gfx/effects/smoke/cloud_alpha2"
			flipNormal

			start
			{
				position { line 0,-25,0,0,10,0 }
				velocity { box 3,0,8,5,0,10 }
				size { box 1,1,5,5 }
				fade { line 0.25,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { box 20,20,30,30 }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	0.125,0.125
			material	"gfx/effects/smoke/cloud_alpha2"
			flipNormal

			start
			{
				position { line 0,-25,0,0,10,0 }
				velocity { box 3,0,75,5,0,150 }
				size { line 10,10,12,12 }
				fade { line 0.25,0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 15,15,20,20 }
			}
		}
	}
}

