effect effects/fire/tram_smolder
{
	size	148

	emitter "trail"
	{
		duration	1,1
		count		80,80

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha_depth"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 2,2,5,5 }
				tint { line 0.309804,0.258824,0.2,0.286275,0.27451,0.239216 }
				fade { point 0.5 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 90,90,100,100 }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		2,2
		attenuateEmitter

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire1a"

			start
			{
				position { cylinder 10,-15,-15,10,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 20,20,25,25 attenuate }
				fade { point 0 attenuate }
				offset { box -1,-1,-1,1,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 10,10,20,20 attenuate }
				fade { point 1 attenuate }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,-0.333333 relative }
			}
		}
	}
	emitter "fire4"
	{
		duration	1,1
		count		2,2
		attenuateEmitter

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire4a"

			start
			{
				position { cylinder 20,-15,-15,20,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 25,25,30,30 attenuate }
				fade { point 0 attenuate }
				offset { box -1,-1,-1,1,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 15,15,25,25 attenuate }
				fade { point 1 attenuate }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box 0.333333,0.444444 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	1,1
		count		3,3
		attenuateEmitter

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire5a"

			start
			{
				position { cylinder 10,-15,-15,10,15,15 }
				angle { box 0,0,0,1,1,1 }
				size { box 20,20,25,25 attenuate }
				fade { point 0 attenuate }
				offset { box -1,-1,-1,1,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 10,10,20,20 attenuate }
				fade { point 1 attenuate }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,-0.222222 relative }
			}
		}
	}
	emitter "embers"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { cylinder 10,-2,-2,10,2,2 }
				angle { box 0,0,0,1,1,1 }
				size { point 3,3 }
				tint { line 1,1,1,0.941177,0.45098,0.243137 }
				offset { box 0,-3,-3,0,3,3 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
				angle { envelope "linear" }
			}

			end
			{
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
}



