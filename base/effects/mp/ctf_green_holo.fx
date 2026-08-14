effect effects/mp/ctf_green_holo
{
	size	346

	emitter "thelight"
	{
		duration	1,1
		count		4,4

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/ctf_flag_light_marine"

			start
			{
				size { box 1,2 }
				tint { line 1,1,1,0,1,0 }
				fade { point 0.5 }
				length { point 5,0,0 }
			}

			motion
			{
				size { envelope exp_x2 }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 20,30 }
				length { box 100,0,0,200,0,0 }
			}
		}
	}
	emitter "rings1"
	{
		duration	1,1
		count		5,5

		oriented
		{
			duration	2,10
			blend	add
			material	"gfx/effects/energy_sparks/ctf_flag_ring_marine"

			start
			{
				position { point 1,0,0 }
				velocity { point 40,0,0 }
				size { box 5,5,8,8 attenuate }
				tint { line 1,1,1,1,1,0.501961 }
				fade { line 0.5,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear rate 1 }
			}

			end
			{
				size { line 100,100,120,120 attenuate }
				tint { point 0,1,0 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	0.5,0.5
		count		10,10

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base3_marine"

			start
			{
				position { point 1,0,0 }
				size { point 5,5 }
				tint { line 1,1,1,0,1,0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	emitter "spirals"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	0.5,1.5
			blend	add
			material	"gfx/effects/energy_sparks/spark3_marine"
			gravity		-0.16,0
			trailType	burn
			trailTime	0.5,0.5
			trailCount	25,25

			start
			{
				position { point 1,0,0 }
				velocity { box 100,-20,-20,100,20,20 }
				angle { box 0,0,0,1,1,1 }
				size { line 1,1,3,3 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope fastinslowout }
				offset { envelope linear }
				angle { envelope linear }
			}

			end
			{
				fade { point 0.5 }
				offset { box 0,-30,-30,0,30,30 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
}




