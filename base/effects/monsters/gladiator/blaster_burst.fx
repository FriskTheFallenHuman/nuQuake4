effect effects/monsters/gladiator/blaster_burst
{
	size	103

	sound "sound"
	{
		soundShader	"effects_blaster_hit01"
	}
	decal "decal"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/decals/railgun_impact1"

			start
			{
				size { point 10,10 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "impact_flash"
	{
		count		2,2

		sprite
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/shotgun_mflash"
			generatedNormal

			start
			{
				position { point 8,0,0 }
				size { box 60,60,70,70 }
				tint { point 0.972549,0.447059,0.447059 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
			}

			end
			{
				tint { point 0.760784,0.454902,0.827451 }
			}
		}
	}
	spawner "side_impact_streaks"
	{
		count		6,8
		locked

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/flash_half3"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,-0.2,0.3,0.3 surface }
				size { point 15 }
				tint { line 1,1,1,0.980392,0.360784,0.294118 }
				length { box 45,0,0,65,0,0 }
			}

			motion
			{
				fade { envelope linear }
			}
		}
	}
	emitter "smoke2"
	{
		duration	0.35,0.35
		count		25,25

		sprite
		{
			duration	0.8,1.2
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"
			gravity		-0.05,-0.05

			start
			{
				position { point 10,0,0 }
				velocity { box 0,-5,-5,20,5,5 }
				size { line 6,6,20,20 }
				tint { line 0.909804,0.847059,0.929412,0.592157,0.309804,0.686275 }
				fade { point 0.65 }
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
				size { line 30,30,40,40 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
}







