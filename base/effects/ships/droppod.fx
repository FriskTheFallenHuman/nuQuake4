effect effects/ships/droppod
{
	size	150

	emitter "jet"
	{
		duration	1,1
		count		50,50
		locked

		line
		{
			duration	1,1
			persist
			material	"gfx/effects/ships/droppod"

			start
			{
				size { point 50 }
				tint { point 0.501961,0.501961,0.501961 }
				length { point 100,0,0 }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
		count		50,50
		attenuateEmitter

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 15,15,18,18 attenuate }
				tint { line 0.933333,0.933333,0.909804,0.721569,0.701961,0.611765 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 30,30,35,35 attenuate }
				rotate { box -0.25,0.25 relative }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"convoy_missile_flight"
	}
}



