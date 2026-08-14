effect effects/monsters/network_guardian/landing_stomp
{
	size	998

	shake "camerashake"
	{
		duration	0.7,0.7
		scale		4
		attenuateEmitter
		attenuation	200,600
	}
	sound "unnamed17"
	{
		soundShader	"effects_explosion_rock"
		freqshift	2,2
	}
	spawner "dust"
	{
		count		30,30

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.125,-0.025
			generatedOriginNormal

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box 0,-250,-250,0,250,250 }
				friction { point -2200,0,0 }
				size { line 20,20,30,30 }
				tint { line 0.494118,0.494118,0.494118,0.313726,0.337255,0.301961 }
				fade { point 0 }
				offset { point 0,-8,8 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 60,60,70,70 }
				tint { point 0.235294,0.235294,0.235294 }
				fade { point 0.8 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed3"
	{
		soundShader	"generic_rock_impact_large"
		freqshift	2,2
	}
	spawner "dust2"
	{
		count		100,100

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.125,-0.025
			generatedOriginNormal

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box 800,-250,-250,1200,250,250 }
				friction { point -2200,0,0 }
				size { line 20,20,30,30 }
				tint { line 0.494118,0.494118,0.494118,0.313726,0.337255,0.301961 }
				fade { point 0 }
				offset { point 0,-8,8 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 60,60,70,70 }
				tint { point 0.235294,0.235294,0.235294 }
				fade { point 0.8 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed5"
	{
		soundShader	"network_guardian_body_land"
		freqshift	1.8,1.8
	}
}




