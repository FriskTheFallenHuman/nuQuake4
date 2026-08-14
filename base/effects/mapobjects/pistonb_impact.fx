effect effects/mapobjects/pistonb_impact
{
	size	91

	spawner "smoke_ring"
	{
		count		40,40

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/impact_smoke"
			gravity		-0.01,-0.01
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-20,-20,0.1,20,20 surface }
				velocity { box 80,0,0,150,0,0 }
				size { point 20,20 }
				tint { point 0.596078,0.584314,0.552941 }
				fade { point 0.2 }
				offset { point 12,0,0 }
				rotate { box 0,0.111111 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 30,30 }
				rotate { box 0.111111,0.222222 relative }
			}
		}
	}
}


