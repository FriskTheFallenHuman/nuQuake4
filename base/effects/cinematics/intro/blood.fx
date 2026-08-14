effect effects/cinematics/intro/blood
{
	size	38

	emitter "unnamed0"
	{
		duration	20,20
		count		1,1
		locked

		sprite
		{
			duration	28,28
			material	"gfx/effects/gore_spray/bloodhit4"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-5,-5,0,5,5 }
				velocity { box 0,-1,-1,0,1,1 }
				size { line 5,5,12,12 }
				tint { line 0.501961,0,0,0.0941177,0.109804,0.14902 }
				fade { line 0.75,0.25 }
				rotate { box -0.0833333,0.0833333 }
			}

			motion
			{
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}
		}
	}
}


