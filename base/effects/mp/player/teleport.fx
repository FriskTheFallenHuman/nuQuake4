effect effects/mp/player/teleport
{
	size	140

	sound "unnamed0"
	{
		soundShader	"mp_player_sounds_teleport"
	}
	emitter "unnamed1"
	{
		duration	0.25,0.25
		count		60,60

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/blue_pill"

			start
			{
				angle { box 0,0,0,0,0,1 }
				size { point 10 }
				tint { point 1,1,0 }
				fade { line 0.5,0.8 }
				offset { box 0,25,0,0,30,0 }
				length { box 90,0,0,100,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				angle { envelope linear }
			}

			end
			{
				angle { box 0,0,-0.5,0,0,0.5 relative }
			}
		}
	}
	spawner "unnamed2"
	{
		count		50,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/blue_spark"
			gravity		0.01,0.05

			start
			{
				position { cylinder 10,-40,-40,100,40,40 }
				velocity { box 0,-10,-10,0,10,10 }
				size { point 12,12 }
				tint { line 1,1,0,1,0.501961,0 }
				fade { line 0.5,0.9 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	delay "unnamed3"
	{
		duration	3,3
	}
}



