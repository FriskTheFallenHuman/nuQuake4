effect effects/monsters/bossbuddy/grenade_launch
{
	size	100

	emitter "burst fill"
	{ 
		duration	.3,.3
		count		40,40

		sprite
		{
			duration	0.15,0.2
			material	"gfx/effects/particles_shapes/spike"
			gravity		0.001,0.03

			start
			{
				position { box -2,-2,-2,2,2,2 }
				velocity { box 5,-5,-5,25,5,5 }
				size { point 80,80 }
				tint { line 0.454902,0.815686,0.894118,1,1,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 10,10 }
				rotate { box -0.166667,0.166667 }
			}
		}
	}
	emitter "burst fill2"
	{
		duration	.1,.1
		count		40,40

		sprite
		{
			duration	0.15,0.2
			blend	add
			material	"gfx/effects/energy_sparks/energy1"
			gravity		0.1,0.3

			start
			{
				position { box -2,-2,-2,2,2,2 }
				velocity { box 50,0,0,100,0,0 }
				size { point 5,5 }
				tint { line 0.454902,0.811765,0.894118,1,1,1 }
				fade { point 1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 1,1 }
				rotate { box -0.166667,0.166667 }
			}
		}
	}
}
