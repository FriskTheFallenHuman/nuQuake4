effect effects/monsters/harvester/claw_dirt
{
	size	566

	sound "sound"
	{
		soundShader	"harvester_claw_dirt"
		volume	4,4
	}
	decal "mark"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/nailgun_mark"

			start
			{
				size { point 50,50 }
				rotate { point 0.180556 }
			}
		}
	}
	spawner "ground_sprite"
	{
		count		3,3

		oriented
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { point 1,0,0 }
				velocity { box 0,0,0,100,0,0 }
				size { point 10,10 }
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
				size { line 100,100,300,300 }
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

			start
			{
				position { line 5,0,0,10,0,0 }
				velocity { box 75,-80,-80,225,80,80 }
				friction { box -100,0,0,-50,0,0 }
				size { point 30,30 }
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
				size { point 150,150 }
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

			start
			{
				position { line 5,0,0,10,0,0 }
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

			start
			{
				position { point 0.1,0,0 }
				tint { point 1,0.980392,0.72549 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 400,400 }
			}
		}
	}
	spawner "unnamed7"
	{
		count		3,3

		debris
		{
			duration	1,1
			entityDef	"debris_chunk"

			start
			{
				velocity { box 300,-300,-300,500,300,300 }
			}
		}
	}
	spawner "unnamed8"
	{
		count		3,3

		debris
		{
			duration	1,1
			entityDef	"debris_chunk_sm"

			start
			{
				velocity { box 500,-150,-150,700,150,150 }
				rotate { box -1,-1,-1,1,1,1 }
			}
		}
	}
	spawner "unnamed9"
	{
		count		5,5

		debris
		{
			duration	1,1
			entityDef	"debris_chunk_sm2"

			start
			{
				velocity { box 500,-150,-150,700,150,150 }
				rotate { box -1,-1,-1,1,1,1 }
			}
		}
	}
}



