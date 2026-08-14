effect effects/monsters/light_tank/fireball_charge
{
	size	105

	sound "sound"
	{
		soundShader	"effects_fire_build"
		freqshift	2.5,2.5
	}
	spawner "plume"
	{
		count		20,20
		locked

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { line -5,0,0,5,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 2,2 }
				tint { point 0.882353,0.513726,0.176471 }
				fade { point 0 }
				offset { box 0,-1,-1,0,1,1 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				offset { envelope "exp_x2" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 40,40 }
				fade { point 1 }
				offset { box 0,-30,-30,0,30,30 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "spots"
	{
		detail		0.5
		count		50,50
		locked

		sprite
		{
			duration	0.8,0.8
			blend	add
			material	"gfx/effects/energy_sparks/spark3"

			start
			{
				position { line -5,0,0,5,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 0.5,0.5,1,1 }
				tint { line 1,0.501961,0,1,1,1 }
				fade { point 0 }
				offset { box 0,-60,-60,0,60,60 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				offset { envelope "exp_x2" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 8,8,12,12 }
				fade { point 0.5 }
				offset { box 0,-1,-1,0,1,1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"effects_fire_whoosh"
		freqshift	1.5,1.5
	}
}



