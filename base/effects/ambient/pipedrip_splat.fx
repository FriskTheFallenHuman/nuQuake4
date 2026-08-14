effect effects/ambient/pipedrip_splat
{
	size	15

	spawner "splatline"
	{
		count		5,5

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_alpha"
			gravity		0.5,0.5
			generatedOriginNormal

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 40,0,0,80,0,0 }
				size { box 1,2 }
				tint { point 0.866667,1,1 }
				fade { point 0 }
				length { box 2,0,0,4,0,0 }
			}

			motion
			{
				fade { envelope cosine }
			}

			end
			{
				fade { point 0.1 }
			}
		}
	}
}
