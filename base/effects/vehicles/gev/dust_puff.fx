effect effects/vehicles/gev/dust_puff
{
	size	1679

	spawner "unnamed2"
	{
		count		20,20

		sprite
		{
			duration	3,3
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		-0.25,0

			start
			{
				position { sphere -20,0,-20,20,0,20 surface }
				velocity { box -200,-200,-200,200,200,200 }
				size { point 100,100 }
				tint { line 0.47451,0.466667,0.356863,0.392157,0.364706,0.286275 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 800,300 }
			}
		}
	}
}



