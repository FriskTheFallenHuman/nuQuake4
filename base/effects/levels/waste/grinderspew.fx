effect effects/levels/waste/grinderspew
{
	size	143

	emitter "phys"
	{
		duration	1.5,1.5
		count		0.2,0.5

		sprite
		{
			duration	1,1
			material	"gfx/effects/monsters/slimy_transfer/puke_fly"
			gravity		0.2,0.2

			start
			{
				position { line 0,-5,-5,0,5,5 }
				velocity { box 150,-20,-20,150,20,20 }
				size { line 2,2,10,10 }
				tint { line 0.435294,0.0666667,0.0666667,0.219608,0.027451,0.027451 }
			}

			motion
			{
				size { envelope arch count 0.7,0.7 }
			}

			end
			{
				size { line 10,10,20,20 }
			}

			impact
			{
				remove	1
				effect	"effects/levels/waste/wastesplash"
			}
		}
	}
	emitter "makeMeCool"
	{
		duration	1.5,1.5
		count		10,20

		sprite
		{
			duration	0.6,0.75
			material	"gfx/effects/monsters/slimy_transfer/puke_fly"
			gravity		0.2,0.2

			start
			{
				position { line 0,-5,-5,0,5,5 }
				velocity { box 80,-30,-30,130,30,30 }
				size { line 2,2,10,10 }
				tint { line 0.435294,0.0666667,0.0666667,0.219608,0.027451,0.027451 }
			}

			motion
			{
				size { envelope arch count 0.7,0.7 }
			}

			end
			{
				size { line 10,10,20,20 }
			}
		}
	}
	emitter "makeMeCool2"
	{
		duration	1.5,1.5
		count		10,11

		sprite
		{
			duration	0.6,0.75
			material	"gfx/effects/monsters/slimy_transfer/puke_fly"
			gravity		0.2,0.2

			start
			{
				position { line 0,-10,-10,0,10,10 }
				velocity { box 70,-10,-10,120,10,10 }
				size { line 2,2,5,5 }
				tint { line 0.894118,0.666667,0.603922,0.894118,0.686275,0.603922 }
			}

			motion
			{
				size { envelope arch count 0.7,0.7 }
			}

			end
			{
				size { point 10,10 }
			}
		}
	}
	emitter "unnamed12"
	{
		duration	1.5,1.5
		count		0.2,0.5

		debris
		{
			duration	1,1
			entityDef	"debris_gib_torso"

			start
			{
				velocity { box 80,-20,-20,200,20,20 }
			}
		}
	}
	emitter "unnamed13"
	{
		duration	1.5,1.5
		count		1,1

		debris
		{
			duration	1,1
			entityDef	"debris_gib_rup_arm"

			start
			{
				velocity { box 70,-20,-20,160,20,20 }
			}
		}
	}
	emitter "lineart"
	{
		duration	1.5,1.5
		count		10,15

		line
		{
			duration	0.3,0.45
			blend	add
			generatedLine
			persist
			material	"gfx/effects/fire/fire_napalm_glob"
			entityDef	"debris_gib_rup_arm"
			gravity		0.2,0.3

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 80,-5,-5,100,5,5 }
				size { point 20 }
				tint { line 0.560784,0.0784314,0.0784314,0.247059,0,0 }
				fade { line 0.7,0.9 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
				length { envelope linear }
			}

			end
			{
				size { box 20,30 }
				length { box 60,0,0,90,0,0 }
			}
		}
	}
	emitter "lineart2"
	{
		duration	1.5,1.5
		count		10,15

		line
		{
			duration	0.35,0.5
			blend	add
			generatedLine
			persist
			material	"gfx/effects/fluids_drips/blood_spit_alpha"
			entityDef	"debris_gib_rup_arm"
			gravity		0.15,0.2

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 80,-10,-10,100,10,10 }
				size { point 15 }
				tint { line 0.447059,0.168627,0.168627,0.247059,0,0 }
				fade { line 0.7,0.9 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear count 2 offset -1 }
				length { envelope linear }
			}

			end
			{
				size { box 20,30 }
				length { box 60,0,0,90,0,0 }
			}
		}
	}
	emitter "makeMeCool3"
	{
		duration	1.5,1.5
		count		10,11

		sprite
		{
			duration	0.6,0.75
			material	"gfx/effects/gore_spray/bloodhit2"
			entityDef	"debris_gib_rup_arm"
			gravity		0.2,0.2

			start
			{
				position { line 0,-5,-5,0,5,5 }
				velocity { box 50,-30,-30,130,30,30 }
				size { line 2,2,10,10 }
				tint { line 0.247059,0,0,0.447059,0.054902,0.054902 }
			}

			motion
			{
				size { envelope fadeintable count 0.7,0.7 }
			}

			end
			{
				size { line 20,20,40,40 }
			}
		}
	}
	sound "unnamed7"
	{
		soundShader	"effects_waste_chunks"
	}
}
