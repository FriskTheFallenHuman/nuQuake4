effect effects/sparks/barrel_scrape
{
	size	486

	sound "sound"
	{
		soundShader	"barrel_scrape"
	}
	emitter "sparks"
	{
		duration	1,1
		count		30,40
		locked

		sprite
		{
			duration	0.25,0.5
			material	"gfx/effects/weapons/flash"
			gravity		0.5,1

			start
			{
				velocity { box 25,-75,-75,200,75,75 }
				size { point 2,2 }
			}

			motion
			{
				size { envelope flickerblink }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
	emitter "streaks2"
	{
		duration	1,1
		count		40,50
		locked

		line
		{
			duration	0.06,0.06
			material	"gfx/effects/weapons/flash_half"
			gravity		0.1,0.1
			generatedOriginNormal

			start
			{
				position { cylinder 1,-0.5,-0.5,1,0.5,0.5 }
				velocity { point 50,0,0 }
				size { point 2 }
				tint { point 0,0,0 }
				length { box 2,2,2,2,-2,-2 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope pop_fade }
				length { envelope linear }
			}

			end
			{
				tint { point 1,1,1 }
				length { box 2,-25,-25,3,25,25 }
			}
		}
	}
	emitter "sparks_pyschics"
	{
		duration	1,1
		count		12,20
		locked

		sprite
		{
			duration	2,3
			material	"gfx/effects/weapons/flash"
			gravity		0.5,1

			start
			{
				position { point 1,0,0 }
				velocity { box 100,-150,-150,300,150,150 }
				size { point 2,2 }
			}

			motion
			{
				size { envelope flickerblink }
				tint { envelope linear }
			}

			end
			{
				size { point 0.5,0.5 }
			}

			impact
			{
				bounce	0.5
			}
		}
	}
	emitter "streaks"
	{
		duration	1,1
		count		20,30
		locked

		line
		{
			duration	0.01,0.06
			material	"gfx/effects/weapons/flash_half"
			gravity		0.1,0.1
			generatedNormal

			start
			{
				position { cylinder 1,-0.5,-0.5,1,0.5,0.5 }
				velocity { point 50,0,0 }
				tint { point 0,0,0 }
				length { box 1,5,5,1,-5,-5 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope pop_fade }
				length { envelope linear }
			}

			end
			{
				size { point 2 }
				tint { point 1,1,1 }
				length { box 1,-20,-20,1,20,20 }
			}
		}
	}
}


