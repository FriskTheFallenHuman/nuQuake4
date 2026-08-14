effect effects/monsters/scientist/gas_grenade_burst
{
	size	417

	sound "sound"
	{
		soundShader	"scientist_chemical_grenade"
		volume	30,30
	}
	decal "fluid decal"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/fluids_drips/gas_fluid"

			start
			{
				size { point 40,40 }
				rotate { box 0,1 }
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
				offset { point 0,0,20 }
			}

			motion
			{
				size { envelope "exp_1minusx/x2" count 0.5,0.5 }
				tint { envelope "exp_1minusx/x2" count 0.5,0.5,0.5 }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 300,300 }
			}
		}
	}
	spawner "chunks"
	{
		detail		0.5
		count		8,8

		model
		{
			duration	0.5,0.5
			material	"gfx/test/rocket_chunks"
			model		"models/test/rocket_chunk.lwo"
			gravity		0.75,0.75
			generatedOriginNormal

			start
			{
				position { sphere 0.1,-0.2,-0.2,0.1,0.2,0.2 surface }
				velocity { box 200,0,0,350,0,0 }
				tint { point 0.752941,0.752941,0.752941 }
				rotate { box 0,0,0,0.333333,0.333333,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.333333,0.333333,0.666667,0.666667,0.666667 relative }
			}
		}
	}
	spawner "steam2"
	{
		detail		0.5
		start		0.1,0.1
		count		6,6

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 5,-30,-30,10,30,30 }
				size { box 20,20,40,40 }
				tint { line 0.576471,0.92549,0.584314,0.784314,0.768628,0.45098 }
				fade { line 0.25,0.5 }
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
				size { box 100,100,150,150 }
				rotate { box -0.0277778,0.0277778 }
			}
		}
	}
	spawner "steam3"
	{
		start		0.1,0.1
		count		6,6

		sprite
		{
			duration	3,4
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 10,-15,-15,20,15,15 }
				size { box 20,20,40,40 }
				tint { line 0.576471,0.921569,0.584314,0.784314,0.768628,0.447059 }
				fade { line 0.25,0.5 }
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
				size { box 100,100,150,150 }
				rotate { box -0.0277778,0.0277778 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				size { point 200,200 }
				tint { point 0.545098,0.65098,0.47451 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
}








