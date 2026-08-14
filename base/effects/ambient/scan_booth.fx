effect effects/ambient/scan_booth
{
	size	336

	emitter "unnamed0"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				position { point 1,0,0 }
				size { point 50,50 }
				rotate { point 0,0,-0.125 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 150,150 }
			}
		}
	}
	emitter "residualline2"
	{
		duration	1,1
		count		10,10

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				position { point -2,0,0 }
				size { point 15 }
				tint { point 1,0,0 }
				fade { point 0.2 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 6 }
			}
		}
	}
	emitter "residualline3"
	{
		duration	1,1
		count		10,10

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				position { point -2,0,0 }
				size { point 15 }
				tint { point 1,0,0 }
				fade { point 0.2 }
				length { line 0,0,0,0,0,0 useEndOrigin }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 6 }
			}
		}
	}
	emitter "unnamed1"
	{
		start		1,1
		duration	1,1
		count		3,3

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/add_line"

			start
			{
				position { point 1,0,0 }
				size { point 100,200 }
				rotate { point 0,0,-0.125 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 150,300 }
				rotate { point 0.25,0,-0.125 }
			}
		}
	}
}
