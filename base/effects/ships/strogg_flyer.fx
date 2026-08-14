effect effects/ships/strogg_flyer
{
	size	443

	emitter "jet"
	{
		duration	10,10
		count		1,1
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/ships/strogg_fighter"

			start
			{
				size { point 35 }
				tint { point 0.313726,0.486275,0.466667 }
				length { point 70,0,0 }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"convoy_large_ship_loop2"
	}
	emitter "centre"
	{
		duration	10,10
		count		25,25

		line
		{
			duration	3,4
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			flipNormal

			start
			{
				position { point 50,0,0 }
				acceleration { box 0,-8,0,0,-25,0 }
				size { point 10 }
				tint { point 0.847059,0.921569,0.917647 }
				fade { line 0.06,0.13 }
				length { point 130,0,0 }
			}

			motion
			{
				size { envelope arch offset 0.25 }
				fade { envelope linear count 1.5 offset -0.5 }
				length { envelope linear }
			}

			end
			{
				size { box 10,20 }
				length { point 300,0,0 }
			}
		}
	}
	emitter "side1"
	{
		duration	10,10
		count		13,13

		line
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			flipNormal

			start
			{
				position { point 50,42,0 }
				acceleration { box 0,-8,0,0,-16,0 }
				size { box 2,5 }
				tint { point 0.745098,0.847059,0.862745 }
				fade { line 0.1,0.15 }
				length { point 145,0,0 }
			}

			motion
			{
				size { envelope arch offset 0.25 }
				fade { envelope linear count 1.5 offset -0.5 }
				length { envelope linear }
			}

			end
			{
				size { point 10 }
				length { point 400,0,0 }
			}
		}
	}
	emitter "side2"
	{
		duration	10,10
		count		13,13

		line
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			flipNormal

			start
			{
				position { point 50,-42,0 }
				acceleration { box 0,-8,0,0,-16,0 }
				size { box 2,5 }
				tint { point 0.745098,0.847059,0.862745 }
				fade { line 0.1,0.15 }
				length { point 145,0,0 }
			}

			motion
			{
				size { envelope arch offset 0.25 }
				fade { envelope linear count 1.5 offset -0.5 }
				length { envelope linear }
			}

			end
			{
				size { point 10 }
				length { point 400,0,0 }
			}
		}
	}
}








