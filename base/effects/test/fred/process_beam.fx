effect effects/test/fred/process_beam
{
	size	31

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
				size { point 1.5 }
				tint { point 1,0,0 }
				length { line 0,0,0,0,0,0 useEndOrigin }
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
				tint { point 1,0,0 }
				fade { point 0.25 }
				length { line 0,0,0,0,0,0 useEndOrigin }
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
				length { line 0,0,0,0,0,0 useEndOrigin }
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
				size { point 13,6 }
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
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/particles_shapes/p_warm_blend2"
			flipNormal

			start
			{
				position { point -1,0,0 }
				velocity { box -60,0,0,-240,0,0 }
				size { point 2.5,2.5 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { line 0.5,1 }
			}

			motion
			{
				size { envelope "linear" count 2,2 offset -1,-1 }
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
				size { point 5,5 }
				tint { point 0.752941,0.752941,0.752941 }
			}
		}
	}
	emitter "trails"
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
				position { point -4,0,0 }
				size { point 10 }
				tint { point 0.501961,0,0 }
				fade { point 0.4 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
}
