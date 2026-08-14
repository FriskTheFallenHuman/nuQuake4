effect effects/ambient/laserfence_128
{
	size	132

	spawner "line"
	{
		count		1,1
		constant

		line
		{
			duration	10,10
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				size { point 4 }
				tint { point 1,0,0 }
				length { point 128,0,0 }
			}

			motion
			{
				size { envelope random count 0.5 }
				tint { envelope random count 0.5,0.5,0.5 }
			}

			end
			{
				size { point 3 }
				tint { point 0.901961,0.180392,0 }
			}
		}
	}
	spawner "inner"
	{
		count		1,1
		constant

		line
		{
			duration	10,10
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				tint { point 0.67451,0.67451,0.67451 }
				length { point 128,0,0 }
			}

			motion
			{
				size { envelope random count 0.5 }
				tint { envelope random count 0.5,0.5,0.5 }
			}

			end
			{
				size { point 0.5 }
				tint { point 0.27451,0.27451,0.27451 }
			}
		}
	}
	emitter "spark drops"
	{
		duration	1,1
		density		5,5

		sprite
		{
			duration	1.4,1.4
			blend	add
			material	"gfx/effects/particles_shapes/add_sphere"
			gravity		0.005,0.01

			start
			{
				position { line 0,-1.5,-1.5,128,1.5,1.5 }
				velocity { box 0,-0.5,-0.5,0,0.5,0.5 }
				size { line 4,4,8,8 }
				tint { line 1,0.627451,0.258824,1,0.356863,0.141176 }
				fade { point 0 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope pop_hold_fadefast }
			}

			end
			{
				tint { point 1,0,0 }
				fade { point 0.25 }
			}
		}
	}
	emitter "dust"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/dustadd"
			gravity		-0.005,0

			start
			{
				position { cylinder 0,-10,-10,128,10,10 }
				angle { box 0,0,0,1,1,1 }
				size { box 0.15,0.15,0.25,0.25 }
				tint { line 1,0,0,1,0.501961,0 }
				fade { point 0 }
				offset { box 0,-2,-2,0,2,2 }
			}

			motion
			{
				fade { envelope cosine }
				angle { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"process_node"
	}
}

