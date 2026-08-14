effect effects/levels/dispersal/harvester_bridge_stomp
{
	size	387

	spawner "spark"
	{
		count		2,3

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			gravity		1,1.5
			trailType	motion
			trailTime	0.5,0.5
			trailCount	10,10

			start
			{
				position { point 1,0,0 }
				velocity { box 100,-150,-150,350,150,150 }
				size { line 5,5,20,20 }
				tint { point 0.921569,0.882353,0.752941 }
			}

			motion
			{
				tint { envelope linear_flicker }
				fade { envelope linear_flicker }
			}

			impact
			{
				bounce	0.3
			}
		}
	}
	light "light"
	{
		locked

		light
		{
			duration	0.02,0.02
			material	"lights/defaultPointLight"

			start
			{
				position { point 10,0,0 }
				size { point 180,180,180 }
				tint { point 0,0,0 }
				fade { point 0.5 }
			}

			motion
			{
				tint { envelope pop_fade }
			}

			end
			{
				tint { point 0.819608,0.627451,0.337255 }
			}
		}
	}
	spawner "spark_blank"
	{
		count		3,5

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/particles_shapes/blank"
			gravity		0.4,0.8
			trailType	motion
			trailTime	0.2,0.2
			trailCount	5,5

			start
			{
				position { point 1,0,0 }
				velocity { box 50,-150,-150,350,150,150 }
				size { line 2.5,2.5,4.5,4.5 }
				tint { point 0.921569,0.882353,0.752941 }
			}

			motion
			{
				tint { envelope linear_flicker }
				fade { envelope linear_flicker }
			}

			impact
			{
				bounce	0.3
			}
		}
	}
	sound "sound"
	{
		soundShader	"harvester_bridge_crush"
	}
	spawner "smoke"
	{
		count		20,20

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/steam_alpha"

			start
			{
				position { line -20,-20,-20,20,20,20 }
				velocity { box 0,-50,-50,50,50,50 }
				size { line 30,30,50,50 }
				tint { line 0.752941,0.752941,0.752941,0.537255,0.596078,0.403922 }
				fade { line 1,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				fade { envelope guitable_10_0 }
				rotate { envelope linear }
			}

			end
			{
				rotate { box 0.25,0.333333 relative }
			}
		}
	}
}




