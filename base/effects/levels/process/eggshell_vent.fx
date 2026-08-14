effect effects/levels/process/eggshell_vent
{
	size	295

	emitter "STEAM"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { sphere -50,-50,0,50,50,0 }
				velocity { box 150,-20,-20,200,20,20 }
				size { point 20,20 }
				tint { point 0.843137,0.988235,1 }
				fade { point 0 }
				rotate { box -0.25,0.25 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope exp_1minusx/x2 }
				fade { envelope fast_in_slow_out }
				rotate { envelope linear }
			}

			end
			{
				size { box 100,100,125,125 }
				tint { point 0.701961,0.807843,0.85098 }
				fade { point 0.5 }
			}
		}
	}
	sound "unnamed1"
	{
		soundShader	"effects_steam_blast3"
	}
}




