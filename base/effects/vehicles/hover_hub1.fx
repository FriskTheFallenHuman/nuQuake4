effect effects/vehicles/hover_hub1
{
	size	415

	emitter "dust_back"
	{
		duration	1,1
		count		10,10
		attenuateEmitter

		sprite
		{
			duration	2,3
			persist
			material	"gfx/effects/smoke/smoke_alpha_depth"
			gravity		-0.03,-0.02
			generatedNormal

			start
			{
				position { cylinder 0,-1,-1,0,1,1 surface }
				velocity { box 50,0,0,100,0,0 }
				size { box 75,75,125,125 }
				tint { point 0.4,0.54902,0.839216 }
				fade { point 0 }
				rotate { box -0.5,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { box 150,150,200,200 }
				fade { line 0.25,0.5 }
				rotate { box -1,-0.5 relative }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		200,200
		locked
		attenuateEmitter

		line
		{
			duration	0.25,0.25
			persist
			material	"gfx/effects/smoke/smoke_alpha_depth"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-0.1,-0.1,0,0.1,0.1 surface }
				velocity { box 150,0,0,200,0,0 }
				size { box 1,2 }
				tint { point 0.4,0.54902,0.839216 }
				fade { point 0.25 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 4,8 }
				length { box 50,0,0,90,0,0 }
			}
		}
	}
}

