effect effects/monsters/grunt/poundground
{
	size	281

	shake "camerashake"
	{
		duration	1,1
		scale		1.1
		attenuateEmitter
		attenuation	500,1000
	}
	spawner "steam1"
	{
		count		5,5

		sprite
		{
			duration	0.5,1
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.25,-0.125
			generatedOriginNormal

			start
			{
				position { cylinder 5,-1,-1,5,1,1 }
				velocity { box -150,0,-150,150,0,150 }
				size { line 5,5,10,10 }
				tint { line 0.862745,0.886275,0.839216,0.443137,0.552941,0.403922 }
				fade { point 0 }
				offset { point 20,0,-15 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 50,50,70,70 }
				fade { point 0.4 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "motion"
	{
		detail		0.5
		count		1,1

		oriented
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				position { point 1,0,0 }
				size { point 40,40 }
				tint { point 0.47451,0.580392,0.454902 }
				fade { point 0.25 }
				offset { point 25,0,-20 }
				rotate { point 0,0.25,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 150,150 }
				tint { point 0,0.247059,0 }
			}
		}
	}
	spawner "motion2"
	{
		detail		0.5
		start		0.1,0.1
		count		1,1

		oriented
		{
			duration	0.25,0.75
			blend	add
			material	"gfx/effects/particles_shapes/shockwave"

			start
			{
				position { point 1,0,0 }
				size { point 0,0 }
				tint { point 0.345098,0.513726,0.321569 }
				fade { point 0.5 }
				offset { point 25,0,-20 }
				rotate { point 0,0.25,0 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 175,175 }
				tint { point 0,0.247059,0 }
			}
		}
	}
}






