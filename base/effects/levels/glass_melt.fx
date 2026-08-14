effect effects/levels/glass_melt
{
	size	991

	emitter "fire"
	{
		duration	5,6
		count		12,12

		oriented
		{
			duration	1,1
			blend	add
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				position { point 1,0,0 }
				size { point 50,50 }
				tint { line 1,1,1,0,0.501961,0.501961 }
				fade { point 0.5 }
				rotate { box 0,0,-1,0,0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 700,700 }
			}
		}
	}
	emitter "unnamed1"
	{
		duration	5,5
		count		5,10

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				velocity { box 0,0,0,100,0,0 }
				size { point 50,50 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "linear" }
				offset { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
				offset { box 0,-200,-200,0,200,200 }
			}
		}
	}
	emitter "unnamed2"
	{
		duration	5,6
		count		10,20

		sprite
		{
			duration	1,2
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				velocity { box 0,0,0,250,0,0 }
				size { point 100,100 }
				offset { box 0,-200,-200,0,200,200 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				tint { envelope "linear" }
				fade { envelope "cosine" offset 0.5 }
				offset { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { point 200,200 }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	3,3
		count		5,5

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				size { point 2,2 }
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
	emitter "unnamed4"
	{
		duration	3,3
		count		5,5

		oriented
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/mgun_muzzleflash"

			start
			{
				position { point 1,0,0 }
				size { point 2,2 }
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
	emitter "embers"
	{
		duration	5,5
		count		20,50

		sprite
		{
			duration	1,1
			blend	add
			material	"gfx/effects/energy_sparks/spark3"
			gravity		1,1

			start
			{
				position { cylinder 0,-150,-150,0,150,150 }
				velocity { box 200,-5,-5,500,5,5 }
				size { line 2,2,9,9 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				tint { envelope "linear" }
				fade { envelope "fastinslowout" }
			}

			end
			{
				fade { point 1 }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"effects_fire_build"
	}
	sound "unnamed7"
	{
		start		1,1
		soundShader	"effects_fire_blast"
		freqshift	0.6,0.6
	}
	sound "unnamed8"
	{
		soundShader	"effects_explosion_fiery"
		freqshift	0.8,0.8
	}
	sound "unnamed9"
	{
		soundShader	"glass_break_medlabs_tube"
	}
	sound "unnamed10"
	{
		soundShader	"glass_break_big"
		freqshift	0.1,0.1
	}
	sound "unnamed11"
	{
		start		2.9,2.9
		soundShader	"effects_fire_whoosh"
		volume	1.6,1.6
		freqshift	0.7,0.7
	}
}








