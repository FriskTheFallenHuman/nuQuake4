effect effects/mp/armor_yellow
{
	size	89

	emitter "shield"
	{
		duration	1,1
		count		30,30
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash3_grey"
			generatedNormal

			start
			{
				position { sphere -20,-20,-20,20,20,20 surface }
				velocity { point -10,0,0 }
				size { line 15,15,20,20 }
				tint { point 1,1,0 }
				fade { point 0.8 }
				offset { point 0,0,12 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				size { envelope convexfade }
				fade { envelope exp_1minusx/x2 }
			}

			end
			{
				size { line 30,30,40,40 }
			}
		}
	}
}

