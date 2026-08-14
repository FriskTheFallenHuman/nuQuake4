effect effects/monsters/berserker/release_charge
{
	size	425

	emitter "burst fill"
	{
		duration	0.25,0.25
		count		1,1

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				size { point 150,150 }
				tint { line 0.454902,0.815686,0.894118,1,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				rotate { envelope "linear_flicker" }
			}

			end
			{
				rotate { box -1,1 }
			}
		}
	}
	emitter "oriented"
	{
		duration	0.25,0.25
		count		1,1

		oriented
		{
			duration	0.1,0.1
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				size { point 150,150 }
				tint { point 0.65098,0.956863,0.941177 }
			}
		}
	}
	spawner "elect2"
	{
		detail		0.5
		count		10,10

		electricity
		{
			duration	0.1,0.1
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedNormal

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				size { box 1,3 }
				length { box 30,0,0,80,0,0 }
			}
		}
	}
	spawner "sparks_lines"
	{
		detail		0.5
		count		20,20
		locked

		line
		{
			duration	0.15,0.3
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line"
			gravity		0.15,0.25
			generatedOriginNormal

			start
			{
				position { cylinder -0.5,-0.2,-0.2,-0.5,0.2,0.2 surface }
				velocity { box -300,0,0,-600,0,0 }
				acceleration { point -50,0,0 }
				size { point 2 }
				tint { point 0.34902,0.568627,0.890196 }
				length { box 9,0,0,17,0,0 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 0 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"berserker_charge_release"
	}
	spawner "fill"
	{
		detail		0.5
		count		2,2
		locked

		oriented
		{
			duration	0.95,0.95
			blend	add
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				size { point 0,0 }
				tint { point 0.603922,0.768628,0.929412 }
				fade { point 0.25 }
				rotate { box 0,0,0,0,0,0.0555556 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	emitter "smoke"
	{
		detail		0.5
		duration	0.5,0.5
		count		8,8
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.15,-0.05

			start
			{
				size { point 5,5 }
				fade { point 0.5 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 30,30 }
				rotate { box 0,-0.5 relative }
			}
		}
	}
	emitter "fill2"
	{
		detail		0.5
		duration	1,1
		count		1,1

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/explosion_deform_grenade"

			start
			{
				size { point 0,0 }
				tint { point 0.603922,0.768628,0.929412 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		15,15

		electricity
		{
			duration	0.5,1
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				size { point 2 }
			}

			motion
			{
				length { envelope "linear" }
			}

			end
			{
				length { point 200,0,0 }
			}
		}
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact2"

			start
			{
				size { line 30,30,50,50 }
				rotate { box 0,1 }
			}
		}
	}
}







