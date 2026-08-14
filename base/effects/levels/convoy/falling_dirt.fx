effect effects/levels/convoy/falling_dirt
{
	size	950

	sound "sound"
	{
		soundShader	"effects_debris"
	}
	emitter "trails"
	{
		start		0.5,0.5
		duration	0.5,0.5
		count		20,40

		line
		{
			duration	3,4
			material	"gfx/effects/particles_shapes/duststreak_alpha"

			start
			{
				position { line 0,-200,-200,0,200,200 }
				size { box 3,8 }
				tint { line 0.4,0.286275,0.239216,0.368627,0.376471,0.258824 }
				fade { point 0.4 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { point 800,0,0 }
			}
		}
	}
	emitter "particles"
	{
		start		0.5,0.5
		duration	2,2
		count		40,80

		sprite
		{
			duration	6,10
			material	"gfx/effects/smoke/smoke_alpha"
			gravity		0.06,0.06

			start
			{
				position { cylinder 0,-200,-200,0,200,200 }
				velocity { point 20,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 2,2,4,4 }
				tint { point 0.854902,0.803922,0.654902 }
				fade { point 0.6 }
				offset { box 0,-50,-50,0,50,50 }
			}

			motion
			{
				angle { envelope linear }
			}

			end
			{
				angle { box 0.111111,0.111111,0.111111,0.222222,0.222222,0.222222 relative }
			}
		}
	}
	emitter "particles_big"
	{
		duration	2,2
		count		10,10

		sprite
		{
			duration	6,10
			material	"gfx/effects/smoke/cloud_alpha_depth"
			gravity		0.04,0.04

			start
			{
				position { cylinder 0,-200,-200,0,200,200 }
				velocity { point 15,0,0 }
				size { point 100,100 }
				tint { line 0.180392,0.184314,0.12549,0.247059,0.176471,0.145098 }
				fade { point 0 }
				rotate { box 0,0.333333 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { point 200,200 }
				fade { point 0.35 }
				rotate { box 0.333333,0.666667 relative }
			}
		}
	}
}




