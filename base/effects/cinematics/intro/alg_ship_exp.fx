effect effects/cinematics/intro/alg_ship_exp
{
	size	514

	spawner "flash"
	{
		count		2,5
		locked

		sprite
		{
			duration	3,3
			persist
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_roller_joint2"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.701961,0.784314,0.803922 }
				offset { point 10,0,0 }
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
				size { point 150,150 }
			}
		}
	}
	spawner "fire1"
	{
		count		5,5

		sprite
		{
			duration	3,3
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 0,-20,-20,50,20,20 }
				angle { box 0,0,0,1,1,1 }
				size { point 5,5 }
				tint { line 0.501961,0.501961,1,1,1,1 }
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
				size { line 200,200,250,250 }
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
			duration	3,5
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"
			entityDef	"debris_roller_joint2"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box -50,-50,-50,50,50,50 }
				angle { box 0,0,-1,0,0,1 }
				size { point 20,20 }
				tint { line 1,0.501961,0.247059,1,1,1 }
				offset { box 10,-5,-5,10,5,5 }
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
				size { point 220,220 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { box -1,1 relative }
			}
		}
	}
	spawner "unnamed9"
	{
		count		10,10

		sprite
		{
			duration	3,3
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box 50,-100,-100,50,100,100 }
				tint { line 1,1,1,0.501961,0.501961,1 }
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
				size { point 100,100 }
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
			persist
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_roller_joint2"

			start
			{
				size { line 4,4,5,5 }
				tint { line 0.701961,0.784314,0.803922,0.501961,0.501961,1 }
				offset { point 10,0,0 }
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
				size { point 300,300 }
			}
		}
	}
	spawner "unnamed5"
	{
		count		20,20

		sprite
		{
			duration	3,3
			blend	add
			persist
			material	"gfx/effects/energy_sparks/spark3"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box -180,-200,-200,180,200,200 }
				size { box 10,10,20,20 }
				tint { line 1,1,1,1,0.501961,0.247059 }
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
			duration	3,3
			blend	add
			persist
			material	"gfx/effects/energy_sparks/launch_flash4"
			entityDef	"debris_walker_upperleg"

			start
			{
				size { point 2,2 }
				tint { point 1,0.501961,0.247059 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 350,350 }
			}
		}
	}
	sound "unnamed8"
	{
		soundShader	"effects_explosion_fiery"
		volume	0.3,0.3
	}
}



