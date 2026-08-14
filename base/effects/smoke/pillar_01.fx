effect effects/smoke/pillar_01
{
	size	9089

	emitter "Pillar"
	{
		duration	6,6
		count		1,1

		sprite
		{
			duration	30,30
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 300,-30,-30,300,30,30 }
				size { box 600,600,700,700 }
				tint { line 0.227451,0.207843,0.172549,0,0,0 }
				fade { point 0 }
				offset { box 0,150,150,0,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope decalfade }
				offset { envelope linear }
				angle { envelope sintable }
				rotate { envelope linear }
			}

			end
			{
				size { point 2000,2000 }
				fade { point 1 }
				offset { box 0,300,300,0,400,400 }
				angle { box 0,0,1,0,0,0.833333 }
				rotate { point 0.5 }
			}
		}
	}
	emitter "HotSpots"
	{
		duration	6,6
		count		0.4,0.4

		sprite
		{
			duration	50,50
			material	"gfx/effects/smoke/underlit_alpha"

			start
			{
				velocity { box 300,-30,-30,300,30,30 }
				size { box 500,500,700,700 }
				tint { point 1,0.541176,0.0352941 }
				fade { point 0.35 }
				offset { box 0,80,80,0,10,10 }
				rotate { box 0.305556,0.416667 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				offset { envelope linear }
				angle { envelope sintable count 1,1,0.5 }
			}

			end
			{
				size { point 1500,1500 }
				offset { box 0,120,120,0,240,240 }
				angle { point 0,0,1 }
			}
		}
	}
}



