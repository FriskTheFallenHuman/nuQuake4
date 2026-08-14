effect effects/test/mvainio/tempjumppad
{
	size	182

	emitter "unnamed0"
	{
		duration	1,1
		count		20,20

		oriented
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/test/corona2"

			start
			{
				position { point 1,0,0 }
				velocity { point 100,0,0 }
				size { line 60,60,80,80 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { line 40,40,60,60 }
			}
		}
	}
	emitter "spirals"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.16,0
			trailType	burn
			trailTime	0.5,0.5
			trailCount	25,25

			start
			{
				position { line 20,-10,0,20,10,0 }
				velocity { box 100,-5,-5,100,5,5 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,9,9 }
				fade { point 0 }
				offset { box 0,-50,-50,0,50,50 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope linear }
				fade { envelope fastinslowout }
				angle { envelope linear }
			}

			end
			{
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
			}
		}
	}
	emitter "smoke"
	{
		duration	1,1
		count		5,5
		locked

		oriented
		{
			duration	2,2
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.05,-0.05
			generatedNormal

			start
			{
				position { cylinder 0,-30,-30,0,30,30 surface }
				size { point 40,40 }
				tint { point 1,0.992157,0.835294 }
				fade { point 0 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope convexfade }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 60,60 }
				fade { point 0.3 }
				rotate { box 0,0,-0.694444,0,0,0.694444 relative }
			}
		}
	}
}
