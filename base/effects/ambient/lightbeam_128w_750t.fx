effect effects/ambient/lightbeam_128w_750t
{
	size	1681

	spawner "beam_inner"
	{
		count		1,1
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/lightbeam"
			generatedOriginNormal

			start
			{
				position { point 1,0,0 }
				size { box 120,140 }
				tint { line 0.94902,0.929412,0.87451,1,1,1 }
				fade { line 0.1,0.2 }
				length { box 1000,0,0,1200,0,0 }
			}

			motion
			{
				size { envelope randomflick }
				fade { envelope randomflick }
			}

			end
			{
				size { box 120,135 }
				fade { line 0.13,0.15 }
			}
		}
	}
	spawner "beam"
	{
		count		4,4
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/lightbeam"
			generatedOriginNormal

			start
			{
				position { cylinder 1,-0.25,-0.25,1,0.25,0.25 }
				size { box 140,180 }
				tint { line 0.94902,0.929412,0.87451,1,1,1 }
				fade { line 0.08,0.16 }
				length { box 1200,0,0,1500,0,0 }
			}

			motion
			{
				size { envelope randomflick }
				fade { envelope randomflick }
			}

			end
			{
				size { box 155,165 }
				fade { line 0.12,0.14 }
			}
		}
	}
	emitter "dust"
	{
		duration	30,30
		count		100,100

		sprite
		{
			duration	1,3
			material	"gfx/effects/particles_shapes/dust"
			gravity		-0.005,0

			start
			{
				position { cylinder 0,-80,-80,1000,80,80 }
				velocity { box 0,-0.2,-0.2,1,0.2,0.2 }
				angle { box 0,0,0,1,1,1 }
				size { line 0.2,0.2,1,1 }
				tint { line 1,0.972549,0.72549,0.866667,0.772549,0.643137 }
				fade { point 0 }
				offset { box 0,-1,-1,0,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				fade { point 0.5 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
			}
		}
	}
	spawner "sphere1"
	{
		count		1,1
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/add_sphere_alpha"

			start
			{
				position { point 10,0,0 }
				size { point 150,150 }
				tint { point 0.976471,0.921569,0.823529 }
				fade { point 0.24 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "sphere2"
	{
		count		1,1
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/add_sphere_alpha"

			start
			{
				position { point 50,0,0 }
				size { point 140,140 }
				tint { point 0.976471,0.921569,0.823529 }
				fade { point 0.12 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "sphere3"
	{
		count		1,1
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/add_sphere_alpha"

			start
			{
				position { point 80,0,0 }
				size { point 120,120 }
				tint { point 0.976471,0.921569,0.823529 }
				fade { point 0.08 }
				rotate { box 0,1 }
			}
		}
	}
}

