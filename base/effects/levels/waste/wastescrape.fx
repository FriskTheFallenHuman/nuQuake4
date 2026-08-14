effect effects/levels/waste/wastescrape
{
	size	277

	emitter "bloodMist"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0.1,0.25

			start
			{
				position { line 0,-40,0,30,40,0 }
				velocity { box 200,-100,50,350,100,150 }
				size { line 20,20,40,40 }
				tint { line 0.658824,0.14902,0.0745098,0.141176,0.0235294,0.0156863 }
				fade { line 0.6,0.8 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,100,100 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "bloodDrips"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	0.5,0.75
			persist
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.3,0.6

			start
			{
				position { line 0,-30,0,20,30,0 }
				velocity { box 300,-100,50,400,100,250 }
				size { point 20,20 }
				tint { line 0.494118,0.0196078,0.0196078,0.0901961,0.0196078,0.00784314 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 4 offset -3 }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,75,75 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}


