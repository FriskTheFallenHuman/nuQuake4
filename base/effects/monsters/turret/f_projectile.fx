effect effects/monsters/turret/f_projectile
{
	size	105

	spawner "unnamed0"
	{
		count		1,1
		locked

		line
		{
			duration	2,2
			material	"gfx/effects/particles_shapes/specs"

			start
			{
				size { point 5 }
				tint { point 0.25098,0,0 }
				fade { point 0.25 }
				length { point 100,0,0 }
			}

			motion
			{
				size { envelope linear count 10 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		1,1
		locked

		line
		{
			duration	2,2
			material	"gfx/effects/smoke/smoke"

			start
			{
				size { point 5 }
				tint { point 0.721569,0.647059,0.345098 }
				length { point 50,0,0 }
			}

			motion
			{
				size { envelope linear count 10 }
				tint { envelope linear }
			}
		}
	}
	spawner "unnamed2"
	{
		count		3,3
		locked

		line
		{
			duration	2,2
			material	"gfx/effects/particles_shapes/specs"

			start
			{
				size { point 0.5 }
				length { point 50,0,0 }
			}

			motion
			{
				size { envelope linear count 10 }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5 }
			}
		}
	}
}


