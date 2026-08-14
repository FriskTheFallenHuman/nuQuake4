effect effects/levels/terminal/brain_explosion
{
	size	1639

	emitter "unnamed10"
	{
		duration	1,1
		count		30,30

		debris
		{
			duration	1,1
			entityDef	"debris_gib_brain2"
			generatedOriginNormal

			start
			{
				position { sphere -120,-120,-120,120,120,120 surface }
				velocity { box 200,-200,-200,200,200,200 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { box -22.2222,-22.2222,-22.2222,22.2222,22.2222,22.2222 }
			}
		}
	}
	emitter "unnamed9"
	{
		duration	1,1
		count		30,30

		debris
		{
			duration	1,1
			entityDef	"debris_gib_brain1"
			generatedOriginNormal

			start
			{
				position { sphere -5,-5,-5,5,5,5 surface }
				velocity { box 500,-500,-500,500,500,500 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { box -13.8889,-13.8889,-13.8889,13.8889,13.8889,13.8889 }
			}
		}
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		attenuateEmitter
		attenuation	200,600
	}
	spawner "column_fire"
	{
		count		19,19

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/gore_spray/bloodhit4"
			entityDef	"debris_gib_brain1"

			start
			{
				position { sphere -180,-180,-180,180,180,180 linearSpacing }
				velocity { box 50,-100,-100,500,100,100 }
				angle { box 0,0,0,1,1,1 }
				size { box 350,350,380,380 }
				tint { line 1,0.768628,0.768628,0.501961,0.247059,0.247059 }
				offset { box -2,-2,-2,2,100,100 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 60,60,80,80 }
				tint { point 0.501961,0,0 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.277778,0.277778 relative }
			}
		}
	}
	spawner "fragments"
	{
		count		30,30

		line
		{
			duration	0.5,1
			material	"gfx/effects/fluids_drips/blood_spit_alpha"
			entityDef	"debris_gib_brain1"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-0.1,-0.1,0,0.1,0.1 surface }
				velocity { point 100,0,0 }
				size { box 50,80 }
				offset { point 0,100,100 }
				length { point 100,0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 300 }
				length { box 500,0,0,1000,0,0 }
			}
		}
	}
	emitter "unnamed8"
	{
		duration	1,1
		count		10,10

		electricity
		{
			duration	0.5,1
			blend	add
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			jitterTable	"halfsintable"
			material	"gfx/effects/electricity/electric_blue_fade"
			entityDef	"debris_gib_brain1"
			generatedNormal

			start
			{
				position { sphere -50,-50,-50,50,50,50 surface }
				size { point 3 }
				tint { line 1,0.501961,0.501961,1,1,1 }
				offset { point 0,50,100 }
				length { point 20,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				length { box 200,0,0,300,0,0 }
			}
		}
	}
	spawner "flash3"
	{
		count		1,1

		sprite
		{
			duration	0.2,0.2
			material	"gfx/effects/weapons/flash"
			entityDef	"debris_gib_brain1"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 800,800,1000,1000 }
				tint { point 1,0.713726,0.713726 }
				offset { point 0,100,200 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "linear" }
			}
		}
	}
	emitter "column_fire4"
	{
		duration	2,2
		count		20,20

		sprite
		{
			duration	1,3
			material	"gfx/effects/gore_spray/bloodhit4"
			entityDef	"debris_gib_brain1"
			gravity		0.25,0.25

			start
			{
				position { sphere -100,-100,-100,100,100,100 surface linearSpacing }
				velocity { box -150,-150,-150,150,150,150 }
				size { box 150,150,180,150 }
				tint { line 1,0.666667,0.666667,0.501961,0,0 }
				offset { point 0,100,200 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 250,250,350,350 }
				rotate { box -0.0555556,0.0555556 }
			}
		}
	}
	sound "unnamed12"
	{
		soundShader	"core_brain_explosion"
	}
	sound "unnamed14"
	{
		start		0.3,0.3
		soundShader	"core_brain_explosion"
		freqshift	0.6,0.6
	}
	emitter "column_fire5"
	{
		start		3,3
		duration	4,4
		count		5,5

		sprite
		{
			duration	1,3
			material	"gfx/effects/gore_spray/bloodhit4"
			entityDef	"debris_gib_brain1"
			gravity		0.25,0.25

			start
			{
				position { sphere -20,-20,-20,20,20,20 surface linearSpacing }
				velocity { box -50,-50,0,50,50,251 }
				size { point 50,50 }
				tint { line 1,0.423529,0.423529,0.501961,0,0 }
				offset { point 0,100,200 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 100,100,150,150 }
				rotate { box -0.0555556,0.0555556 }
			}

			impact
			{
				remove	1
				effect	"effects/monsters/brain_gib"
			}
		}
	}
	emitter "column_fire6"
	{
		duration	2,2
		count		20,20

		sprite
		{
			duration	1,3
			material	"gfx/effects/gore_spray/bloodhit4"
			entityDef	"debris_gib_brain1"
			gravity		0.25,0.25

			start
			{
				position { sphere -100,-100,-100,100,100,100 surface linearSpacing }
				velocity { box -150,-150,-150,150,150,150 }
				size { box 150,150,180,150 }
				tint { line 1,0.666667,0.666667,0.501961,0,0 }
				offset { point 0,100,200 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 250,250,350,350 }
				rotate { box -0.0555556,0.0555556 }
			}

			impact
			{
				remove	1
				effect	"effects/monsters/brain_gib"
			}
		}
	}
	sound "unnamed12"
	{
		soundShader	"brain_scream"
	}
	sound "unnamed13"
	{
		soundShader	"brain_explode_big"
	}
	sound "unnamed14"
	{
		soundShader	"brain_scream2"
		freqshift	0.5,0.5
	}
	sound "unnamed15"
	{
		soundShader	"effects_explosion_nodebris"
		freqshift	0.5,0.5
	}
	sound "unnamed16"
	{
		soundShader	"brain_explode_chunks"
		freqshift	0.9,0.9
	}
}












