effect effects/levels/waste/scannerbeamlong2
{
	size	311

	emitter "core"
	{
		duration	1,1
		count		1,1
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				position { point -10,0,0 }
				tint { point 1,0.376471,0 }
				length { point 303,0,0 }
			}
		}
	}
	emitter "glow"
	{
		duration	1,1
		count		1,1
		locked

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				position { point -3,0,0 }
				size { point 8 }
				tint { point 0.992157,0.305882,0.00784314 }
				fade { point 0.25 }
				length { point 296,0,0 }
			}
		}
	}
	emitter "core2"
	{
		duration	1,1
		count		1,1
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				position { point -10,0,0 }
				size { point 0.4 }
				tint { point 1,0.501961,0.501961 }
				length { point 303,0,0 }
			}
		}
	}
	emitter "endblob"
	{
		duration	1,1
		count		1,1
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/p_warm_blend2"
			flipNormal

			start
			{
				position { point -1,0,0 }
				size { point 15,6 }
				tint { point 1,0.501961,0 }
				fade { point 0.5 }
			}
		}
	}
	emitter "endmoveblob2"
	{
		duration	1,1
		count		5,10
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/p_warm_blend2"
			flipNormal

			start
			{
				position { point -1,0,0 }
				velocity { box -60,0,0,-240,0,0 }
				size { point 1.5,1.5 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { line 0.5,1 }
			}

			motion
			{
				size { envelope linear count 2,2 offset -1,-1 }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	emitter "endblob3"
	{
		duration	1,1
		count		1,1
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/p_warm_blend2"
			flipNormal

			start
			{
				position { point -1,0,0 }
				size { point 3,3 }
				tint { point 0.74902,0.74902,0.74902 }
			}
		}
	}
	emitter "startblob"
	{
		duration	1,1
		count		1,1
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/p_warm_blend2"
			flipNormal

			start
			{
				position { point 290,0,0 }
				size { point 15,6 }
				tint { point 1,0.501961,0 }
				fade { point 0.5 }
			}
		}
	}
	emitter "startmoveblob2"
	{
		duration	1,1
		count		5,10
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/p_warm_blend2"
			flipNormal

			start
			{
				position { point 290,0,0 }
				velocity { box 60,0,0,240,0,0 }
				size { point 2.5,2.5 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { line 0.5,1 }
			}

			motion
			{
				size { envelope linear count 2,2 offset -1,-1 }
			}

			end
			{
				size { point 0,0 }
			}
		}
	}
	emitter "startblob3"
	{
		duration	1,1
		count		1,1
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/p_warm_blend2"
			flipNormal

			start
			{
				position { point 290,0,0 }
				size { point 3,3 }
				tint { point 0.752941,0.752941,0.752941 }
			}
		}
	}
	emitter "residualline"
	{
		duration	1,1
		count		10,10

		line
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				position { point -6,0,0 }
				size { point 8 }
				tint { point 0.501961,0.14902,0 }
				fade { point 0.7 }
				length { point 300,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
}



