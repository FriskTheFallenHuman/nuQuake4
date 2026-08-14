effect effects/monsters/makron/health_charge_battery
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
				tint { point 0.639216,0.564706,0.737255 }
				length { box 50,0,0,200,0,0 }
			}
		}
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
				fade { point 0 }
				rotate { box 0,0,-0.0833333,0,0,0.0833333 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 1 }
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
				tint { line 1,1,1,0.886275,0.321569,0.847059 }
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
	emitter "unnamed4"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/energy2"

			start
			{
				velocity { point 100,0,0 }
				size { point 500,500 }
				tint { point 0.921569,0.54902,0.784314 }
				fade { point 0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
}
