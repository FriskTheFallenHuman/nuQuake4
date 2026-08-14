effect effects/monsters/teleport_dropper/blast_exhaust
{
	size	65

	spawner "main steam"
	{
		count		10,10
		locked

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				velocity { box 50,-30,-5,100,5,5 }
				friction { point -10,0,0 }
				tint { line 0.733333,0.882353,0.843137,1,1,1 }
				fade { point 0.8 }
				rotate { box 0,-0.5 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_x2 }
				fade { envelope guitable_10_5 }
				rotate { envelope linear }
			}

			end
			{
				size { line 5,5,30,30 }
				tint { point 0.501961,0.501961,0.501961 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
}

