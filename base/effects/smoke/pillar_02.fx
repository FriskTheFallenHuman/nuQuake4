effect effects/smoke/pillar_02
{
	size	10200

	emitter "Pillar"
	{
		duration	6,6
		count		0.3,0.3

		sprite
		{
			duration	30,30
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				velocity { box 300,-30,-30,300,30,30 }
				size { box 800,800,1000,1000 }
				tint { line 0.172549,0.160784,0.113725,0.145098,0.145098,0.145098 }
				offset { point 0,50,50 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope exp_x2 }
				offset { envelope linear }
				angle { envelope sintable }
				rotate { envelope linear }
			}

			end
			{
				size { point 4000,4000 }
				offset { box 0,300,300,0,400,400 }
				angle { box 0,0,1,0,0,0.833333 }
				rotate { box -1,1 relative }
			}
		}
	}
	emitter "Pillar2"
	{
		duration	6,6
		count		0.1,0.1

		sprite
		{
			duration	30,30
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				velocity { box 300,-30,-30,300,30,30 }
				size { box 800,800,1000,1000 }
				tint { line 0.25098,0.188235,0.101961,0.266667,0.192157,0.0901961 }
				offset { point 0,50,50 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope exp_x2 }
				offset { envelope linear }
				angle { envelope sintable }
				rotate { envelope linear }
			}

			end
			{
				size { point 4000,4000 }
				offset { box 0,300,300,0,400,400 }
				angle { box 0,0,1,0,0,0.833333 }
				rotate { box -1,1 relative }
			}
		}
	}
}




