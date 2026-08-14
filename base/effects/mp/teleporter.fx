effect effects/mp/teleporter
{
	size	396

	emitter "large"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.35,0.35
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				size { line 230,230,280,280 }
				tint { point 0.721569,0.847059,0.792157 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	emitter "circle"
	{
		duration	1,1
		count		15,15

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			generatedOriginNormal

			start
			{
				position { sphere -40,-40,-40,40,40,40 surface }
				velocity { point -30,0,0 }
				angle { box -1,-1,-1,1,1,1 }
				size { line 80,80,90,90 }
				tint { point 0.388235,0.827451,0.662745 }
				fade { point 0 }
				offset { box -10,-10,-10,10,10,10 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
			}

			end
			{
				size { line 20,20,30,30 }
				fade { point 0.3 }
			}
		}
	}
	emitter "sparks"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark_blue"
			trailType	motion
			trailTime	1,1
			trailCount	6,6
			trailMaterial	"gfx/effects/particles_shapes/motionblur"

			start
			{
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,9,9 }
				tint { line 0.788235,0.854902,0.815686,0.556863,1,0.509804 }
				fade { point 0 }
				offset { box -100,-100,-100,100,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "cosine" }
				offset { envelope "linear" }
				angle { envelope "linear" }
			}

			end
			{
				fade { point 0.4 }
				offset { box -1,-1,-1,1,1,1 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
}




