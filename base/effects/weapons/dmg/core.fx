effect effects/weapons/dmg/core
{
	size	9

	emitter "unnamed8"
	{
		duration	1,1
		count		3,3
		locked

		sprite
		{
			duration	1.5,1.5
			blend	add
			material	"gfx/effects/weapons/darkmatter_ring"

			start
			{
				size { line 5,5,6,6 }
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
				tint { point 1,1,1 }
				fade { point 0.6 }
				rotate { point 0.444444 relative }
			}
		}
	}
	spawner "center"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				size { point 5,5 attenuate }
			}

			motion
			{
				size { envelope "randomflick" }
			}

			end
			{
				size { point 2,2 attenuate }
			}
		}
	}
	emitter "unnamed6"
	{
		detail		0.5
		duration	1,1
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
				position { sphere -1,-1,-1,1,1,1 surface }
				size { point 0.1 }
				tint { point 0.639216,0.568627,0.741176 }
				length { box 0.05,0,0,0.2,0,0 }
			}
		}
	}
	emitter "blacklines"
	{
		detail		0.5
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
				position { sphere -1,-1,-1,1,1,1 surface }
				size { box 0.1,0.3 }
				tint { point 0,0,0 }
				fade { point 0 }
				length { box 1,0,0,2,0,0 }
			}

			motion
			{
				fade { envelope "cosine" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.6 }
				length { box 0.5,0,0,1.5,0,0 }
			}
		}
	}
	emitter "small lines"
	{
		detail		0.5
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
				position { sphere -1,-1,-1,1,1,1 surface }
				size { box 0.03,0.05 }
				tint { point 0.803922,0.729412,0.819608 }
				fade { point 0.4 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { box 0.5,0,0,0.6,0,0 }
			}
		}
	}
	light "unnamed5"
	{
		locked

		light
		{
			duration	1,1
			material	"lights/round"

			start
			{
				position { point 0,0,1 }
				size { point 1.5,1.5,1.5 }
				tint { point 0.501961,0,1 }
				fade { point 0.3 }
			}
		}
	}
}











