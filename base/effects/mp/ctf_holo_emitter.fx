effect effects/mp/ctf_holo_emitter
{
	size	40

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
				tint { line 1,1,1,1,1,0.501961 }
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
				size { box 12,15 }
				length { box 15,0,0,25,0,0 }
			}
		}
	}
	emitter "rings1"
	{
		duration	1,1
		count		15,15

		oriented
		{
			duration	0.2,0.5
			blend	add
			material	"gfx/effects/energy_sparks/ctf_grey_ring"

			start
			{
				position { point 1,0,0 }
				velocity { point 40,0,0 }
				size { box 5,5,8,8 attenuate }
				tint { line 1,1,1,1,1,0.501961 }
				fade { point 0.35 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 10,10,20,20 attenuate }
			}
		}
	}
	emitter "unnamed3"
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
				size { point 3,3 }
				tint { line 1,1,1,0.988235,1,0.835294 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 6,6 }
			}
		}
	}
}

