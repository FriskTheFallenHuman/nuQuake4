effect effects/mp/item_holo
{
	size	155

	emitter "thelight"
	{
		duration	1,1
		count		4,4

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/ctf_grey_light"

			start
			{
				size { box 1,2 }
				tint { line 1,1,1,0.603922,0.580392,0.921569 }
				fade { point 0.5 }
				length { point 5,0,0 }
			}

			motion
			{
				size { envelope "exp_x2" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 20,30 }
				length { box 80,0,0,100,0,0 }
			}
		}
	}
	emitter "rings1"
	{
		duration	0.25,1
		count		5,5

		oriented
		{
			duration	1,2
			blend	add
			material	"gfx/effects/energy_sparks/ctf_grey_ring"

			start
			{
				position { point 1,0,0 }
				velocity { point 40,0,0 }
				size { line 5,5,8,8 attenuate }
				tint { line 1,1,1,0.603922,0.576471,0.921569 }
				fade { line 0.5,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 40,40,60,60 attenuate }
			}
		}
	}
	emitter "base"
	{
		duration	0.5,0.5
		count		5,5

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_base3"

			start
			{
				position { point 1,0,0 }
				size { point 5,5 }
				tint { line 1,1,1,0.603922,0.580392,0.921569 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fadeouttable" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	emitter "thelight2"
	{
		duration	1,1
		count		4,4

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/ctf_grey_light"

			start
			{
				size { box 1,2 }
				tint { line 1,1,1,0.603922,0.580392,0.921569 }
				fade { point 0.5 }
				length { point 5,0,0 }
			}

			motion
			{
				size { envelope "exp_x2" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 5 }
				length { box 80,0,0,150,0,0 }
			}
		}
	}
}


