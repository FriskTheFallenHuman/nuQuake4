effect effects/weapons/fthrow_line
{
	size	85

	sound "sound"
	{
		soundShader	"lt_tank_flame_loop"
	}
	emitter "flamecore"
	{
		duration	1,1
		count		8,8
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 5 }
				length { point 0,80,0 }
			}
		}
	}
}
