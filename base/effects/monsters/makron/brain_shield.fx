effect effects/monsters/makron/brain_shield
{
	size	1326

	emitter "unnamed2"
	{
		duration	1,1
		count		100,100
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"
			generatedNormal

			start
			{
				position { sphere 250,-200,-200,750,200,200 surface }
				size { line 80,80,100,100 }
				tint { point 0.501961,0.501961,1 }
				fade { point 0 }
				offset { point -500,0,0 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				size { envelope "convexfade" }
				tint { envelope "exp_x2" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 200,200,300,300 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 1 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		50,50
		locked

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/flash_hot"
			generatedNormal

			start
			{
				position { sphere 250,-200,-200,750,200,200 surface }
				tint { point 1,0.54902,0.776471 }
				fade { point 0 }
				offset { point -500,0,0 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				size { envelope "convexfade" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { point 20,20 }
				fade { point 1 }
			}
		}
	}
}


