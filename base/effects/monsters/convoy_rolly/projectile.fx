effect effects/monsters/convoy_rolly/projectile
{
	size	220

	spawner "glow"
	{
		count		1,1
		locked

		line
		{
			duration	2,2
			material	"gfx/effects/smoke/smoke"

			start
			{
				size { point 8 }
				tint { point 0.737255,0.560784,0.329412 }
				length { point 50,0,0 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { point 200,0,0 }
			}
		}
	}
	spawner "core"
	{
		count		1,1
		locked

		line
		{
			duration	2,2
			material	"gfx/effects/weapons/tracerlarge"

			start
			{
				size { point 2 }
				length { point 30,0,0 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { point 200,0,0 }
			}
		}
	}
	spawner "glow2"
	{
		count		1,1
		locked

		line
		{
			duration	2,2
			material	"gfx/effects/smoke/smoke"

			start
			{
				size { point 20 }
				tint { point 0.25098,0,0 }
				length { point 150,0,0 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { point 200,0,0 }
			}
		}
	}
	spawner "unnamed3"
	{
		count		1,1
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/g_rail_flash"

			start
			{
				position { point 50,0,0 }
				size { point 10,10 }
			}
		}
	}
}
