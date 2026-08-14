effect effects/monsters/light_tank/powerup
{
	size	36

	emitter "glow"
	{
		detail		0.5
		duration	1,1
		count		8,8
		locked

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { cylinder -8,-8,-8,8,8,8 }
				velocity { box 10,-10,-10,10,10,10 }
				size { point 15,15 }
				tint { line 0,1,0,0,1,0.25098 }
				fade { point 0.25 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 2,2 }
				rotate { box 0,-0.5 relative }
			}
		}
	}
	emitter "small lines"
	{
		duration	1,1
		count		200,200
		locked

		line
		{
			duration	0.1,0.1
			material	"gfx/effects/particles_shapes/blend_sphere2.tga"
			generatedNormal

			start
			{
				position { sphere -5,-5,-5,5,5,5 surface }
				size { box 0.5,1.5 }
				tint { point 0.47451,1,0.47451 }
				fade { point 0.4 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 5,0,0,10,0,0 }
			}
		}
	}
	emitter "smoke2"
	{
		duration	1,1
		count		4,4

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { cylinder -5,-5,-5,5,5,5 }
				size { line 10,10,15,15 }
				fade { line 0.75,1 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope "cosine" }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 5,5 }
				rotate { box 0,-0.5 relative }
			}
		}
	}
}


