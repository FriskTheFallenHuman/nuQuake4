effect effects/explosions/surface/impact_flyer
{
	size	3236

	shake "camerashake"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
	spawner "dirt"
	{
		count		3,3

		line
		{
			duration	2,2
			persist
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.5,0.5

			start
			{
				size { point 200 }
				tint { line 0.615686,0.541176,0.368627,0.501961,0.482353,0.423529 }
				fade { point 0 }
				length { box 600,0,0,800,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				length { box 400,0,0,500,0,0 }
			}
		}
	}
	spawner "debris"
	{
		start		0.1,0.1
		count		4,4

		sprite
		{
			duration	1.5,2.5
			persist
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		1,1

			start
			{
				position { line 0,0,0,200,0,0 }
				velocity { box 200,-50,-50,1000,50,50 }
				size { line 200,200,250,250 }
				tint { line 0.65098,0.607843,0.376471,0.466667,0.439216,0.329412 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 500,500,650,650 }
				tint { point 0.388235,0.329412,0.196078 }
				fade { point 1 }
			}
		}
	}
	spawner "column_smoke"
	{
		start		0.2,0.2
		count		3,3

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		1,1

			start
			{
				position { line 0,-30,0,250,30,0 linearSpacing }
				velocity { box 400,30,0,600,40,0 }
				size { box 80,80,100,100 }
				tint { point 0.596078,0.560784,0.454902 }
				fade { point 0 }
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
				size { box 340,340,360,360 }
				tint { point 0.392157,0.392157,0.32549 }
				fade { point 1 }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "residual_smoke"
	{
		start		0.6,0.6
		count		3,3

		sprite
		{
			duration	3,3
			persist
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { line -20,-30,-30,200,30,30 }
				velocity { box -5,20,-20,25,40,20 }
				size { line 180,180,240,240 }
				tint { line 0.294118,0.266667,0.172549,0.301961,0.258824,0.176471 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0.6 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "blank"
	{
		count		7,7

		sprite
		{
			duration	0.2,0.3
			persist
			material	"gfx/effects/particles_shapes/blank"
			gravity		5,5
			generatedOriginNormal
			trailType	blank_trail

			start
			{
				position { cylinder 0.1,-0.3,-0.3,0.1,0.3,0.3 }
				velocity { box 3000,0,0,4000,0,0 }
				size { point 20,20 }
			}
		}
	}
	trail "blank_trail"
	{
		count		30,30

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.2,0.2

			start
			{
				velocity { box -30,-30,-30,30,30,30 }
				size { box 80,80,120,120 }
				tint { line 0.596078,0.545098,0.427451,0.470588,0.4,0.227451 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "decalfade" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 200,200,300,300 }
				fade { point 0.7 }
				rotate { box -0.138889,0.138889 relative }
			}
		}
	}
	spawner "chunks"
	{
		count		5,7

		sprite
		{
			duration	2,3
			persist
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		1,1

			start
			{
				position { sphere -60,-60,-60,60,60,60 }
				velocity { box 800,-600,-600,1200,600,600 }
				size { line 12,12,20,20 }
				tint { line 0.470588,0.419608,0.329412,0.258824,0.243137,0.184314 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
	spawner "unnamed9"
	{
		count		10,10

		sprite
		{
			duration	0.5,0.5
			persist
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		-0.25,-0.05
			generatedNormal

			start
			{
				position { sphere 0,-20,-20,0,20,20 }
				velocity { box 300,0,0,400,0,0 }
				size { point 2,2 }
				tint { point 0.396078,0.341176,0.227451 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 200,200,500,500 }
			}
		}
	}
}


