effect effects/weapons/dmg/ambient
{
	size	283

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
				size { point 60,60 }
				fade { point 0.5 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope cosine }
				fade { envelope linear }
			}

			end
			{
				size { box 100,100,150,150 }
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
				size { line 80,80,180,180 }
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
				fade { point 0.3 }
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
				size { point 70,70 }
				fade { point 0.5 }
				offset { point 8,0,0 }
			}

			motion
			{
				size { envelope randomflick }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	emitter "electricity"
	{
		duration	1,1
		count		40,40
		locked

		electricity
		{
			duration	0.06,0.06
			fork	0
			jitterRate	0
			jitterSize	6,14,14
			material	"gfx/effects/weapons/darkmatterbolt"
			generatedNormal

			start
			{
				position { sphere -30,-30,-30,30,30,30 surface }
				size { point 4 }
				tint { point 0.639216,0.572549,0.745098 }
				fade { point 0.5 }
				length { box 40,0,0,100,0,0 }
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
				size { box 10,15 }
				tint { point 0,0,0 }
				fade { point 0.3 }
				length { box 40,0,0,100,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
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
				fade { point 0.2 }
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
		count		1,1
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
		count		6,6

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { line 0,-8,-8,0,8,8 }
				size { line 50,50,100,100 }
				tint { point 0.572549,0.447059,0.619608 }
				fade { point 0.2 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	sound "unnamed8"
	{
		soundShader	"weapon_darkmatter_energy_loop"
	}
	sound "unnamed9"
	{
		soundShader	"effects_arc_loop"
		volume	0.1,0.1
	}
}

