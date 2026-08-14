effect effects/monsters/gladiator/blaster_mflash
{
	size	211

	sound "sound"
	{
		soundShader	"gladiator_blaster"
	}
	light "light"
	{
		detail		0.5
		locked

		light
		{
			duration	0.06,0.06
			material	"lights/defaultPointLight"

			start
			{
				position { point 5,0,0 }
				size { point 120,120,120 }
				tint { line 0.803922,0.4,0.262745,0.815686,0.592157,0.443137 }
			}
		}
	}
	emitter "smoke"
	{
		detail		0.5
		start		0.4,0.4
		duration	1,1
		count		12,12

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.05,-0.05

			start
			{
				position { point 5,0,0 }
				velocity { box 50,-5,-5,15,5,5 }
				size { line 1,1,2,2 }
				tint { line 0.34902,0.345098,0.309804,0.262745,0.25098,0.211765 }
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
				size { line 15,15,20,20 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	spawner "sidestreaks2"
	{
		detail		0.5
		count		20,20
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/energy_sparks/spark_line2"

			start
			{
				position { point 10,0,0 }
				size { box 2,8 }
				tint { line 0.921569,0.411765,0.321569,0.913726,0.619608,0.329412 }
				fade { point 0.5 }
				length { box 5,-15,-40,10,15,40 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 0.5,1 }
				length { point 1,1,1 }
			}
		}
	}
	spawner "sparks_lines"
	{
		detail		0.5
		count		6,6

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			gravity		0.1,0.2
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { box 0,0,0,80,0,0 }
				size { box 0.5,1.5 }
				tint { line 1,0.984314,0.831373,1,0.701961,0.364706 }
				fade { point 0 }
				length { box 1,0,0,4,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				size { point 0 }
				fade { point 1 }
			}
		}
	}
	spawner "sparks"
	{
		count		16,16
		locked

		sprite
		{
			duration	0.25,0.35
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		0.04,0.08

			start
			{
				position { point -3,0,0 }
				velocity { box 25,-10,-100,100,10,100 }
				size { line 5,5,35,35 }
				tint { line 0.811765,0.419608,0.321569,0.796079,0.278431,0.690196 }
				fade { point 0.35 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
			}
		}
	}
	spawner "flash"
	{
		count		3,3
		locked

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash"

			start
			{
				position { box 10,-1,-1,10,1,1 }
				size { line 2,2,6,6 }
				tint { line 0.894118,0.639216,0.572549,0.717647,0.109804,0.0745098 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 60,60,80,80 }
				rotate { box -10,10 }
			}
		}
	}
	spawner "inward_flash"
	{
		detail		0.5
		count		1,1
		locked

		sprite
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"

			start
			{
				position { point 25,0,0 }
				size { box 80,80,120,120 }
				fade { point 0.2 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 40,40,60,60 }
			}
		}
	}
}








