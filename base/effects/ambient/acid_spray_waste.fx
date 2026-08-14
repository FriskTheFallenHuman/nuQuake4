effect effects/ambient/acid_spray_waste
{
	size	1039

	emitter "steamcore"
	{
		duration	1,1
		count		10,10

		line
		{
			duration	0.25,0.25
			persist
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				size { point 50 }
				tint { line 0.411765,0.478431,0.0196078,0.572549,0.556863,0.486275 }
				fade { point 0.25 }
				length { box 500,375,400,500,450,500 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 200 }
				length { box 300,200,200,300,300,300 }
			}
		}
	}
	emitter "end"
	{
		duration	1,1
		count		1,2

		sprite
		{
			duration	0.7,1
			persist
			material	"gfx/effects/smoke/steam_alpha_depth"
			gravity		-0.01,0.01
			generatedOriginNormal

			start
			{
				position { line 25,0,0,45,0,0 }
				velocity { box 300,-30,-30,500,30,30 }
				size { box 70,70,90,90 }
				tint { point 0.607843,0.635294,0.168627 }
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
		duration	1,1
		count		4,4
		locked

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/steam_alpha_depth"

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 0,-8,-8,20,8,8 }
				size { box 4,4,15,15 }
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
				size { box 30,30,50,50 }
				fade { point 0.4 }
			}
		}
	}
	emitter "steam"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,1.7
			persist
			material	"gfx/effects/smoke/steam_alpha_depth"
			gravity		0.02,0.06

			start
			{
				position { line 10,-1,-1,10,1,1 }
				velocity { box 50,-10,-10,200,10,10 }
				size { point 10,10 }
				tint { line 0.552941,0.545098,0.447059,0.517647,0.505882,0.258824 }
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
				fade { point 0.2 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"effects_waste_acid_spray"
		freqshift	0.6,0.6
	}
	emitter "physics"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_source"

			start
			{
				velocity { point 500,0,0 }
				size { point 2,2 }
				fade { point 0 }
			}

			impact
			{
				remove	1
				effect	"effects/ambient/acid_react_waste"
			}
		}
	}
}





