effect effects/cinematics/intro/amed_ship_fire
{
	size	241

	spawner "flash"
	{
		count		1,1
		locked

		sprite
		{
			duration	7,7
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_roller_joint2"

			start
			{
				size { line 4,4,5,5 }
				tint { line 0.701961,0.784314,0.803922,0.4,0.54902,0.839216 }
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
				size { point 75,75 }
			}
		}
	}
	emitter "fire1"
	{
		duration	1,1
		count		2,2
		locked

		sprite
		{
			duration	12,12
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				position { cylinder 0,-20,-15,0,20,15 }
				velocity { box -8,-2,-2,8,2,2 }
				angle { box 0,0,0,1,1,1 }
				size { point 5,5 }
				tint { line 1,1,1,0.501961,0.501961,1 }
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
				size { line 80,80,100,100 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fill"
	{
		duration	1,1
		count		5,8
		locked

		sprite
		{
			duration	5,5
			blend	add
			material	"gfx/effects/weapons/plasma1"
			entityDef	"debris_roller_joint2"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box -10,-10,-10,10,0,10 }
				angle { box 0,0,-1,0,0,1 }
				size { point 20,20 }
				tint { line 1,0.501961,0.247059,0.501961,0.501961,1 }
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
				size { point 80,80 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { box -1,1 relative }
			}
		}
	}
	emitter "unnamed9"
	{
		duration	1,1
		count		5,5
		locked

		sprite
		{
			duration	7,7
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box 10,-10,-10,10,10,10 }
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
				size { point 50,50 }
			}
		}
	}
	emitter "init"
	{
		duration	1,1
		count		1,1
		locked

		sprite
		{
			duration	12,12
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
	emitter "unnamed5"
	{
		duration	1,1
		count		20,20
		locked

		sprite
		{
			duration	7,7
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			entityDef	"debris_roller_joint2"

			start
			{
				velocity { box -5,-5,-5,5,5,5 }
				size { box 10,10,20,20 }
				tint { line 1,1,1,1,0.501961,0.247059 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	emitter "ring"
	{
		duration	1,1
		count		2,2
		locked

		sprite
		{
			duration	7,7
			blend	add
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
				size { point 170,170 }
			}
		}
	}
	emitter "flash2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	10,12
			blend	add
			material	"gfx/effects/weapons/plasma1"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { box -1,-1,-1,1,1,1 }
				velocity { box -2,-2,-2,2,2,2 }
				size { line 5,5,10,10 }
				tint { line 1,0.501961,0,0.501961,0,0 }
				fade { line 0.25,1 }
			}

			motion
			{
				size { envelope cosine }
				tint { envelope linear }
				fade { envelope linear count 2 offset -1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 10,10,20,20 }
				tint { point 0.4,0.54902,0.839216 }
				rotate { box -0.0555556,0.0555556 relative }
			}
		}
	}
	emitter "flash3"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	10,12
			blend	add
			material	"gfx/effects/weapons/plasma1"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { box -1,-1,-1,1,1,1 }
				size { line 5,5,10,10 }
				fade { line 0.125,0.25 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,90,90 }
				rotate { box -0.166667,0.166667 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		2,2
		locked

		sprite
		{
			duration	12,12
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_roller_joint2"

			start
			{
				position { cylinder 0,-20,-15,0,20,15 }
				velocity { box -2,-2,-2,-0.5,2,2 }
				angle { box 0,0,0,1,1,1 }
				size { point 5,5 }
				tint { line 1,1,1,0.501961,0.501961,1 }
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
				size { line 50,50,80,80 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}







