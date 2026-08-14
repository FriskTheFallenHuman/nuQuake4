effect effects/monsters/spiderhead/spit_impact
{
	size	147

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
	spawner "unnamed1"
	{
		count		3,3
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		-0.01,-0.001

			start
			{
				velocity { box 6,-5,-5,10,5,5 }
				size { point 40,40 }
				tint { point 0.333333,0.333333,0.168627 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100,100 }
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
				size { point 30,30 }
				rotate { box 0,1 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.25,0.25
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { point 0.05,0,0 }
				size { point 10,10 }
				tint { point 0.501961,0.501961,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	spawner "unnamed4"
	{
		count		1,1

		oriented
		{
			duration	0.25,0.25
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { point 0.05,0,0 }
				size { point 10,10 }
				tint { point 0.501961,0.501961,0 }
				rotate { point -0.1,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 30,30 }
			}
		}
	}
	spawner "unnamed5"
	{
		count		1,1

		oriented
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/smoke_alpha"

			start
			{
				position { point 0.05,0,0 }
				size { point 10,10 }
				tint { point 0.501961,0.501961,0 }
				rotate { point 0.1,0,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 30,30 }
			}
		}
	}
	emitter "unnamed6"
	{
		duration	0.5,0.5
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/fluids_drips/bubble_glob"
			gravity		-0.01,-0.001

			start
			{
				velocity { box 6,-5,-5,10,5,5 }
				size { point 10,10 }
				tint { point 0.501961,0.501961,0.247059 }
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
				size { point 30,30 }
			}
		}
	}
	emitter "unnamed7"
	{
		duration	1,1
		count		7,7
		locked

		sprite
		{
			duration	1,2
			material	"gfx/effects/fluids_drips/bubble_additive"
			gravity		0.03,0.3
			generatedOriginNormal

			start
			{
				position { box 1,5,0,0,-5,0 }
				velocity { box 5,-3,-3,8,3,3 }
				size { point 2,3 }
				tint { point 0.501961,0.501961,0.247059 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { box 10,50,10,75 }
				tint { point 0.0901961,0.0901961,0.0431373 }
			}
		}
	}
	spawner "unnamed8"
	{
		count		6,6
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/smoke/smoke"
			generatedOriginNormal

			start
			{
				position { cylinder 1,-3,-3,1,3,3 }
				velocity { box 11,0,0,20,0,0 }
				size { box 1,2 }
				tint { line 0.501961,0.501961,0,0.501961,0.501961,0.247059 }
				length { box 20,-1,-1,30,1,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope linear }
			}
		}
	}
	spawner "unnamed9"
	{
		count		3,3

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/particles_shapes/specs"

			start
			{
				velocity { box 25,-100,-100,50,100,100 }
				size { point 5,5 }
				tint { point 0.501961,0.501961,0.25098 }
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
			}
		}
	}
	sound "unnamed10"
	{
		soundShader	"effects_acid_burn2"
	}
	emitter "unnamed11"
	{
		duration	1,1
		count		2,3
		locked

		sprite
		{
			duration	1,2
			material	"gfx/effects/fluids_drips/bubble_additive"
			gravity		0.2,0.3
			generatedOriginNormal

			start
			{
				position { box 1,3,0,0,-3,0 }
				velocity { box 10,-3,-3,10,3,3 }
				size { point 2,2 }
				tint { point 0.501961,0.501961,0.247059 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 1,50 }
				tint { point 0.0901961,0.0901961,0.0431373 }
			}

			impact
			{
				remove	1
				effect	"effects/monsters/spiderhead/acid_spit_pool"
			}
		}
	}
}


