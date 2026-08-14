effect effects/monsters/bossbuddy/fly2
{
	size	341

	emitter "center2"
	{
		duration	1,1
		count		7,7
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				size { point 50,50 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope cosine }
				fade { envelope linear }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	emitter "swirl"
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
				size { point 180,180 }
				tint { point 0.501961,0,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				tint { point 1,1,1 }
				fade { point 1 }
				rotate { point 0.444444 relative }
			}
		}
	}
	emitter "dots"
	{
		duration	1,1
		count		15,30
		locked

		sprite
		{
			duration	0.75,0.75
			persist
			material	"gfx/effects/weapons/darkmatter_dot"

			start
			{
				angle { box 0,0,-0.5,0,0,0.5 }
				size { box 5,5,10,10 }
				tint { point 0.827451,0.623529,0.909804 }
				fade { point 0 }
				offset { box -200,-200,-200,-200,200,200 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				offset { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 5,5,40,40 }
				fade { point 0.5 }
				offset { box 0,0,0,20,20,20 }
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
				size { point 100,100 }
				offset { point 8,0,0 }
			}

			motion
			{
				size { envelope randomflick }
			}

			end
			{
				size { point 60,60 }
			}
		}
	}
	emitter "electricity"
	{
		duration	1,1
		count		15,15
		locked

		electricity
		{
			duration	0.2,0.2
			fork	1
			jitterRate	0.05
			jitterSize	6,10,10
			material	"gfx/effects/weapons/darkmatterbolt"
			generatedNormal

			start
			{
				position { sphere -30,-30,-30,30,30,30 surface }
				size { point 5 }
				tint { point 0.639216,0.572549,0.745098 }
				length { point 60,0,0 }
			}

			motion
			{
				length { envelope linear }
			}
		}
	}
	emitter "blacklines"
	{
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
				position { sphere -20,-20,-20,20,20,20 surface }
				size { box 5,15 }
				tint { point 0,0,0 }
				fade { point 0 }
				length { box 60,0,0,150,0,0 }
			}

			motion
			{
				fade { envelope fastinslowout }
				length { envelope linear }
			}

			end
			{
				fade { line 0.5,0.7 }
				length { box 10,0,0,30,0,0 }
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
				position { sphere -20,-20,-20,20,20,20 surface }
				size { box 0.5,1.5 }
				tint { point 0.803922,0.729412,0.819608 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { box 15,0,0,30,0,0 }
			}
		}
	}
	emitter "deform"
	{
		duration	1,1
		count		2,2
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/explosion_deform3"

			start
			{
				size { point 200,200 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}
		}
	}
	emitter "trail"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { line 0,-8,-8,0,8,8 }
				size { point 100,100 }
				tint { point 0.572549,0.447059,0.619608 }
				fade { point 0.4 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
}
