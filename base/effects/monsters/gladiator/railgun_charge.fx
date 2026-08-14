effect effects/monsters/gladiator/railgun_charge
{
	size	362

	sound "sound"
	{
		soundShader	"gladiator_chargerailgun"
	}
	light "light"
	{

		light
		{
			duration	1.1,1.1
			blend	add
			material	"lights/defaultPointLight"

			start
			{
				position { point 30,0,0 }
				size { point 200,200,200 }
				tint { point 0.776471,0.784314,0.6 }
			}

			motion
			{
				tint { envelope "linear" }
			}
		}
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
				position { line 20,0,0,40,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 2,2 }
				tint { point 0.894118,0.47451,0.427451 }
				fade { point 0 }
				offset { box 0,-1,-1,0,1,1 }
				rotate { box 0,1 }
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
				position { line 20,0,0,30,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 0.5,0.5,1,1 }
				tint { line 0.878431,0.227451,0.137255,1,1,1 }
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
				fade { point 1 }
				offset { box 0,-1,-1,0,1,1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}










