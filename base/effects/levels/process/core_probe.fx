effect effects/levels/process/core_probe
{
	size	260

	spawner "Arc"
	{
		start		1,1
		count		2,2

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue"

			start
			{
				size { point 5 }
				tint { point 0.74902,0.941177,0.854902 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}
		}
	}
	light "FlashyLite"
	{
		start		1,1

		light
		{
			duration	1,1
			material	"lights/rav_spot"

			start
			{
				size { point 150,150,150 }
				tint { point 0.8,1,1 }
			}
		}
	}
	sound "ZapSound"
	{
		start		1,1
		soundShader	"effects_sparks03"
	}
	spawner "OriginFlash"
	{
		count		1,1

		sprite
		{
			duration	2,2
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 0,0 }
				fade { point 0 }
			}

			motion
			{
				size { envelope cosine }
				fade { envelope cosine }
			}

			end
			{
				size { point 30,30 }
				fade { point 1 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"process_core_power_up"
		freqshift	3,3
	}
	sound "unnamed5"
	{
		start		1,1
		soundShader	"effects_energy_burst"
		freqshift	1.4,1.4
	}
}





