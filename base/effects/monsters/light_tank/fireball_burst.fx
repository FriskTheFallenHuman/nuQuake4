effect effects/monsters/light_tank/fireball_burst
{
	size	425

	spawner "column_smoke"
	{
		count		6,6

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.02,-0.02

			start
			{
				position { line 0,-10,0,180,10,0 linearSpacing }
				velocity { box 0,30,0,0,40,0 }
				size { box 120,120,160,160 }
				tint { point 0.482353,0.466667,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				tint { point 0.168627,0.164706,0.141176 }
				fade { point 0.4 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	sound "sound2"
	{
		soundShader	"effects_fire_whoosh"
		freqshift	1.4,1.4
	}
	decal "wall_mark2"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/blaster_wall_mark3"

			start
			{
				size { point 200,200 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "impact_flash2"
	{
		detail		0.5
		count		1,1

		sprite
		{
			duration	0.14,0.14
			blend	add
			material	"gfx/effects/weapons/flash_green"
			generatedNormal

			start
			{
				position { point 2,0,0 }
				size { point 40,40 }
				tint { point 1,0.501961,0 }
			}

			motion
			{
				fade { envelope "exp_x2" }
			}
		}
	}
	spawner "side_impact_streaks2"
	{
		detail		0.5
		count		7,9
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { point 12 }
				length { box 48,0,0,60,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	spawner "smoke2"
	{
		detail		0.5
		count		20,20

		sprite
		{
			duration	0.8,1
			blend	add
			material	"gfx/effects/weapons/plasma2"
			gravity		-0.02,-0.02

			start
			{
				position { line 0,0,0,40,0,0 }
				velocity { box 0,-32,-32,150,32,32 }
				size { line 24,24,32,32 }
				tint { line 1,1,1,0.984314,0.431373,0.431373 }
				fade { point 0.35 }
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
				size { line 72,72,96,96 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "heat_mark"
	{
		count		2,2

		oriented
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"

			start
			{
				position { point 0.1,0,0 }
				size { point 4,4 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 300,300 }
				rotate { box 0,0,-0.111111,0,0,0.111111 relative }
			}
		}
	}
	sound "unnamed7"
	{
		soundShader	"effects_explosion_nodebris"
	}
	spawner "flash3"
	{
		detail		0.5
		count		10,10
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/fire/fire4a"

			start
			{
				velocity { box 50,-200,-200,100,200,200 }
				size { line 20,20,30,30 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 100,100,200,200 }
				rotate { box -1,1 }
			}
		}
	}
	spawner "fire1"
	{
		count		8,8

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 0,-50,-50,50,50,50 }
				angle { box 0,0,0,1,1,1 }
				size { point 5,5 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 80,80,100,100 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "sparks"
	{
		detail		0.5
		count		15,15

		sprite
		{
			duration	0.4,0.6
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				velocity { box 100,-150,-150,500,150,150 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				acceleration { point -500,0,0 }
				size { line 0.5,0.5,4,4 }
				tint { line 1,0.721569,0.309804,1,1,1 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
				angle { envelope "linear" }
			}

			end
			{
				angle { box 0.277778,0.277778,0.277778,0.555556,0.555556,0.555556 relative }
			}
		}
	}
	spawner "flash"
	{
		detail		0.5
		count		1,1

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 180,180,220,220 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
	spawner "fragments"
	{
		detail		0.5
		count		9,12

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/energy_sparks/spark_line3"
			generatedOriginNormal

			start
			{
				position { cylinder 0.025,-0.1,-0.1,0.025,0.1,0.1 }
				velocity { box 350,0,0,600,0,0 }
				size { box 8,12 }
				tint { line 1,0.937255,0.584314,1,0.709804,0.415686 }
				length { box 80,0,0,120,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
}




