effect effects/monsters/harvester/rocket_mflash
{
	size	1367

	sound "unnamed5"
	{
		soundShader	"harvester_rocket_launcher"
	}
	emitter "smokering"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	2,4
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			generatedNormal

			start
			{
				position { cylinder 30,-0.5,-0.5,30,0.5,0.5 }
				velocity { point 250,0,0 }
				angle { box 0,0,-1,0,0,1 }
				acceleration { box -150,0,0,100,0,0 }
				size { point 50,50 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				offset { box 0,-30,-30,0,30,30 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 400,400 }
				tint { point 0.521569,0.47451,0.301961 }
				fade { point 0.5 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "smoke2"
	{
		start		0.25,0.25
		duration	1,1
		count		10,10

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 100,-25,-25,200,25,25 }
				velocity { box -200,0,0,-400,0,0 }
				size { point 45,45 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 400,400 }
				tint { point 0.521569,0.47451,0.301961 }
				fade { point 0.8 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "smoke3"
	{
		start		0.5,0.5
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 200,-15,-15,300,15,15 }
				velocity { box -200,0,0,-400,0,0 }
				size { point 45,45 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 400,400 }
				tint { point 0.521569,0.47451,0.301961 }
				fade { point 0.8 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "smoke4"
	{
		start		1,1
		duration	1,1
		count		4,4

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				position { cylinder 300,-5,-5,400,5,5 }
				velocity { box -200,0,0,-400,0,0 }
				size { point 45,45 }
				tint { line 0.721569,0.803922,0.803922,0.294118,0.419608,0.419608 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 400,400 }
				tint { point 0.521569,0.47451,0.301961 }
				fade { point 0.8 }
				rotate { box -0.333333,0.333333 relative }
			}
		}
	}
	emitter "side_streaks3"
	{
		duration	1,1
		count		10,10
		locked

		line
		{
			duration	0.3,0.3
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			generatedOriginNormal

			start
			{
				position { cylinder 0.05,-0.2,-0.2,0.05,0.2,0.2 surface }
				size { box 35,50 }
				fade { point 0 }
				offset { point -3,0,0 }
				length { box 40,0,0,80,0,0 }
			}

			motion
			{
				fade { envelope "fast_in_slow_out" }
				length { envelope "linear" }
			}

			end
			{
				fade { point 0.75 }
				length { box 200,0,0,500,0,0 }
			}
		}
	}
}



