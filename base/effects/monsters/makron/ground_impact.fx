effect effects/monsters/makron/ground_impact
{
	size	2122

	emitter "deform"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.35,0.35
			blend	add
			material	"gfx/effects/energy_sparks/explosion_deform3"

			start
			{
				size { point 0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 1000,1000 }
			}
		}
	}
	emitter "deform_oriented"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.35,0.35
			material	"gfx/effects/energy_sparks/explosion_deform3"

			start
			{
				position { point 1,0,0 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 1000,1000 }
			}
		}
	}
	spawner "unnamed21"
	{
		count		25,50

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				velocity { box 0,-1000,-1000,0,1000,1000 }
				size { point 100,100 }
				tint { point 0.713726,0.8,0.866667 }
				fade { line 0.25,0.5 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 100,100,200,200 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		1,1

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash4"

			start
			{
				position { point 1,0,0 }
				size { point 2,2 }
				fade { line 0.25,0.5 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 1500,1500 }
			}
		}
	}
}
