effect effects/levels/terminal/brain_shieldt
{
	size	299

	emitter "unnamed2"
	{
		duration	0.2,0.2
		count		1000,1000
		locked

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"
			generatedNormal

			start
			{
				position { sphere 0,-130,-130,180,130,130 surface }
				size { line 40,40,60,60 }
				tint { line 1,1,1,0.866667,0.537255,0.419608 }
				fade { point 0 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				size { envelope convexfade }
				tint { envelope exp_x2 }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 80,80,120,120 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0.5 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	0.2,0.2
		count		200,200
		locked

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/flash_hot"
			generatedNormal

			start
			{
				position { sphere 0,-130,-130,180,130,130 surface }
				fade { point 0 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				size { envelope convexfade }
				fade { envelope fastinslowout }
			}

			end
			{
				size { point 5,5 }
				fade { point 1 }
			}
		}
	}
}
