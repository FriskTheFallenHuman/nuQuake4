effect effects/monsters/spiderhead/spit_mflash
{
	size	148

	spawner "segment00"
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
	spawner "segment01"
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
	spawner "segment02"
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
	emitter "segment03"
	{
		duration	1,1
		count		12,15
		locked

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/fluids_drips/bubble_additive"
			gravity		0.3,0.4
			generatedOriginNormal

			start
			{
				position { box 0,-2,-1,-3,-3,1 }
				velocity { box 0,-0.5,-0.5,0,0.5,0.5 }
				size { point 3,3 }
				tint { line 0.501961,0.501961,0,0.501961,0.247059,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { box 3,30,3,40 }
			}
		}
	}
	emitter "segment04"
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
	spawner "segment05"
	{
		count		12,20
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
				velocity { box 50,-15,-15,400,15,15 }
				acceleration { point 1,0,0 }
				size { box 2,2,1,1 }
				tint { line 0.529412,0.352941,0.0941177,0.501961,0.501961,0 }
				rotate { box -0.2,-0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 0.25,0.25,0.5,0.5 }
			}

			impact
			{
				remove	1
				effect	"effects/monsters/spiderhead/acid_spit_pool_no_decal"
			}
		}
	}
}


