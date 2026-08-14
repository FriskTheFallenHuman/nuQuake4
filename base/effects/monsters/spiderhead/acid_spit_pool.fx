effect effects/monsters/spiderhead/acid_spit_pool
{
	size	27

	spawner "unnamed0"
	{
		count		4,4
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/smoke/smoke"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { cylinder 1,-0.5,-0.5,1,0.5,1 surface }
				velocity { point 11,0,0 }
				size { box 1,0.2 }
				tint { line 0.501961,0.501961,0,0.501961,0.501961,0.25098 }
				fade { point 0.5 }
				length { box 10,-1,-1,10,1,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	0.5,0.5
		count		2,2

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/smoke"
			gravity		-0.01,-0.001

			start
			{
				velocity { box 6,-5,-5,10,5,5 }
				size { point 2,2 }
				tint { point 0.501961,0.501961,0.25098 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	decal "unnamed2"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/fluids_drips/acid_burn"

			start
			{
				size { box 5,5,10,10 }
				rotate { box 0,1 }
			}
		}
	}
}


