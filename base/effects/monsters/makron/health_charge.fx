effect effects/monsters/makron/health_charge
{
	size	283

	emitter "center2"
	{
		duration	1,1
		count		7,7
		locked

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				size { point 60,60 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope "cosine" }
				fade { envelope "linear" }
			}

			end
			{
				size { box 150,150,200,200 }
			}
		}
	}
	emitter "center3"
	{
		duration	1,1
		count		20,20
		locked

		sprite
		{
			duration	1,2
			blend	add
			persist
			material	"gfx/effects/weapons/plasma1"

			start
			{
				velocity { point 10,0,0 }
				size { line 60,60,65,65 }
				tint { line 0.854902,0.811765,0.870588,0.568627,0.447059,0.619608 }
				fade { line 0.25,0.75 }
				offset { box -50,-50,-50,50,50,50 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				offset { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 10,10,20,20 }
				angle { box -1,1,-1,1,1,1 }
				rotate { box -0.25,0.25 }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"effects_fire_whoosh"
		freqshift	1.7,1.7
	}
	sound "unnamed7"
	{
		soundShader	"makron_grenade_fly"
	}
}
