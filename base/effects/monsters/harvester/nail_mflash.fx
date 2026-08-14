effect effects/monsters/harvester/nail_mflash
{
	size	143

	spawner "flash3"
	{
		count		1,1
		locked

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/shotgun_mflash"

			start
			{
				position { point 2,0,0 }
				size { point 100,100 }
				tint { line 1,1,1,1,0.501961,0.247059 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
			}
		}
	}
	spawner "smokeline"
	{
		count		1,1
		locked

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/steam_source"

			start
			{
				size { point 5 }
				length { point 1,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { point 50,0,0 }
			}
		}
	}
	spawner "line_gritty2"
	{
		count		5,5
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/fire/embers"
			generatedOriginNormal

			start
			{
				position { cylinder 1,-0.25,-0.25,1,0.25,0.25 }
				size { box 5,8 }
				length { box 60,0,0,80,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 0 }
			}
		}
	}
	spawner "single_streak2"
	{
		count		1,1
		locked

		line
		{
			duration	0.06,0.06
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 8 }
				length { box 90,0,0,120,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 4 }
				length { box 10,0,0,16,0,0 }
			}
		}
	}
	spawner "smoke"
	{
		start		0.1,0.1
		count		9,9
		locked

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { sphere 0,-15,-15,0,15,15 }
				velocity { box 5,-30,-60,10,30,60 }
				size { point 5,5 }
				tint { point 0.752941,0.733333,0.603922 }
				fade { point 0.8 }
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
				size { line 10,10,40,40 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed9"
	{
		soundShader	"weapon_nailgun_fire"
		freqshift	0.7,1.4
	}
}





