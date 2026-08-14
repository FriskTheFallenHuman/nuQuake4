effect effects/ambient/fly_cloud
{
	size	74

	emitter "fly cloud"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/flies"

			start
			{
				position { sphere 0,-40,-40,0,40,40 }
				velocity { point 20,0,0 }
				angle { box 0,0,0,0.861111,0.861111,0.861111 }
				size { line 0.65,0.65,1.25,1.25 }
				tint { line 0,0,0,0.247059,0.219608,0.145098 }
				fade { point 0 }
				offset { box 0,-30,-30,0,30,30 }
				rotate { box 0,0.527778 }
			}

			motion
			{
				fade { envelope pop_fade }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box 0.111111,0.111111,0.111111,0.222222,0.222222,0.222222 }
				rotate { box 0.527778,1 relative }
			}
		}
	}
	sound "sound"
	{
		soundShader	"effects_flies"
	}
}


