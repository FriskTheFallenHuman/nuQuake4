effect effects/monsters/hornet/napalm
{
	size	1186

	sound "unnamed18"
	{
		soundShader	"effects_hornet_napalm_explosion"
		volume	3,3
		freqshift	1.5,1.5
	}
	decal "scorch"
	{

		decal
		{
			duration	0.002,0.002
			material	"textures/decals/rocketburn"
			entityDef	"debris_walker_upperleg"

			start
			{
				size { point 150,0 }
				rotate { box 0,1 }
			}
		}
	}
	spawner "smoke5"
	{
		count		2,2

		sprite
		{
			duration	5,5
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line -50,-50,-50,50,50,50 }
				velocity { box 0,-50,-50,250,50,50 }
				friction { point 20,0,0 }
				size { line 20,20,50,50 }
				tint { line 0.486275,0.486275,0.486275,0.501961,0.501961,0.501961 }
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
				size { line 400,400,500,500 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	spawner "fire up2"
	{
		count		5,5

		sprite
		{
			duration	1,5
			blend	add
			material	"gfx/effects/fire/fire3a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 0,-25,-25,0,25,25 }
				size { point 0,0 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
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
				size { line 300,300,550,550 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "fire2"
	{
		count		2,2

		sprite
		{
			duration	0.25,0.25
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_walker_upperleg"
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
				size { line 400,400,500,500 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "fire up3"
	{
		count		5,5

		sprite
		{
			duration	2,3
			blend	add
			material	"gfx/effects/fire/fire4a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 0,-150,-150,100,150,150 }
				size { point 0,0 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
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
				size { line 200,200,250,250 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "ring"
	{
		count		2,2

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/energy_sparks/launch_flash4"
			entityDef	"debris_walker_upperleg"

			start
			{
				size { point 2,2 }
				tint { point 1,0.501961,0.247059 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 500,500 }
			}
		}
	}
	spawner "fire up4"
	{
		count		8,8

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/fire/fire1a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 100,-200,-200,300,200,200 }
				size { point 0,0 }
				tint { line 1,1,1,0.501961,0.501961,0.501961 }
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
				size { line 250,250,300,300 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
}


