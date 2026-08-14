effect effects/cinematics/intro/nebula
{
	size	3476

	spawner "oriented fog"
	{
		count		15,15
		constant

		oriented
		{
			duration	20,20
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0,-1000,-4000,0,1000,4000 }
				size { line 1000,1000,800,800 }
				tint { line 0.34902,0.34902,1,0.658824,0.34902,1 }
				fade { point 0.09 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0,0,-0.111111,0,0,0.111111 relative }
			}
		}
	}
	spawner "oriented fog2"
	{
		count		30,30
		constant

		oriented
		{
			duration	20,20
			blend	add
			material	"gfx/effects/fire/fire2a_blue"

			start
			{
				position { cylinder 0,-1000,-4000,0,1000,4000 }
				size { line 1000,1000,800,800 }
				tint { line 0.34902,0.34902,1,0.658824,0.34902,1 }
				fade { line 0.09,0.25 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0,0,-0.111111,0,0,0.111111 relative }
			}
		}
	}
}


