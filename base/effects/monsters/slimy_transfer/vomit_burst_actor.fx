effect effects/monsters/slimy_transfer/vomit_burst_actor
{
	size	303

	spawner "spray"
	{
		detail		0.5
		count		15,25

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/monsters/slimy_transfer/puke_drip_add"
			gravity		0.75,0.75
			trailType	burn
			trailTime	0.3,0.3
			trailCount	2,2

			start
			{
				velocity { box 80,-200,-200,250,200,200 }
				size { point 2 }
				tint { line 0.717647,0.678431,0.576471,0.776471,0.835294,0.717647 }
				fade { line 0.25,1 }
				length { point 5,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
	sound "unnamed7"
	{
		soundShader	"failedtransfer_vomit_plop"
	}
	spawner "mflash1"
	{
		count		10,10
		locked

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fluids_drips/stroy_spit"
			gravity		0.2,0.2
			generatedOriginNormal

			start
			{
				position { cylinder 0.45,-0.5,-0.5,0.45,0.5,0.5 }
				velocity { box 45,-70,-70,45,70,70 }
				size { point 10 }
				tint { line 0.345098,0.223529,0.00392157,0.223529,0.180392,0.0431373 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 22 }
				length { box 100,0,0,200,0,0 }
			}
		}
	}
	spawner "spray2"
	{
		count		10,15

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/monsters/slimy_transfer/puke_drip_add"
			gravity		0.75,0.75
			trailType	burn
			trailTime	0.2,0.2
			trailCount	3,3

			start
			{
				velocity { box 80,-200,-200,250,200,200 }
				size { point 2 }
				tint { line 0.717647,0.678431,0.576471,0.776471,0.835294,0.717647 }
				fade { line 0.25,1 }
				length { point 5,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}
		}
	}
}


