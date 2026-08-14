effect effects/explosions/surface/airdefense_steampipes
{
	size	605

	sound "sound"
	{
		soundShader	"effects_explosion_nodebris"
		volume	20,20
		freqshift	1.2,1.2
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/energy_sparks/spark2"

			motion
			{
				size { envelope arch count 0.8,0.8 offset 0.2,0.2 }
			}

			end
			{
				size { point 200,100 }
			}
		}
	}
	spawner "side2_dust"
	{
		count		8,8

		sprite
		{
			duration	4,5
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.006,0

			start
			{
				position { box -50,-50,-20,50,50,20 }
				velocity { box 65,-20,-5,100,20,5 }
				acceleration { point -30,0,0 }
				size { point 20,20 }
				tint { line 0,0,0,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope fastinslowout }
				rotate { envelope exp_xoverx2 count 0.2 }
			}

			end
			{
				size { line 50,50,100,100 }
				fade { line 0.5,0.8 }
				rotate { box 0.277778,1.38889 relative }
			}
		}
	}
	spawner "middle_underlit"
	{
		count		4,4

		sprite
		{
			duration	1.2,2.4
			material	"gfx/effects/smoke/underlit_alpha2"

			start
			{
				position { box -20,-20,-20,20,20,20 }
				velocity { box -30,-25,-10,30,25,10 }
				size { box 20,20,40,40 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear count 1.5,1.5 }
				tint { envelope linear count 1.5,1.5,1.5 offset -0.5,-0.5,-0.5 }
				fade { envelope fastinslowout count 0.9 offset 0.1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,150,150 }
				fade { point 1 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "flame"
	{
		count		3,3

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { box -20,-20,0,20,20,0 }
				velocity { box -50,-30,-10,50,30,10 }
				size { box 10,10,30,30 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear count 2,2 }
				fade { envelope fastinslowout count 0.9 offset 0.1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,80,80 }
				fade { point 1 }
				rotate { box -0.833333,0.833333 relative }
			}
		}
	}
	spawner "side1_dust"
	{
		count		8,8

		sprite
		{
			duration	4,5
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.006,0
			flipNormal

			start
			{
				position { box -50,-50,-20,50,50,20 }
				velocity { box 65,-20,-5,100,20,5 }
				acceleration { point -30,0,0 }
				size { point 20,20 }
				tint { line 0,0,0,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope fastinslowout }
				rotate { envelope exp_xoverx2 count 0.2 }
			}

			end
			{
				size { line 50,50,100,100 }
				fade { line 0.5,0.8 }
				rotate { box 0.277778,1.38889 relative }
			}
		}
	}
	spawner "middle_dust"
	{
		count		8,8

		sprite
		{
			duration	4,5
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.003,0

			start
			{
				position { box -50,-50,-20,50,50,20 }
				velocity { box -10,-20,-5,-10,20,5 }
				size { point 20,20 }
				tint { line 0,0,0,0.501961,0.501961,0.501961 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope exp_1minusx/x2 }
				fade { envelope fastinslowout }
				rotate { envelope linear count 0.2 }
			}

			end
			{
				size { line 50,50,100,100 }
				fade { line 0.5,0.8 }
				rotate { box -0.555556,0.555556 relative }
			}
		}
	}
	spawner "side_underlit"
	{
		count		6,6

		sprite
		{
			duration	2.5,3
			material	"gfx/effects/smoke/underlit_alpha2"
			gravity		-0.003,0

			start
			{
				position { box -20,-20,-20,20,20,20 }
				velocity { box -100,-25,-10,100,25,10 }
				size { box 20,20,40,40 }
				tint { point 0,0,0 }
				fade { point 0 }
				offset { point 10,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear count 1.5,1.5 }
				tint { envelope pop_flicker_fade_nc count 0.5,0.5,0.5 offset 0.5,0.5,0.5 }
				fade { envelope fastinslowout count 0.9 offset 0.1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,150,150 }
				tint { point 1,1,1 }
				fade { point 1 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "flash2"
	{
		start		0.25,0.25
		count		1,1

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				tint { point 0.501961,0.501961,0.501961 }
			}

			motion
			{
				size { envelope arch count 0.8,0.8 offset 0.2,0.2 }
			}

			end
			{
				size { point 550,250 }
			}
		}
	}
	shake "shake"
	{
		start		0.1,0.1
		duration	1,1
		scale		0.35
		attenuateEmitter
		attenuation	500,2000
	}
	sound "steam_hiss"
	{
		soundShader	"effects_debris_light"
		volume	20,20
	}
}
