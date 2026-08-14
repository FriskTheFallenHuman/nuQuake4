effect effects/monsters/makron/dmg_makron_fly
{
	size	520

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
				size { line 250,250,300,300 }
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
				fade { point 0.6 }
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
			trailType	burn
			trailTime	1,1
			trailCount	10,10

			start
			{
				angle { box 0,0,-0.5,0,0,0.5 }
				size { box 20,20,40,40 }
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
				fade { point 0.8 }
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
				size { point 200,200 }
				offset { point 8,0,0 }
			}

			motion
			{
				size { envelope randomflick }
			}

			end
			{
				size { point 150,150 }
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
				length { box 60,0,0,140,0,0 }
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
				size { box 50,75 }
				tint { point 0,0,0 }
				fade { point 0.6 }
				length { box 60,0,0,150,0,0 }
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
				fade { point 0.4 }
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
		count		6,6

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"
			trailType	motion
			trailTime	5,5
			trailCount	10,10

			start
			{
				position { line 0,-8,-8,0,8,8 }
				size { line 240,240,360,360 }
				tint { point 0.572549,0.447059,0.619608 }
				fade { point 0.4 }
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
		soundShader	"makron_dmg_hum"
	}
	sound "unnamed9"
	{
		soundShader	"weapon_darkmatter_energy_loop"
	}
}

