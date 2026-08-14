effect effects/levels/storage/flak
{
	size	5241

	spawner "outersmoke"
	{
		count		10,10

		sprite
		{
			duration	2,5
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.025,0

			start
			{
				position { sphere -150,-150,-150,150,150,150 }
				velocity { box 100,-10,-10,100,10,10 }
				acceleration { box -500,0,0,-1000,0,0 }
				size { line 50,50,120,120 }
				tint { line 0.141176,0.121569,0.101961,0,0,0 }
				fade { point 0 }
				offset { box -100,-100,-100,100,100,100 }
				rotate { box 0,0.25 }
			}

			motion
			{
				size { envelope linear count 0.8,0.8 offset 0.05,0.05 }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 300,300 }
				fade { point 0.75 }
				rotate { point 0.125 }
			}
		}
	}
	spawner "flash2"
	{
		count		5,5

		sprite
		{
			duration	0.3,0.5
			persist
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { sphere -10,-10,-10,10,10,10 }
				velocity { box 50,-35,-35,200,35,35 }
				acceleration { box -1500,0,0,-2000,0,0 }
				size { point 60,60 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.1,0.1
			persist
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 80,80 }
				tint { point 0.74902,0.74902,0.74902 }
			}

			motion
			{
				size { envelope arch count 0.8,0.8 offset 0.2,0.2 }
			}

			end
			{
				size { point 400,400 }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"player_grenadelauncher_explode"
	}
	sound "unnamed4"
	{
		soundShader	"effects_explosion_nodebris"
		volume	0.5,0.5
	}
	emitter "flash3"
	{
		duration	0.2,0.2
		count		20,20

		sprite
		{
			duration	0.1,0.1
			persist
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				position { sphere -50,-50,-50,50,50,50 }
				size { point 10,10 }
				tint { point 0.74902,0.74902,0.74902 }
			}

			motion
			{
				size { envelope arch count 0.8,0.8 offset 0.2,0.2 }
			}

			end
			{
				size { point 80,80 }
			}
		}
	}
}

