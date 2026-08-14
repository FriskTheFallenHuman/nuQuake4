effect effects/monsters/strogg_flyer/vertical_sm
{
	size	230

	emitter "smoke"
	{
		duration	1,1
		count		5,10
		locked

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 0.2,-0.1,-0.1,0.2,0.1,0.1 }
				velocity { box 200,-10,-10,300,10,10 }
				size { point 45,45 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
				tint { point 0.521569,0.47451,0.301961 }
				fade { line 0.25,0.5 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"convoy_large_ship_loop2"
	}
	sound "unnamed5"
	{
		soundShader	"convoy_jetfire1"
	}
	emitter "unnamed6"
	{
		duration	1,1
		count		1,1
		locked

		oriented
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { point 1,0,0 }
				size { point 20,20 }
				tint { line 1,1,0.501961,1,0.501961,0.25098 }
				fade { point 0.25 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				rotate { envelope linear }
			}
		}
	}
	emitter "unnamed7"
	{
		duration	1,1
		count		1,80
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3"

			start
			{
				position { point 1,0,0 }
				velocity { box 50,0,0,200,0,0 }
				size { point 10,10 }
				tint { line 1,1,0.501961,1,0.501961,0.25098 }
				fade { point 0.5 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
}


