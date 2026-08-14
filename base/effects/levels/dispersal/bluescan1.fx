effect effects/levels/dispersal/bluescan1
{
	size	205

	emitter "beam"
	{
		duration	1,1
		count		30,30
		locked

		line
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/scan_light_grey"

			start
			{
				size { box 25,125 }
				tint { line 0.14902,0.815686,0.85098,0.196078,0.439216,0.803922 }
				fade { point 0 }
				length { point 80,0,0 }
			}

			motion
			{
				fade { envelope fast_in_slow_out }
			}

			end
			{
				fade { point 0.1 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"process_node"
		volume	1.5,1.5
		freqshift	2.5,2.5
	}
	emitter "dust"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/dustadd"
			gravity		-0.005,0

			start
			{
				position { cylinder 0,-150,-150,60,150,150 cone }
				angle { box 0,0,0,1,1,1 }
				size { point 0.25,0.25 }
				tint { line 0.180392,0.819608,0.819608,0.262745,0.52549,0.737255 }
				fade { point 0 }
				offset { box 0,-1,-1,0,1,1 }
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
}

