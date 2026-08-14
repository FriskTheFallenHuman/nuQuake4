effect effects/explosions/surface/turret_exp
{
	size	608

	spawner "flash"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { line 4,4,5,5 }
				tint { point 0.705882,0.788235,0.803922 }
				offset { point 10,0,0 }
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
				size { line 150,150,200,200 }
			}
		}
	}
	spawner "fire1"
	{
		count		2,2

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/fire/fire1a"
			gravity		-0.15,-0.15

			start
			{
				position { cylinder 0,-15,-15,0,15,15 }
				velocity { box 0,0,0,50,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { point 5,5 }
				fade { point 0 }
				offset { box -5,-5,-5,5,5,5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "fastinslowout" }
				angle { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 150,150,180,180 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "smoke"
	{
		count		15,20

		sprite
		{
			duration	0.25,0.5
			material	"gfx/effects/smoke/cloud_alpha3"
			generatedOriginNormal

			start
			{
				position { sphere -50,-50,-50,50,50,50 surface }
				velocity { box 0,-100,-100,0,100,100 }
				size { line 20,20,50,50 }
				tint { point 0.286275,0.27451,0.239216 }
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
	spawner "fill"
	{
		count		5,8

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/weapons/plasma1"
			generatedOriginNormal

			start
			{
				position { sphere 0,-1,-1,0,1,1 surface }
				velocity { box 200,-200,-200,200,200,200 }
				angle { box 0,0,-1,0,0,1 }
				size { point 50,50 }
				tint { point 0.988235,0.443137,0.0392157 }
				offset { box 10,-5,-5,10,5,5 }
				rotate { box 0,1 }
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
				size { point 200,200 }
				angle { box 0,0,-0.5,0,0,0.5 }
				rotate { box -1,1 relative }
			}
		}
	}
	sound "sound"
	{
		soundShader	"vehicle_walker_cannon_impact"
	}
	sound "unnamed10"
	{
		soundShader	"player_rocketlauncher_explode2"
	}
	shake "unnamed10"
	{
		duration	1,1
		scale		0.7
		attenuateEmitter
		attenuation	500,1000
	}
	spawner "dirt_up"
	{
		start		0.2,0.2
		count		4,4

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/particles_shapes/dirt2"
			gravity		0.4,0.6
			generatedNormal

			start
			{
				position { cylinder -1,-1,-1,1,1,1 }
				velocity { box 100,-100,-100,100,100,100 }
				size { line 50,50,80,80 }
				tint { point 0.0352941,0.027451,0.0235294 }
				fade { point 0 }
				rotate { box -0.0833333,0 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "pop_hold_fadefast" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 1 }
				rotate { box -0.0833333,0.0833333 relative }
			}
		}
	}
	spawner "unnamed9"
	{
		count		1,1

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_mturret_base"
			gravity		1,1

			start
			{
				position { point 50,0,0 }
				velocity { box 200,-500,-500,200,500,500 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { point 22.2222,22.2222,22.2222 }
			}
		}
	}
	spawner "unnamed11"
	{
		count		1,1

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_mturret_sensor"
			gravity		1,1

			start
			{
				position { point 50,0,0 }
				velocity { box 300,-500,-500,300,500,500 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { point 13.8889,13.8889,13.8889 }
			}
		}
	}
	spawner "unnamed12"
	{
		count		1,1

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_mturret_barrel1"
			gravity		1,1

			start
			{
				position { point 50,0,0 }
				velocity { box 500,-500,-500,500,500,500 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { point 25,13.8889,11.1111 }
			}
		}
	}
	spawner "unnamed13"
	{
		count		1,1

		debris
		{
			duration	1,1
			persist
			entityDef	"debris_mturret_barrel2"
			gravity		1,1

			start
			{
				position { point 50,0,0 }
				velocity { box 800,-500,-500,800,500,500 }
			}

			motion
			{
				rotate { envelope "acceleratorfade" }
			}

			end
			{
				rotate { point 22.2222,22.2222,22.2222 }
			}
		}
	}
}


