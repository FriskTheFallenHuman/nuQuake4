effect effects/ambient/lightbeam_dropship
{
	size	551

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
				fade { point 0.65 }
				length { box 400,0,0,500,0,0 }
			}

			motion
			{
				size { envelope randomflick }
				fade { envelope randomflick count 0.25 }
			}

			end
			{
				size { box 15,25 }
				fade { point 0.5 }
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
				fade { point 0.25 }
				length { box 400,0,0,500,0,0 }
			}

			motion
			{
				size { envelope randomflick }
				fade { envelope randomflick count 0.25 }
			}

			end
			{
				size { box 35,45 }
				fade { point 0.1 }
			}
		}
	}
}
