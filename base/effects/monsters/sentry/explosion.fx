effect effects/monsters/sentry/explosion
{
	size	807

	sound "sound"
	{
		soundShader	"player_rocketlauncher_explode"
	}
	spawner "smoke2"
	{
		count		5,5

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		-0.125,0
			generatedOriginNormal

			start
			{
				position { cylinder -5,-5,-5,5,5,5 }
				velocity { box -50,-50,-50,50,50,50 }
				size { line 2,2,5,5 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
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
				size { line 50,50,100,100 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "upsmoke2"
	{
		detail		0.5
		count		5,5

		sprite
		{
			duration	1,3
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.05,-0.05

			start
			{
				velocity { box -100,-100,-100,100,100,100 }
				tint { line 0.286275,0.27451,0.239216,0.137255,0.129412,0.109804 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 200,200,300,300 }
			}
		}
	}
	spawner "blood"
	{
		count		5,10

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/gore_spray/bloodhit2"

			start
			{
				velocity { box -200,-200,-200,200,200,200 }
				size { point 5,5 }
				tint { line 0.501961,0,0,1,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 20,20,50,50 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/mgun_muzzleflash"
			entityDef	"debris_gib_rup_arm"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 200,200,250,250 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { line 30,30,40,40 }
			}
		}
	}
	spawner "blood_streaks"
	{
		count		5,5
		locked

		line
		{
			duration	0.25,0.5
			generatedLine
			material	"gfx/effects/gore_spray/bloodline1"
			entityDef	"debris_gib_rup_arm"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.2,-0.3,-0.3,0.2,0.3,0.3 surface }
				velocity { point 1,0,0 }
				size { box 15,20 }
				tint { point 0.309804,0.101961,0.0431373 }
				length { box 40,0,0,45,0,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				tint { point 0.152941,0.0509804,0.0196078 }
				length { box 150,0,0,200,0,0 }
			}
		}
	}
	spawner "sparks_lines"
	{
		detail		0.5
		count		9,12
		locked

		line
		{
			duration	0.15,0.15
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			entityDef	"debris_gib_rup_arm"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -1,-1,-1,1,1,1 surface }
				velocity { box 200,0,0,400,0,0 }
				size { box 2,10 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
				length { box 10,10,10,60,60,60 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
			}
		}
	}
	spawner "sparks"
	{
		detail		0.5
		count		5,7

		sprite
		{
			duration	0.25,0.5
			blend	add
			material	"gfx/effects/energy_sparks/spark2"
			entityDef	"debris_gib_rup_arm"
			gravity		-0.5,0

			start
			{
				velocity { box -150,-150,-150,150,150,150 }
				angle { box 0,0,0,0.277778,0.277778,0.277778 }
				acceleration { point -400,0,0 }
				size { line 2,2,6,6 }
				tint { line 1,0.721569,0.309804,1,1,1 }
				fade { point 0.4 }
				offset { box -10,-10,-10,10,10,10 }
			}

			motion
			{
				fade { envelope "linear_flicker" }
				angle { envelope "linear" }
			}

			end
			{
				angle { box 0.277778,0.277778,0.277778,0.555556,0.555556,0.555556 relative }
			}
		}
	}
	sound "unnamed10"
	{
		soundShader	"player_rocketlauncher_explode2"
	}
	spawner "flash3"
	{
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_gib_rup_arm"
			gravity		-0.5,0

			start
			{
				position { point 1,0,0 }
				velocity { box -60,-60,-60,60,60,60 }
				size { line 60,60,90,90 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { line 0.5,1 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 20,20,30,30 }
			}
		}
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
	spawner "metal debris"
	{
		detail		0.5
		count		3,5

		debris
		{
			duration	1.5,1.5
			entityDef	"debris_barrel_top"
			gravity		1,1
			generatedNormal

			start
			{
				position { sphere -5,-5,-5,5,5,5 }
				velocity { box 200,-300,-300,500,300,300 }
			}
		}
	}
	spawner "gib debris"
	{
		detail		0.5
		count		1,2

		debris
		{
			duration	1.5,1.5
			entityDef	"debris_gib"
			gravity		1,1
			generatedNormal

			start
			{
				position { sphere -5,-5,-5,5,5,5 }
				velocity { box 200,-200,-200,800,200,200 }
			}
		}
	}
}



