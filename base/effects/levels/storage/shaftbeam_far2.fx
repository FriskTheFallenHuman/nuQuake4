effect effects/levels/storage/shaftbeam_far2
{
	size	10660

	spawner "main"
	{
		count		2,2
		constant

		line
		{
			duration	1,1
			persist
			material	"gfx/effects/energy_sparks/blue_beam_last"

			start
			{
				size { point 55 }
				tint { point 0.00392157,0.156863,0.572549 }
				length { point 10560,0,0 }
			}
		}
	}
	emitter "Large Bot Glow"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/warm_blend_last"

			start
			{
				size { point 200,200 }
				tint { point 0.501961,0.819608,1 }
			}
		}
	}
	emitter "Gas Cyl"
	{
		duration	1,1
		count		10,15

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/plasma1_last"
			generatedNormal

			start
			{
				position { spiral 0,-20,-20,820,20,20,2 }
				velocity { point 15,0,0 }
				size { point 300,100 }
				tint { point 0,0,0 }
			}

			motion
			{
				tint { envelope "rollingfade" }
			}

			end
			{
				tint { point 0.133333,0.258824,0.258824 }
			}
		}
	}
	emitter "Gas Bot Ring"
	{
		duration	1,1
		count		2,2
		locked

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/plasma1_last"

			start
			{
				size { point 350,350 }
				tint { point 0,0,0 }
				fade { point 0.3 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear_nc" }
			}

			end
			{
				size { point 400,400 }
				tint { point 0.0784314,0.129412,0.129412 }
			}
		}
	}
	emitter "Bot Hot Spot"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/warm_blend_last"
			generatedOriginNormal

			start
			{
				size { point 50,50 }
			}
		}
	}
	emitter "Gas Bot Ring2"
	{
		duration	1,1
		count		2,2
		locked

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/plasma1_last"

			start
			{
				size { point 350,350 }
				tint { point 0,0,0 }
				fade { point 0.3 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear_nc" }
			}

			end
			{
				size { point 400,400 }
				tint { point 0.0588235,0.105882,0.14902 }
			}
		}
	}
	emitter "Gas Bot Ring3"
	{
		duration	1,1
		count		2,2
		locked

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/plasma1_last"

			start
			{
				size { point 180,180 }
				tint { point 0,0,0 }
				fade { point 0.3 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear_nc" }
			}

			end
			{
				size { point 300,300 }
				tint { point 0.0705882,0.121569,0.121569 }
			}
		}
	}
	spawner "residualline"
	{
		count		1,1
		constant

		line
		{
			duration	1,1
			blend	add
			material	"gfx/effects/particles_shapes/add_line_last"

			start
			{
				size { point 100 }
				tint { point 0.00392157,0.392157,0.678431 }
				length { point 10560,0,0 }
			}
		}
	}
	emitter "Large Bot Glow2"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/warm_blend_last"
			generatedOriginNormal

			start
			{
				position { point 10560,0,0 }
				size { point 200,200 }
				tint { point 0.501961,0.819608,1 }
			}
		}
	}
	emitter "Gas Bot Ring4"
	{
		duration	1,1
		count		2,2
		locked

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/plasma1_last"

			start
			{
				position { point 10560,0,0 }
				size { point 350,350 }
				tint { point 0,0,0 }
				fade { point 0.3 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear_nc" }
			}

			end
			{
				size { point 400,400 }
				tint { point 0.0784314,0.129412,0.129412 }
			}
		}
	}
	emitter "Bot Hot Spot2"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	1,1
			material	"gfx/effects/particles_shapes/warm_blend_last"
			generatedOriginNormal

			start
			{
				position { point 10560,0,0 }
				size { point 50,50 }
			}
		}
	}
	emitter "Gas Bot Ring Outer"
	{
		duration	1,1
		count		2,2
		locked

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/plasma1_last"

			start
			{
				position { point 10560,0,0 }
				size { point 520,520 }
				tint { point 0,0,0 }
				fade { point 0.3 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear_nc" }
			}

			end
			{
				size { point 530,530 }
				tint { point 0.0588235,0.105882,0.14902 }
			}
		}
	}
	emitter "Gas Bot Ring6"
	{
		duration	1,1
		count		2,2
		locked

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/plasma1_last"

			start
			{
				position { point 10560,0,0 }
				size { point 180,180 }
				tint { point 0,0,0 }
				fade { point 0.3 }
				rotate { box 0,0,0,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear_nc" }
			}

			end
			{
				size { point 300,300 }
				tint { point 0.0705882,0.121569,0.121569 }
			}
		}
	}
	emitter "Gas Cyl2"
	{
		duration	1,1
		count		10,15

		oriented
		{
			duration	2,2
			material	"gfx/effects/weapons/plasma1_last"
			generatedNormal

			start
			{
				position { spiral 10560,-20,-20,9298,80,80,2 }
				velocity { point 15,0,0 }
				size { point 300,100 }
				tint { point 0,0,0 }
			}

			motion
			{
				tint { envelope "rollingfade" }
			}

			end
			{
				tint { point 0.00392157,0.152941,0.211765 }
			}
		}
	}
	emitter "elect5"
	{
		duration	1,1
		count		1,1

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	1,2,2
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade_last"
			generatedNormal

			start
			{
				position { point 0,0,0 cone }
				size { point 10 }
				length { point 711,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
			}

			end
			{
				tint { point 1,1,1 }
			}
		}
	}
	spawner "bolt core"
	{
		count		1,1
		constant

		line
		{
			duration	1,1
			material	"gfx/effects/electricity/lgun_last"
			tiling	256

			start
			{
				size { box 35,55 }
				tint { point 0.866667,1,1 }
				length { point 10560,0,0 }
			}

			motion
			{
				tint { envelope "flickerblink" count 8,8,8 }
			}

			end
			{
				tint { point 0.247059,0.247059,0.247059 }
			}
		}
	}
	spawner "main2"
	{
		count		2,2
		constant

		line
		{
			duration	1,1
			persist
			material	"gfx/effects/energy_sparks/blue_beam_last"

			start
			{
				size { point 25 }
				tint { point 0.752941,0.752941,0.752941 }
				length { point 10560,0,0 }
			}
		}
	}
}

