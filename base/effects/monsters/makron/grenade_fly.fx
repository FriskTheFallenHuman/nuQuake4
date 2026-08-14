effect effects/monsters/makron/grenade_fly
{
	size	202

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
				size { point 15,15 }
				rotate { box 1,-1 }
			}

			motion
			{
				size { envelope cosine }
				fade { envelope linear }
			}

			end
			{
				size { box 50,50,60,60 }
			}
		}
	}
	emitter "model"
	{
		duration	1,1
		count		1,1
		locked

		model
		{
			duration	3.95,3.95
			material	"models/weapons/grenadelauncher/w_grenade"
			model		"models/weapons/grenadelauncher/w_grenade.lwo"
		}
	}
	emitter "unnamed1"
	{
		duration	1,1
		count		50,50
		attenuateEmitter

		sprite
		{
			duration	0.5,0.5
			blend	add
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 12,12,16,16 attenuate }
				tint { line 0.501961,0,0.501961,0.384314,0.027451,0.470588 }
				fade { point 0.3 }
				offset { point -5,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 15,15,20,19 attenuate }
				rotate { box 0,0.25 relative }
			}
		}
	}
	emitter "dots"
	{
		duration	1,1
		count		15,30
		locked

		sprite
		{
			duration	0.75,0.75
			persist
			material	"gfx/effects/weapons/darkmatter_haze"

			start
			{
				angle { box 0,0,-0.166667,0,0,0.166667 }
				size { box 5,5,10,10 }
				tint { point 0.827451,0.623529,0.909804 }
				fade { point 0 }
				offset { box -100,-100,-100,100,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				offset { envelope linear }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 15,15,20,20 }
				fade { point 0.25 }
				offset { box 0,0,0,20,20,20 }
			}
		}
	}
	spawner "center"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/darkmatter"

			start
			{
				size { point 15,15 }
			}

			motion
			{
				size { envelope randomflick }
			}

			end
			{
				size { point 20,20 }
			}
		}
	}
	emitter "electricity"
	{
		duration	1,1
		count		40,40
		locked

		electricity
		{
			duration	0.06,0.06
			fork	0
			jitterRate	0
			jitterSize	6,14,14
			material	"gfx/effects/weapons/darkmatterbolt"
			generatedOriginNormal

			start
			{
				position { cylinder -1,-1,-1,1,1,1 surface }
				size { point 4 }
				tint { point 0.639216,0.572549,0.745098 }
				length { box 20,0,0,30,0,0 }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"makron_grenade_fly"
	}
}



