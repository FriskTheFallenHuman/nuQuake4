effect effects/ambient/lightbeam_nodust_64
{
	size	251

	spawner "beam_inner"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/lightbeam"
			generatedOriginNormal

			start
			{
				position { point 1,0,0 }
				size { box 10,30 }
				tint { line 0.94902,0.929412,0.87451,1,1,1 }
				fade { line 0.04,0.08 }
				length { box 150,0,0,200,0,0 }
			}

			motion
			{
				size { envelope randomflick }
				fade { envelope randomflick }
			}

			end
			{
				size { box 15,25 }
				fade { line 0.05,0.07 }
			}
		}
	}
	spawner "beam"
	{
		count		6,6
		locked
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/lightbeam"
			generatedOriginNormal

			start
			{
				position { cylinder 1,-0.25,-0.25,1,0.25,0.25 }
				size { box 30,50 }
				tint { line 0.94902,0.929412,0.87451,1,1,1 }
				fade { line 0.03,0.07 }
				length { box 150,0,0,200,0,0 }
			}

			motion
			{
				size { envelope randomflick }
				fade { envelope randomflick }
			}

			end
			{
				size { box 35,45 }
				fade { line 0.04,0.06 }
			}
		}
	}
}

