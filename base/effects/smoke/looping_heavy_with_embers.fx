effect effects/smoke/looping_heavy_with_embers
{
	size	328

	emitter "smoke"
	{
		duration	1,5
		count		2,3

		sprite
		{
			duration	2,3
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.06,-0.03

			start
			{
				position { cylinder 35,1,1,35,-1,-1 }
				velocity { box 15,-5,-5,20,5,5 }
				size { point 50,50 }
				tint { line 0.529412,0.494118,0.396078,0.211765,0.192157,0.152941 }
				rotate { box -0.2,0.2 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine offset 0.5 }
				rotate { envelope linear }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	emitter "embers"
	{
		duration	5,5
		count		3,5

		sprite
		{
			duration	3,4
			material	"gfx/effects/energy_sparks/spark3"
			gravity		-0.08,-0.02

			start
			{
				position { cylinder 25,25,25,25,-25,-25 }
				velocity { box 0,-25,-25,0,25,25 }
				size { point 3,3 }
			}

			motion
			{
				size { envelope ember1 }
				tint { envelope cosine offset 0.5,0.5,0.5 }
			}

			end
			{
				size { point 0.5,0.5 }
			}
		}
	}
}




