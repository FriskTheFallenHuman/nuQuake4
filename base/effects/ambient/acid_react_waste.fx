effect effects/ambient/acid_react_waste
{
	size	449

	emitter "bubbles2"
	{
		duration	1,1
		count		50,50

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fluids_drips/bubble_additive"

			start
			{
				position { sphere 1,-80,-80,1,80,80 }
				size { point 5,5 }
				tint { line 0.25098,0,0,0.501961,0.501961,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 10,10,30,30 }
			}
		}
	}
	emitter "bubbles3"
	{
		duration	1,1
		count		50,50

		oriented
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/bubble_green"

			start
			{
				position { sphere 1,-80,-80,1,80,80 }
				size { point 0,0 }
				tint { line 0.501961,0,0,0.501961,0.501961,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 10,10,20,20 }
			}
		}
	}
	emitter "end"
	{
		start		0.3,0.3
		duration	1,1
		count		2,2

		sprite
		{
			duration	1,1.25
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.01,0.01
			generatedOriginNormal

			start
			{
				position { line 25,0,0,45,0,0 }
				velocity { box 0,-15,-15,0,15,15 }
				size { box 70,70,90,90 }
				tint { line 0.603922,0.631373,0.164706,0.286275,0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 250,250,300,300 }
				fade { point 0.2 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "start"
	{
		start		0.1,0.3
		duration	1,1
		count		8,8
		locked

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { box 5,-80,-80,10,80,80 }
				velocity { box 0,-3,-3,20,3,3 }
				size { box 2,2,4,4 }
				tint { line 0.756863,0.74902,0.701961,0.682353,0.74902,0.631373 }
				fade { point 0 }
				rotate { box -0.125,-0.25 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 35,35,50,50 }
				fade { line 0.1,0.3 }
			}
		}
	}
	emitter "steam"
	{
		start		0.3,0.3
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/steam_alpha"
			gravity		-0.06,-0.02

			start
			{
				position { box 10,-30,-30,15,30,30 }
				velocity { box 0,-60,-60,0,60,60 }
				size { box 2,2,10,10 }
				tint { line 0.803922,0.8,0.756863,0.803922,0.796079,0.611765 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 70,70,90,90 }
				fade { line 0.2,0.3 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	sound "unnamed3"
	{
		start		0.3,0.3
		soundShader	"effects_acid_burn"
	}
}





