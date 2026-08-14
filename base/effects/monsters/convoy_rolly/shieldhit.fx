effect effects/monsters/convoy_rolly/shieldhit
{
	size	214

	spawner "unnamed2"
	{
		count		25,25
		locked

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/weapons/g_rail_flash"
			generatedNormal

			start
			{
				position { sphere -50,-50,-50,50,50,50 surface }
				size { line 40,40,60,60 }
				tint { line 1,1,1,0.866667,0.537255,0.419608 }
				fade { point 0 }
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
				size { line 80,80,120,120 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 0.5 }
			}
		}
	}
	sound "unnamed2"
	{
		soundShader	"effects_bulletimpact_absorb"
		freqshift	1.5,1.5
	}
}







