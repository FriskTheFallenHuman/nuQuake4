effect effects/cinematics/intro/asm_ship_exp
{
	size	147

	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_roller_joint2"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 35,35 }
			}
		}
	}
	spawner "fire1"
	{
		count		2,2

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 0,-20,-20,50,20,20 }
				angle { box 0,0,0,1,1,1 }
				size { point 5,5 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,92.6667 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,75,75 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "fill"
	{
		count		5,8

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"
			entityDef	"debris_roller_joint2"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box -25,-25,-25,25,25,25 }
				angle { box 0,0,-1,0,0,1 }
				size { point 10,10 }
				tint { point 1,0.501961,0.25098 }
				offset { box 0,-5,-5,0,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 40,40 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "unnamed9"
	{
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box 50,-50,-50,50,50,50 }
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
				size { point 25,25 }
			}
		}
	}
	spawner "init"
	{
		count		2,5
		locked

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_roller_joint2"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope exp_x2 }
			}

			end
			{
				size { point 75,75 }
			}
		}
	}
	spawner "unnamed5"
	{
		count		20,20

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box -60,-60,-60,60,60,60 }
				size { box 10,10,20,20 }
				tint { line 1,1,1,1,0.501961,0.25098 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	spawner "ring"
	{
		count		2,2

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash4"
			entityDef	"debris_walker_upperleg"

			start
			{
				size { point 2,2 }
				tint { point 1,0.501961,0.25098 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 80,80 }
			}
		}
	}
	sound "unnamed7"
	{
		soundShader	"effects_energy_burst"
		freqshift	1.3,1.3
	}
}


