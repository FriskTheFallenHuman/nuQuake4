effect effects/monsters/harvester/claw_step
{
	size	118

	spawner "ground_sprite"
	{
		count		3,3

		oriented
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"
			generatedNormal

			start
			{
				position { point 0,0,1 }
				velocity { box 0,0,0,10,0,0 }
				size { point 5,5 }
				tint { line 0.74902,0.74902,0.74902,0.501961,0.501961,0.501961 }
				fade { point 0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { line 40,40,50,50 }
				fade { point 1 }
			}
		}
	}
	spawner "dust_grey"
	{
		count		8,8

		sprite
		{
			duration	0.5,1.5
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0.05,0.05
			generatedNormal

			start
			{
				position { line 0,0,5,0,0,10 }
				velocity { box 30,-10,-10,80,10,10 }
				friction { box -10,0,0,-30,0,0 }
				size { point 10,10 }
				tint { line 0.423529,0.423529,0.423529,0.74902,0.74902,0.74902 }
				fade { point 0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 30,30 }
				fade { line 0.5,1 }
			}
		}
	}
	spawner "dust_grey_impact"
	{
		count		1,1

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.05,0.05
			generatedNormal

			start
			{
				position { line 0,0,5,0,0,10 }
				velocity { box 10,-20,-20,20,20,20 }
				friction { box -100,0,0,-50,0,0 }
				size { point 30,30 }
				tint { line 0.752941,0.752941,0.752941,0.635294,0.501961,0.34902 }
				fade { point 0 }
				rotate { box 0.32,0.1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_fade }
				rotate { envelope linear }
			}

			end
			{
				size { point 75,75 }
				fade { point 1 }
			}
		}
	}
	spawner "ring_mark"
	{
		count		1,1

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/railgun_ring"
			generatedNormal

			start
			{
				position { point 0,0,0.1 }
				tint { point 1,0.980392,0.72549 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"harvester_steps"
	}
}
