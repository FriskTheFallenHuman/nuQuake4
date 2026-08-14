effect effects/ambient/dust_falling_large
{
	size	1117

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
				position { cylinder -100,-100,-100,100,100,100 }
				size { box 10,30 }
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
				length { point 1000,0,0 }
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
			gravity		0.01,0.01

			start
			{
				position { cylinder 0,-100,-100,0,100,100 }
				velocity { box -2,-2,-20,2,2,0 }
				size { line 50,50,100,100 }
				tint { line 0.992157,0.854902,0.6,0.866667,0.984314,0.603922 }
			}

			motion
			{
				fade { envelope linear }
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
			gravity		0.01,0.01

			start
			{
				position { cylinder 0,-100,-100,0,100,100 }
				velocity { box 0,0,-15,0,0,0 }
				size { point 50,50 }
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
				size { point 500,500 }
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"effects_debris_heavy"
	}
	sound "unnamed4"
	{
		soundShader	"effects_debris"
		volume	0.6,0.6
	}
}

