effect effects/monsters/gladiator/shield_charge
{
	size	43

	emitter "generator"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"

			start
			{
				position { line 0,-5,-5,0,5,5 }
				velocity { box -15,-5,-5,-15,5,5 }
				size { line 1,1,5,5 }
				offset { point 0,0,-5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope sintable }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 10,10,20,20 }
			}
		}
	}
	emitter "specles"
	{
		duration	1,1
		count		30,30

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash_hot"

			start
			{
				position { sphere -8,-8,-8,8,8,8 surface }
				size { box 1,1,2,2 }
				offset { point 0,0,-3 }
			}

			motion
			{
				size { envelope laserfencebarjump }
				fade { envelope linear }
			}
		}
	}
}
