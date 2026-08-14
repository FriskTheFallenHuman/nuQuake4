effect effects/monsters/scientist/gas_grenade_death
{
	size	288

	decal "fluid decal"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/fluids_drips/gas_fluid"

			start
			{
				size { point 80,80 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "ground_sprite1"
	{
		detail		0.5
		count		1,1

		oriented
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/white_alpha"

			start
			{
				position { point 10,0,0 }
				size { point 0,0 }
				tint { point 0.403922,0.886275,0.427451 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	spawner "ground_sprite_2"
	{
		start		0.06,0.06
		count		1,1

		oriented
		{
			duration	1.5,1.5
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { point 1,0,0 }
				size { point 0,0 }
				tint { point 0.643137,0.933333,0.658824 }
			}

			motion
			{
				size { envelope "exp_1minusx/x2" count 0.5,0.5 }
				tint { envelope "exp_1minusx/x2" count 0.5,0.5,0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	spawner "steam2"
	{
		count		10,30

		sprite
		{
			duration	1.5,1.5
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.025,-0.025
			generatedNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				velocity { box 0,0,-100,0,0,100 }
				size { point 0,0 }
				tint { line 0.576471,0.92549,0.584314,0.784314,0.768628,0.45098 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "fill"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				size { point 200,200 }
				tint { point 0.501961,0.611765,0.388235 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
}




