effect effects/monsters/gladiator/railgun_mflash
{
	size	347

	light "light"
	{
		detail		0.5

		light
		{
			duration	0.1,0.1
			blend	add
			material	"lights/defaultPointLight"

			start
			{
				size { point 200,200,200 }
				tint { point 0.807843,0.815686,0.67451 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"gladiator_railgun"
	}
	emitter "steam"
	{
		detail		0.5
		duration	0.35,0.35
		count		6,6

		sprite
		{
			duration	1.3,1.3
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			gravity		-0.05,-0.05
			generatedOriginNormal

			start
			{
				velocity { box 0,-5,-5,0,5,5 }
				size { box 10,10,15,15 }
				tint { point 0.85098,0.537255,0.34902 }
				fade { point 0.75 }
				offset { box 20,0,0,40,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 30,30,40,40 }
			}
		}
	}
	emitter "steam2"
	{
		detail		0.5
		duration	0.35,0.35
		count		10,10

		sprite
		{
			duration	1.3,1.3
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"
			gravity		-0.05,-0.05
			generatedOriginNormal

			start
			{
				velocity { box 0,-10,-10,0,10,10 }
				size { box 10,10,15,15 }
				tint { point 0.85098,0.560784,0.392157 }
				fade { point 0.75 }
				offset { box 20,0,0,40,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 30,30,40,40 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	spawner "single_streak"
	{
		count		1,1
		locked

		line
		{
			duration	0.16,0.16
			blend	add
			material	"gfx/effects/energy_sparks/spark_line2"

			start
			{
				position { point -2,0,0 }
				size { point 30 }
				tint { point 0.854902,0.486275,0.360784 }
				length { box 160,0,0,180,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 3 }
				length { box 4,0,0,8,0,0 }
			}
		}
	}
	emitter "heat"
	{
		detail		0.5
		duration	0.35,0.35
		count		10,10
		locked

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"
			generatedOriginNormal

			start
			{
				velocity { point 0,-500,0 }
				size { box 30,30,40,40 }
				tint { point 0.486275,0.486275,0.666667 }
				fade { point 0 }
				offset { box 40,0,0,60,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { box 80,80,100,100 }
				tint { point 0.921569,0.894118,0.8 }
				fade { point 0.3 }
			}
		}
	}
	spawner "round flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { box 30,-3,-3,30,3,3 }
				size { point 20,20 }
				tint { point 0.917647,0.360784,0.223529 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { point 160,160 }
				tint { point 1,1,1 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 30,0,0 }
				size { point 200,200 }
				tint { point 1,0.603922,0.411765 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				size { point 80,80 }
			}
		}
	}
}












