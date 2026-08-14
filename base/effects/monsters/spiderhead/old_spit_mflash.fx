effect effects/monsters/spiderhead/old_spit_mflash
{
	size	150

	spawner "unnamed0"
	{
		count		6,6

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/particles_shapes/specs"

			start
			{
				tint { line 0.501961,0.501961,0.247059,0.572549,0.345098,0.239216 }
				length { box 30,-10,-10,40,10,10 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 7 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		4,6

		sprite
		{
			duration	0.2,0.4
			blend	add
			material	"gfx/effects/particles_shapes/specs"
			generatedOriginNormal

			start
			{
				position { box 30,0,0,0,0,0 }
				velocity { box 290,75,0,300,75,0 }
				tint { line 0.501961,0.501961,0.247059,0.533333,0.407843,0.243137 }
				rotate { box 0.2,-0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				tint { point 0.0901961,0.0901961,0.0431373 }
			}
		}
	}
	spawner "unnamed2"
	{
		count		7,7
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/smoke/smoke"

			start
			{
				velocity { point 10,0,0 }
				size { point 4 }
				tint { line 0.247059,0.247059,0.121569,0.239216,0.239216,0.121569 }
				length { box 10,-10,-10,15,10,10 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 5 }
			}
		}
	}
	emitter "unnamed3"
	{
		start		0.5,0.5
		duration	1,1
		count		15,19
		locked

		sprite
		{
			duration	0.25,1
			material	"gfx/effects/fluids_drips/bubble_additive"
			gravity		0.05,0.08
			generatedOriginNormal

			start
			{
				position { box -0.5,0,-3,-0.5,-1,3 }
				velocity { box 0,-3,-3,0,3,3 }
				tint { line 0.501961,0.501961,0,0.501961,0.25098,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { box 1,25,1,35 }
				tint { point 0.0901961,0.0901961,0.0431373 }
			}
		}
	}
	emitter "unnamed4"
	{
		duration	1,1
		count		1,2
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/bubble_additive"
			gravity		0.2,0.3
			generatedOriginNormal

			start
			{
				position { box 1,3,0,0,-3,0 }
				velocity { box 3,-3,-3,3,3,3 }
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
	spawner "unnamed5"
	{
		count		6,6
		locked

		sprite
		{
			duration	0.75,0.75
			material	"gfx/effects/fluids_drips/bubble_glob"
			gravity		0.7,1
			generatedOriginNormal

			start
			{
				position { box 30,0,0,0,0,0 }
				velocity { box 50,-7,-7,400,7,7 }
				acceleration { point 1,0,0 }
				size { point 2,2 }
				tint { line 0.529412,0.352941,0.0941177,0.501961,0.501961,0 }
				rotate { box -0.2,-0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			impact
			{
				remove	1
				effect	"effects/monsters/spiderhead/acid_spit_pool_no_decal"
			}
		}
	}
}


