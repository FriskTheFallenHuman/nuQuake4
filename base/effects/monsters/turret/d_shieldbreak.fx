effect effects/monsters/turret/d_shieldbreak
{
	size	425

	spawner "BURST"
	{
		count		50,50
		locked

		oriented
		{
			duration	0.7,0.7
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"
			generatedNormal

			start
			{
				position { sphere 0,-140,-140,160,140,140 surface }
				velocity { box -200,0,0,200,0,0 }
				size { line 80,80,160,160 }
				tint { line 1,1,1,1,1,0 }
				fade { point 0.8 }
				offset { box 0,-1,-1,0,1,1 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				tint { envelope exp_x2 }
				fade { envelope exp_xoverx2 }
				angle { envelope linear }
			}

			end
			{
				angle { box -0.05,-0.05,-0.05,0.05,0.05,0.05 }
			}
		}
	}
	spawner "unnamed2"
	{
		count		1,1

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/flash_hot"

			start
			{
				size { point 300,300 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
			}
		}
	}
}





