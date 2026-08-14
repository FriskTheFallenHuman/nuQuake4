effect effects/cinematics/intro/ship_thruster
{
	size	55

	emitter "line"
	{
		duration	90,90
		count		5,5
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/weapons/blaster_flyflipped"

			start
			{
				tint { line 0.4,0.54902,0.839216,0,0,0.501961 }
				offset { box -3,-2.5,0,-4,-2.5,0 }
				length { point 8,0,0 }
			}

			motion
			{
				size { envelope random }
				length { envelope random }
			}

			end
			{
				size { point 0.5 }
				length { point 5,0,0 }
			}
		}
	}
	light "unnamed2"
	{
		locked

		light
		{
			duration	60,60
			material	"lights/defaultPointLight"

			start
			{
				position { point 5,-5,0 }
				size { point 30,30,30 }
				tint { point 0.443137,0.721569,1 }
			}

			motion
			{
				size { envelope firetable count 100,100,100 }
			}

			end
			{
				size { point 5,5,5 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	90,90
		count		10,10

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"

			start
			{
				position { cylinder 0,-2,-2,0,2,10 }
				velocity { box 5,-2,-2,10,2,2 }
				angle { box -0.5,-0.5,-0.5,0.5,0.5,0.5 }
				size { point 5,5 }
				tint { line 1,1,1,0.4,0.54902,0.839216 }
				fade { point 0.1 }
				offset { box 0,-2,-2,0,2,2 }
				rotate { box -0.166667,0.166667 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine offset 0.5 }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 15,15,20,20 }
			}
		}
	}
}






