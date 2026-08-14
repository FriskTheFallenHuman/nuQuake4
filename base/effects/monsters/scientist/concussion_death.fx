effect effects/monsters/scientist/concussion_death
{
	size	782

	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact"

			start
			{
				size { point 150,150 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "white_round_alpha0"
	{
		count		1,1

		sprite
		{
			duration	0.75,0.75
			material	"gfx/effects/smoke/white_alpha"
			gravity		-0.05,-0.01

			start
			{
				position { sphere 20,-50,-50,20,50,50 }
				velocity { box 10,-10,-10,10,10,10 }
				size { point 0,0 }
				tint { point 0.886275,0.827451,0.768628 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	spawner "white_round_alpha1"
	{
		count		1,1

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/white_alpha"
			gravity		-0.05,-0.01

			start
			{
				position { sphere 10,-50,-50,10,50,50 }
				velocity { box 10,-10,-10,10,10,10 }
				size { point 0,0 }
				rotate { point -0.08 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	spawner "white_flash"
	{
		count		1,1

		sprite
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				velocity { box 300,-50,-50,400,50,50 }
				size { point 0,0 }
			}

			motion
			{
				size { envelope pop_hold }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	emitter "ground_sprite2"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 0.05,0,0 }
				size { point 100,100 }
				tint { line 1,1,1,0.866667,0.8,0.54902 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	spawner "white_round_alpha3"
	{
		count		1,1

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/white_alpha"
			gravity		-0.05,-0.01

			start
			{
				position { sphere 10,-50,-50,10,50,50 }
				velocity { box 10,-10,-10,10,10,10 }
				size { point 0,0 }
				rotate { point 0.08 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { point 250,250 }
			}
		}
	}
	sound "first_sound"
	{
		soundShader	"effects_explosion_nodebris"
	}
	spawner "warm_round_add3"
	{
		count		1,1

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/warm_blend"
			gravity		-0.05,-0.01

			start
			{
				position { point 10,0,0 }
				velocity { box 10,-10,-10,10,10,10 }
				size { point 0,0 }
				tint { point 0.937255,0.913726,0.603922 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope cosine offset 0.5,0.5,0.5 }
			}

			end
			{
				size { point 250,250 }
			}
		}
	}
	light "light"
	{
		locked

		light
		{
			duration	0.2,0.2
			material	"lights/defaultPointLight"

			start
			{
				position { point 5,0,0 }
				size { point 450,450,450 }
				tint { point 0.921569,0.337255,0 }
			}
		}
	}
	spawner "flash3"
	{
		count		1,1

		sprite
		{
			duration	0.08,0.08
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				position { point 2,0,0 }
				size { point 100,100 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	spawner "large streaks"
	{
		start		0.05,0.05
		count		10,10
		locked

		line
		{
			duration	0.08,0.08
			blend	add
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { cylinder 0,-1,-1,0,1,1 }
				length { box 45,-100,-100,100,100,100 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { box 25,8 }
			}
		}
	}
	spawner "streaks"
	{
		start		0.06,0.06
		count		1,1

		line
		{
			duration	0.18,0.18
			material	"gfx/effects/weapons/flash_half"

			start
			{
				position { point -100,0,0 }
				size { point 10 }
				length { box 100,-30,-30,100,30,30 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 150 }
				length { point 250,0,0 }
			}
		}
	}
}



