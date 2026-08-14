effect effects/weapons/dmg/core_start
{
	size	8

	emitter "unnamed8"
	{
		start		0.25,0.25
		duration	3,3
		count		2,2
		locked

		sprite
		{
			duration	4,4
			blend	add
			material	"gfx/effects/weapons/darkmatter_ring"

			start
			{
				size { point 0,0 }
				tint { point 0.501961,0,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 5,5 }
				tint { point 1,1,1 }
				fade { point 0.6 }
				rotate { point 0.444444 relative }
			}
		}
	}
	spawner "center"
	{
		start		0.25,0.25
		count		1,1
		locked

		sprite
		{
			duration	3,3
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				size { point 0,0 attenuate }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 2,2 attenuate }
			}
		}
	}
	emitter "blacklines 1"
	{
		detail		0.5
		start		0.25,0.25
		duration	1,1
		count		60,60
		locked

		line
		{
			duration	0.4,0.4
			material	"gfx/effects/particles_shapes/blend_sphere2.tga"
			generatedNormal

			start
			{
				position { sphere -0.1,-0.1,-0.1,0.1,0.1,0.1 surface }
				size { box 0.05,0.1 }
				tint { point 0,0,0 }
				fade { point 0 }
				length { box 0.15,0,0,0.5,0,0 }
			}

			motion
			{
				fade { envelope "cosine" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.6 }
				length { box 0.05,0,0,0.4,0,0 }
			}
		}
	}
	emitter "blacklines"
	{
		detail		0.5
		start		0.5,0.5
		duration	1,1
		count		60,60
		locked

		line
		{
			duration	0.4,0.4
			material	"gfx/effects/particles_shapes/blend_sphere2.tga"
			generatedNormal

			start
			{
				position { sphere -0.25,-0.25,-0.25,0.25,0.25,0.25 surface }
				size { box 0.1,0.15 }
				tint { point 0,0,0 }
				fade { point 0 }
				length { box 0.25,0,0,0.75,0,0 }
			}

			motion
			{
				fade { envelope "cosine" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.6 }
				length { box 0.1,0,0,0.75,0,0 }
			}
		}
	}
	emitter "blacklines2"
	{
		detail		0.5
		start		1.5,1.5
		duration	1,1
		count		60,60
		locked

		line
		{
			duration	0.4,0.4
			material	"gfx/effects/particles_shapes/blend_sphere2.tga"
			generatedNormal

			start
			{
				position { sphere -0.5,-0.5,-0.5,0.5,0.5,0.5 surface }
				size { box 0.15,0.2 }
				tint { point 0,0,0 }
				fade { point 0 }
				length { box 0.5,0,0,1,0,0 }
			}

			motion
			{
				fade { envelope "cosine" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.6 }
				length { box 0.25,0,0,1,0,0 }
			}
		}
	}
	emitter "blacklines3"
	{
		detail		0.5
		start		2.5,2.5
		duration	1,1
		count		60,60
		locked

		line
		{
			duration	0.4,0.4
			material	"gfx/effects/particles_shapes/blend_sphere2.tga"
			generatedNormal

			start
			{
				position { sphere -0.8,-0.8,-0.8,0.8,0.8,0.8 surface }
				size { box 0.2,0.25 }
				tint { point 0,0,0 }
				fade { point 0 }
				length { box 0.5,0,0,1,0,0 }
			}

			motion
			{
				fade { envelope "cosine" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.6 }
				length { box 0.25,0,0,1,0,0 }
			}
		}
	}
	emitter "unnamed6"
	{
		duration	3,3
		count		40,40
		locked

		electricity
		{
			duration	0.06,0.06
			fork	0
			jitterRate	0
			jitterSize	0.1,0.3,0.3
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/darkmatterbolt"
			generatedNormal

			start
			{
				position { sphere -0.01,-0.01,-0.01,0.01,0.01,0.01 surface }
				size { point 0.1 }
				tint { point 0.639216,0.568627,0.741176 }
				length { box 1,0,0,2,0,0 }
			}
		}
	}
	light "unnamed5"
	{
		start		0.25,0.25
		locked

		light
		{
			duration	3,3
			material	"lights/round"

			start
			{
				position { point 0,0,1 }
				size { point 0,0,0 }
				tint { point 0.501961,0,1 }
				fade { point 0.3 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 1.5,1.5,1.5 }
			}
		}
	}
}




