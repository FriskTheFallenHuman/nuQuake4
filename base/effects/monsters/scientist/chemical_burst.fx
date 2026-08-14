effect effects/monsters/scientist/chemical_burst
{
	size	37

	emitter "unnamed0"
	{
		duration	1,1
		count		10,10
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/bubble_glob"

			start
			{
				position { sphere -1,-1,-1,1,1,1 }
				velocity { box -10,-10,-10,-10,10,10 }
				size { line 10,10,20,20 }
				tint { point 0.368627,0.427451,0.270588 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope sargetable1 }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 0,0 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "unnamed1"
	{
		start		0,0.05
		duration	1,1
		count		50,50

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/fluids_drips/bubble_glob"
			gravity		0.2,0.2

			start
			{
				position { sphere -3,-3,-3,3,3,3 }
				size { line 5,5,9,8 }
				tint { point 0.54902,0.639216,0.419608 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 0,0 }
				rotate { point 0 relative }
			}
		}
	}
}


