effect effects/explosions/air/flak
{
	size	1390

	spawner "outersmoke"
	{
		count		6,10

		sprite
		{
			duration	2,5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.025,0

			start
			{
				position { sphere -320,-320,-320,320,320,320 }
				velocity { box -80,-80,-80,80,80,80 }
				size { point 50,50 }
				tint { line 0.203922,0.176471,0.145098,0,0,0 }
				fade { point 0 }
				offset { box -100,-100,-100,100,100,100 }
				rotate { box 0,0.25 }
			}

			motion
			{
				size { envelope cosine count 0.8,0.8 offset 0.05,0.05 }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { point 450,450 }
				fade { point 1 }
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
			blend	add
			material	"gfx/effects/fire/impact_fire"

			start
			{
				position { point 1,0,0 }
				velocity { box -400,-400,-400,400,400,400 }
				size { point 60,60 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
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
			material	"gfx/effects/energy_sparks/spark2"

			start
			{
				size { point 450,450 }
				tint { point 0.74902,0.74902,0.74902 }
			}

			motion
			{
				size { envelope linear }
			}

			end
			{
				size { point 110,110 }
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
}

