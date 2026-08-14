effect effects/mp/player_teleport
{
	size	198

	spawner "smoke"
	{
		detail		0.5
		count		3,3

		sprite
		{
			duration	1.5,1.5
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.02,-0.02

			start
			{
				position { line -20,-5,-5,-16,5,5 }
				velocity { box 5,0,0,50,0,0 }
				size { line 40,40,50,50 }
				tint { line 0.745098,0.788235,0.776471,0.588235,0.737255,0.682353 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 80,80,120,120 }
				fade { point 0.5 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	sound "sound"
	{
		soundShader	"mp_player_sounds_teleport_in"
	}
}

