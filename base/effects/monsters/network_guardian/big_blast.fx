effect effects/monsters/network_guardian/big_blast
{
	size	2525

	spawner "unnamed2"
	{
		count		100,100
		locked

		oriented
		{
			duration	0.25,1.25
			blend	add
			material	"gfx/effects/fire/fire2a"
			gravity		-0.25,-0.25
			generatedNormal

			start
			{
				position { sphere -200,-200,-200,200,200,200 }
				velocity { box 100,100,100,-100,-100,-100 }
				size { point 200,200 }
				tint { line 1,1,1,0.866667,0.537255,0.419608 }
				fade { point 0 }
				rotate { box -0.0416667,-0.0416667,-0.0416667,0.0416667,0.0416667,0.0416667 }
			}

			motion
			{
				size { envelope "convexfade" }
				tint { envelope "exp_x2" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { point 128,128 }
				tint { point 0.74902,0.74902,0.74902 }
				fade { point 1 }
			}
		}
	}
	spawner "fire up2"
	{
		count		10,15

		sprite
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fire/impact_fire"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 0,-500,-500,1000,500,500 }
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
				size { line 200,200,400,400 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
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
				size { line 200,200,400,400 }
				fade { point 1 }
				angle { box -1,-1,-1,1,1,1 relative }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	spawner "fire up3"
	{
		count		25,25

		sprite
		{
			duration	1,2
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-50,-50,0,50,50 }
				velocity { box 100,-300,-300,800,300,300 }
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
				size { line 200,200,450,450 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	spawner "ring"
	{
		count		300,300
		locked

		oriented
		{
			duration	0.25,3
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"
			generatedNormal

			start
			{
				position { sphere 0,-4,-4,0,4,4 }
				velocity { point 1600,0,0 }
				size { line 200,200,300,300 }
				tint { line 1,1,1,0.866667,0.537255,0.419608 }
				fade { point 0 }
				rotate { point 0,0,-0.0416667 }
			}

			motion
			{
				size { envelope "convexfade" }
				tint { envelope "exp_x2" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				size { line 2,2,3,3 }
				tint { point 0.752941,0.752941,0.752941 }
				fade { point 1 }
			}
		}
	}
	shake "camerashake"
	{
		duration	0.7,0.7
		scale		8
		attenuateEmitter
		attenuation	200,600
	}
	sound "unnamed18"
	{
		soundShader	"effects_explosion_fiery"
		freqshift	2,2
	}
	sound "unnamed19"
	{
		soundShader	"player_rocketlauncher_explode2"
		freqshift	0.9,0.9
	}
}




