effect effects/monsters/turret/d_impact_drop
{
	size	1145

	sound "sound"
	{
		soundShader	"turret_convoy_land"
	}
	spawner "dirt_up"
	{
		start		0.2,0.2
		count		5,5

		sprite
		{
			duration	1,1.5
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		0.5,0.75

			start
			{
				position { cylinder 0,-0.5,-0.5,200,0.5,0.5 }
				velocity { box 100,-100,-100,700,100,100 }
				size { line 80,80,100,100 }
				tint { point 0.305882,0.290196,0.254902 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "pop_hold_fadefast" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 300,300,400,400 }
				tint { point 0.188235,0.180392,0.160784 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "dust_ring"
	{
		count		10,10

		sprite
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/debris_cloud"
			gravity		-0.1,-0.1
			generatedNormal

			start
			{
				position { cylinder 1,-50,-50,1,50,50 }
				velocity { box 300,0,0,350,0,0 }
				size { point 80,80 }
				tint { line 0.192157,0.188235,0.168627,0.227451,0.219608,0.196078 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
			}

			end
			{
				size { point 250,250 }
				fade { point 1 }
			}
		}
	}
}






