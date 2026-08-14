effect effects/vehicles/walker/rocket/impact
{
	size	850

	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	sound "unnamed15"
	{
		soundShader	"player_grenadelauncher_explode"
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		scale		1
		attenuateEmitter
		attenuation	200,600
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"

			start
			{
				size { point 100,0 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "darksmoke2"
	{
		start		0.2,0.2
		count		3,3

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/smoke_dark"
			gravity		-0.04,-0.04

			start
			{
				position { sphere 40,-100,-100,100,100,100 }
				velocity { box 0,-10,-10,20,10,10 }
				size { line 60,60,80,80 }
				tint { point 0.529412,0.521569,0.470588 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 180,180,200,200 }
				fade { point 0.6 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "sparks_lines2"
	{
		count		9,12
		locked

		line
		{
			duration	0.2,0.2
			blend	add
			generatedLine
			material	"gfx/effects/energy_sparks/spark_line2"
			generatedOriginNormal
			flipNormal

			start
			{
				position { cylinder -0.1,-0.1,-0.1,-0.1,0.1,0.1 surface }
				velocity { point 1,0,0 }
				size { box 12,20 }
				tint { line 1,0.921569,0.701961,0.74902,0.521569,0.203922 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "exp_x2" }
				length { envelope "linear" }
			}

			end
			{
				tint { line 0.956863,0.658824,0.529412,0.956863,0.639216,0.529412 }
				length { box 300,0,0,350,0,0 }
			}
		}
	}
	spawner "fire2"
	{
		count		4,4

		sprite
		{
			duration	0.35,0.35
			material	"gfx/effects/fire/fire1a"
			generatedOriginNormal

			start
			{
				position { cylinder 0.1,-0.1,-0.1,0.1,0.1,0.1 surface linearSpacing }
				velocity { box 80,0,0,120,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 140,140,150,150 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 220,220,250,250 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "fire3"
	{
		count		4,4

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/fire/fire3a"

			start
			{
				position { line 0,0,0,150,0,0 linearSpacing }
				velocity { box 80,0,0,120,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { box 140,140,150,150 }
				offset { box -2,-2,-2,2,2,2 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "exp_x2" }
				fade { envelope "linear" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 220,220,250,250 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "flash3"
	{
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/flash"
			generatedNormal

			start
			{
				position { point 1,0,0 }
				size { line 340,340,360,360 }
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
				size { point 140,140 }
			}
		}
	}
	emitter "deform2"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.35,0.35
			blend	add
			material	"gfx/effects/energy_sparks/explosion_deform_grenade"

			start
			{
				size { point 0,0 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 600,600 }
			}
		}
	}
	emitter "deform3"
	{
		duration	1,1
		count		1,1

		oriented
		{
			duration	0.35,0.35
			material	"gfx/effects/energy_sparks/explosion_deform_grenade"

			start
			{
				position { point 1,0,0 }
			}

			motion
			{
				size { envelope "linear" }
			}

			end
			{
				size { point 600,600 }
			}
		}
	}
}





