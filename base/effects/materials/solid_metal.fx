effect effects/materials/solid_metal
{
	size	485

	spawner "streaks"
	{
		count		5,5
		locked

		line
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash_half"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { cylinder 2,-0.5,-0.5,2,0.5,0.5 surface }
				velocity { point 50,0,0 }
				size { box 0.5,1 }
				tint { point 0.501961,0.501961,0.501961 }
				length { box 10,-10,-10,10,10,10 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { box 15,-15,-15,15,15,15 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"bullet_impact_metal"
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/bulleth02"

			start
			{
				rotate { point 0.180556 }
			}
		}
	}
	spawner "flash"
	{
		count		3,3

		sprite
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 3,0,0 }
				fade { point 0.6 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 15,15 }
			}
		}
	}
	spawner "sparks2"
	{
		count		2,3

		sprite
		{
			duration	0.25,0.5
			material	"gfx/effects/weapons/flash"
			gravity		0.5,1

			start
			{
				velocity { box 100,-150,-150,300,150,150 }
			}

			motion
			{
				size { envelope flickerblink }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	spawner "sparks_pyschics2"
	{
		count		1,2

		sprite
		{
			duration	2,3
			material	"gfx/effects/weapons/flash"
			gravity		0.5,1

			start
			{
				position { point 1,0,0 }
				velocity { box 100,-150,-150,300,150,150 }
			}

			motion
			{
				size { envelope flickerblink }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
			}

			impact
			{
				bounce	0.5
			}
		}
	}
	spawner "streaks_flat"
	{
		count		5,5
		locked

		line
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash_half"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { cylinder 2,-0.5,-0.5,2,0.5,0.5 surface }
				velocity { point 50,0,0 }
				size { box 0.5,1 }
				tint { point 0.501961,0.501961,0.501961 }
				length { box 1,-10,-10,1,10,10 }
			}

			motion
			{
				length { envelope linear }
			}

			end
			{
				length { box 1,-25,-25,1,25,25 }
			}
		}
	}
}


