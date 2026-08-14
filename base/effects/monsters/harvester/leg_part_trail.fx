effect effects/monsters/harvester/leg_part_trail
{
	size	470

	sound "sound"
	{
		soundShader	"effects_fire_small"
	}
	emitter "smoke"
	{
		duration	10,10
		count		50,100

		sprite
		{
			duration	3,5
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.055,-0.035

			start
			{
				position { sphere -20,-10,-10,-10,10,10 }
				velocity { box -10,-10,-10,10,10,10 }
				size { line 8,8,16,16 }
				tint { point 0.313726,0.282353,0.2 }
				fade { point 0 }
				offset { point 250,0,0 }
				rotate { box -0.111111,0 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { box 80,80,120,120 }
				fade { line 0.25,0.75 }
				rotate { box -0.222222,-0.111111 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	10,10
		count		4,4

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder -10,-10,-10,10,10,10 }
				size { box 10,10,20,20 }
				fade { point 0 }
				offset { point 250,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { box 40,40,50,50 }
				fade { point 0.6 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire3"
	{
		duration	10,10
		count		3,3

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire3a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder -10,-10,-10,10,10,10 }
				velocity { box 0,-5,-5,0,5,5 }
				size { box 30,30,40,40 }
				fade { point 0 }
				offset { box 248,-2,-2,252,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 8,8,15,15 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "fire5"
	{
		duration	10,10
		count		3,3

		sprite
		{
			duration	0.75,1.25
			blend	add
			material	"gfx/effects/fire/fire5a"
			gravity		-0.05,-0.05

			start
			{
				position { cylinder -10,-10,-10,10,10,10 }
				size { box 30,30,40,40 }
				fade { point 0 }
				offset { point 250,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope cosine }
				rotate { envelope linear }
			}

			end
			{
				size { box 8,8,15,15 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed5"
	{
		soundShader	"effects_fire_gas2"
	}
}

