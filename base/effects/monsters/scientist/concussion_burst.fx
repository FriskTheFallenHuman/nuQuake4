effect effects/monsters/scientist/concussion_burst
{
	size	708

	sound "sound"
	{
		soundShader	"effects_explosion_nodebris"
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/explosion_impact"

			start
			{
				size { point 90,90 }
				rotate { box 0,1 }
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
	spawner "shockwave"
	{
		start		0.06,0.06
		count		1,1

		oriented
		{
			duration	0.12,0.12
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				position { point 0.02,0,0 }
				size { point 50,50 }
				tint { point 0.231373,0.231373,0.231373 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 300,300 }
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
				size { point 200,200,200 }
			}
		}
	}
	spawner "shockwave_vert"
	{
		count		1,1

		sprite
		{
			duration	0.12,0.12
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				size { point 50,50 }
				rotate { box 0.1,-0.1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	spawner "ground_sprite"
	{
		count		1,1

		oriented
		{
			duration	0.15,0.15
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 0.02,0,0 }
				size { point 35,35 }
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
				size { point 250,250 }
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
	spawner "sparks"
	{
		count		15,20

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/weapons/flash"
			gravity		0.75,1

			start
			{
				position { cylinder 1,-0.05,-0.05,1,0.05,0.05 surface }
				velocity { box 700,-100,-100,500,100,100 }
				size { box 1,1,4,4 }
				tint { point 0,0,0 }
			}

			motion
			{
				size { envelope flickerblink }
				tint { envelope popoverextreme_hold_grow }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	spawner "embers_falling"
	{
		count		12,12

		sprite
		{
			duration	0.45,0.6
			blend	add
			material	"gfx/effects/fire/embers"
			gravity		0.3,1.5

			start
			{
				position { spiral 1,-0.05,-0.05,25,0.05,0.05,10 }
				velocity { box 400,-75,-75,450,75,75 }
				size { point 2,2 }
				tint { point 0,0,0 }
				rotate { box 0.01,-0.01 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
}



