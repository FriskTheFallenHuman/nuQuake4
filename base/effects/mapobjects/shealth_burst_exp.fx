effect effects/mapobjects/shealth_burst_exp
{
	size	37

	spawner "leakage3"
	{
		count		10,10
		locked

		line
		{
			duration	0.25,0.5
			generatedLine
			material	"gfx/effects/fluids_drips/stroy_spit_alpha"
			generatedOriginNormal

			start
			{
				position { line 0.95,-1,-1,0.95,1,1 }
				velocity { box 10,-10,-10,10,10,10 }
				angle { box 0,0,-1,0,0,1 }
				size { box 5,8 }
				tint { line 1,1,1,0.901961,0.882353,0.6 }
				fade { point 0.5 }
				offset { box 0,-1,-1,0,1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 8,10 }
				angle { box 0,0,-0.5,0,0,0.5 }
				length { box 10,0,0,20,0,0 }
			}
		}
	}
	spawner "leakage4"
	{
		count		10,10
		locked

		line
		{
			duration	0.25,0.5
			generatedLine
			material	"gfx/effects/fluids_drips/stroy_spit_alpha"
			generatedOriginNormal

			start
			{
				position { line 0.95,-1,-1,0.95,1,1 }
				velocity { box 10,-10,-10,10,10,10 }
				angle { box 0,0,-1,0,0,1 }
				size { box 5,8 }
				tint { line 1,1,1,0.901961,0.882353,0.6 }
				fade { line 0.75,1 }
				offset { box 0,-1,-1,0,1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 8,10 }
				angle { box 0,0,-0.5,0,0,0.5 }
				length { box 10,0,0,20,0,0 }
			}
		}
	}
}
