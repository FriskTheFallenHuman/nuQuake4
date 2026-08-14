effect effects/cinematics/intro/bits
{
	size	613

	spawner "unnamed0"
	{
		count		30,30
		constant

		sprite
		{
			duration	30,30
			material	"gfx/effects/particles_shapes/dirt2"
			generatedOriginNormal

			start
			{
				position { cylinder -100,0,-100,100,0,100 }
				size { line 20,20,100,100 }
				tint { line 0.439216,0.501961,0.556863,0.356863,0.384314,0.301961 }
				fade { line 0.1,0.25 }
				offset { point -400,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				rotate { envelope "linear" }
			}
		}
	}
}






