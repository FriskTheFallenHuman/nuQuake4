effect effects/player/blood_cough2
{
	size	34

	spawner "unnamed0"
	{
		count		2,2

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/gore_spray/bloodhit4"

			start
			{
				velocity { point 0,-20,0 }
				size { point 0,0 }
				tint { point 0.501961,0,0 }
				offset { point 0,-5,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	spawner "blood_streaks"
	{
		count		4,6
		locked

		line
		{
			duration	0.15,0.25
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.25,-0.25,-0.2,0.25,0.25 surface }
				velocity { point 0,-1,0 }
				size { box 0.5,1 }
				tint { point 0.545098,0.0784314,0.0784314 }
				offset { point 0,-5,0 }
				length { point 1,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 10,0,0,20,0,0 }
			}

			impact
			{
				bounce	0.2
			}
		}
	}
	spawner "unnamed2"
	{
		count		3,3
		locked

		line
		{
			duration	0.75,0.75
			material	"gfx/effects/fluids_drips/blood_spit_alpha"

			start
			{
				size { point 2 }
				offset { point 0,-5,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { point 0,-20,0 }
			}
		}
	}
	spawner "unnamed1"
	{
		count		2,2

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/gore_spray/bloodhit3"

			start
			{
				velocity { box -5,-20,-5,5,-30,5 }
				size { point 0,0 }
				tint { point 0.501961,0,0 }
				offset { point 0,-5,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 5,5 }
			}
		}
	}
	emitter "spew 3"
	{
		duration	0.25,0.25
		count		10,10

		sprite
		{
			duration	0.35,0.35
			persist
			material	"gfx/effects/monsters/slimy_transfer/puke_fly"
			gravity		0.2,0.2

			start
			{
				velocity { point 0,-50,0 }
				size { point 2,2 }
				tint { line 0.607843,0,0,0.588235,0.0784314,0.0196078 }
				offset { point 0,-5,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope arch count 0.7,0.7 }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 10,10,15,15 }
			}
		}
	}
	emitter "spew 4"
	{
		duration	0.25,0.25
		count		10,10

		sprite
		{
			duration	0.35,0.35
			persist
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.2,0.2

			start
			{
				velocity { box -20,-50,-20,20,-50,20 }
				size { point 2,2 }
				tint { line 1,0,0,0.411765,0.0784314,0.0784314 }
				offset { point 0,-5,0 }
				rotate { box -0.5,0.5 }
			}

			motion
			{
				size { envelope arch count 0.7,0.7 }
				fade { envelope linear }
			}

			end
			{
				size { line 5,5,10,10 }
			}
		}
	}
}


