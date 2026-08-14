effect effects/mp/waveline_64
{
	size	74

	emitter "wave2"
	{
		duration	1,1
		count		3,3

		line
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/particles_shapes/waveline1"

			start
			{
				position { cylinder 0,-2,-2,0,2,2 }
				size { box 2,8 }
				fade { point 0 }
				length { point 64,0,0 }
			}

			motion
			{
				fade { envelope "cosine" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	emitter "wave3"
	{
		duration	1,1
		count		3,3

		line
		{
			duration	0.6,0.6
			blend	add
			material	"gfx/effects/particles_shapes/waveline1b"

			start
			{
				position { cylinder 0,-2,-2,0,2,2 }
				size { box 2,8 }
				fade { point 0 }
				length { point 64,0,0 }
			}

			motion
			{
				fade { envelope "cosine" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	emitter "solid2"
	{
		duration	1,1
		count		5,5

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				fade { point 0 }
				length { point 64,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				size { point 8 }
				fade { point 0.75 }
			}
		}
	}
	emitter "end2"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1_red"

			start
			{
				velocity { point 20,0,0 }
				size { point 15,15 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 5,5 }
				fade { point 1 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "end3"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1_red"

			start
			{
				position { point 64,0,0 }
				velocity { point -20,0,0 }
				size { point 15,15 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 5,5 }
				fade { point 1 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	sound "sound2"
	{
		soundShader	"ambient_light_pulse04"
		volume	0.2,0.2
	}
}


