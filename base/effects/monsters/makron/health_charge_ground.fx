effect effects/monsters/makron/health_charge_ground
{
	size	788

	emitter "electricity2"
	{
		duration	1,1
		count		5,5
		locked

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	3,8,5
			jitterTable	"halfsintable"
			material	"gfx/effects/weapons/darkmatterbolt"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 0,-10,-10,0,10,10 }
				size { point 10 }
				tint { point 0.639216,0.568627,0.741176 }
				length { box 50,0,0,200,0,0 }
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
	emitter "unnamed8"
	{
		duration	1,1
		count		5,5

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 1,0,0 }
				velocity { point 100,0,0 }
				size { point 500,500 }
				tint { point 0.921569,0.54902,0.784314 }
				rotate { box 0,0,-0.0833333,0,0,0.0833333 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}
		}
	}
	emitter "spinny2"
	{
		duration	1,1
		count		10,30

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy1"

			start
			{
				position { sphere 0,-10,-10,0,10,10 surface }
				velocity { box 50,0,0,200,0,0 }
				angle { box -0.1,-0.1,-0.1,0.1,0.1,0.1 }
				size { line 1,1,5,5 }
				tint { line 1,1,1,1,0.47451,0.854902 }
				offset { box 0,-100,-100,0,100,100 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 5,5,10,10 }
			}
		}
	}
	emitter "unnamed12"
	{
		duration	1,1
		count		2,2

		oriented
		{
			duration	2,2
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				position { point 1,0,0 }
				size { point 350,350 }
				tint { point 0.921569,0.54902,0.784314 }
				rotate { point 0,0,0.0277778 }
			}

			motion
			{
				size { envelope "linear" offset 0.5,0.5 }
				fade { envelope "cosine" offset 0.5 }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 550,550 }
			}
		}
	}
	emitter "deform2"
	{
		duration	1,1
		count		0.002,0.002

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/teleport_warp"

			start
			{
				size { point 10,10 }
				offset { point -80,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "cosine" }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	emitter "electricity4"
	{
		duration	1,1
		count		10,20

		electricity
		{
			duration	0.25,0.25
			blend	add
			fork	2
			jitterRate	0
			jitterSize	3,12,7
			jitterTable	"halfsintable"
			material	"gfx/effects/energy_sparks/energy1"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-200,-200,0,200,200 }
				size { box 1,5 }
				tint { point 1,0.768628,0.882353 }
				fade { point 0.5 }
				length { box 100,0,0,150,0,0 }
			}

			motion
			{
				length { envelope "linear" }
			}
		}
	}
	sound "unnamed13"
	{
		soundShader	"effects_teleporter_big"
	}
	emitter "fuzz2"
	{
		duration	1,1
		count		21,21

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/plasma1"
			gravity		-0.5,-0.5
			generatedNormal

			start
			{
				position { sphere 0,-120,-120,0,120,120 surface }
				velocity { point -80,0,0 }
				size { line 150,150,300,300 }
				tint { line 1,1,1,0.890196,0.32549,0.85098 }
				fade { point 0 }
				rotate { box 0,0.5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 0,0 }
				fade { line 0.25,0.5 }
			}
		}
	}
}




