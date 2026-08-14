effect effects/levels/waste/wastespew_long
{
	size	151

	spawner "phys"
	{
		count		1,1

		sprite
		{
			duration	1.5,1.5
			persist
			material	"gfx/effects/monsters/slimy_transfer/puke_fly"
			gravity		0.2,0.2

			start
			{
				position { line 0,-5,-5,0,5,5 }
				velocity { point 75,0,0 }
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
		duration	1,1
		count		10,20

		sprite
		{
			duration	0.8,1.25
			persist
			material	"gfx/effects/monsters/slimy_transfer/puke_fly"
			gravity		0.2,0.2

			start
			{
				position { line 0,-5,-5,0,5,5 }
				velocity { box 50,-30,-30,50,30,30 }
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
		duration	1,1
		count		10,11

		sprite
		{
			duration	0.6,0.75
			persist
			material	"gfx/effects/monsters/slimy_transfer/puke_fly"
			gravity		0.2,0.2

			start
			{
				position { box -2,-2,-2,2,2,2 }
				velocity { box 50,-10,-10,70,10,10 }
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
	emitter "lineart"
	{
		duration	1,1
		count		10,15

		line
		{
			duration	0.6,1
			blend	add
			generatedLine
			persist
			material	"gfx/effects/fire/fire_napalm_glob"
			entityDef	"debris_gib_rup_arm"
			gravity		0.2,0.3

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { point 70,0,0 }
				size { point 20 }
				tint { line 0.388235,0.054902,0.054902,0.247059,0,0 }
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
		duration	1,1
		count		10,15

		line
		{
			duration	0.5,1
			blend	add
			generatedLine
			persist
			material	"gfx/effects/fluids_drips/blood_spit_alpha"
			entityDef	"debris_gib_rup_arm"
			gravity		0.2,0.3

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { point 70,0,0 }
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
		duration	1,1
		count		10,11

		sprite
		{
			duration	0.8,1.75
			persist
			material	"gfx/effects/gore_spray/bloodhit2"
			entityDef	"debris_gib_rup_arm"
			gravity		0.2,0.2

			start
			{
				position { line 0,-5,-5,0,5,5 }
				velocity { box 50,-30,-30,50,30,30 }
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

