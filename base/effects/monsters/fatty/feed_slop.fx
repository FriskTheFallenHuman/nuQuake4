effect effects/monsters/fatty/feed_slop
{
	size	149

	emitter "spray"
	{
		duration	1,1
		count		30,30

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/monsters/slimy_transfer/puke_drip_add"
			gravity		0.05,0.75

			start
			{
				velocity { box 20,-50,-50,250,50,50 }
				size { box 1,5 }
				tint { line 0.717647,0.678431,0.576471,0.776471,0.835294,0.717647 }
				fade { line 0.5,1 }
				length { box 5,0,0,30,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 0 }
			}

			impact
			{
				remove	1
			}
		}
	}
}
