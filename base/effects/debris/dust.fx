effect effects/debris/dust
{
	size	181

	spawner "trails"
	{
		start		0.5,0.5
		count		2,4

		line
		{
			duration	5,7
			material	"gfx/effects/particles_shapes/duststreak_alpha"

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				size { box 1,3 }
				tint { line 0.4,0.34902,0.243137,0.384314,0.407843,0.235294 }
				fade { point 0.4 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { point 100,0,0 }
			}
		}
	}
	spawner "particles"
	{
		start		0.5,0.5
		count		8,14

		sprite
		{
			duration	6,10
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.001,0.001

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 0,-2,-2,20,2,2 }
				size { line 0.5,0.5,1,1 }
				tint { line 0.992157,0.854902,0.6,0.870588,0.988235,0.603922 }
			}
		}
	}
	spawner "particles_big"
	{
		count		8,10

		sprite
		{
			duration	6,10
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.001,0.001

			start
			{
				position { cylinder 0,-10,-10,0,10,10 }
				velocity { box 0,0,0,25,0,0 }
				size { point 10,10 }
				tint { line 0.886275,0.839216,0.682353,0.772549,0.792157,0.717647 }
				fade { point 0.6 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
}


