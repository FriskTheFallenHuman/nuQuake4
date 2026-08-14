effect effects/monsters/light_tank/flame_mflash_test
{
	size	476

	emitter "smoke"
	{
		duration	1,1
		count		20,20

		sprite
		{
			duration	1,3
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				velocity { box 60,0,0,80,0,0 }
				size { point 2,2 }
				tint { line 0,0.501961,1,0.4,0.54902,0.839216 }
				rotate { box -0.25,0.25 }
			}

			motion
			{
				size { envelope concavefade }
				tint { envelope concavefade }
				fade { envelope linear }
				rotate { envelope concavefade }
			}

			end
			{
				size { box 50,50,60,60 }
				tint { point 0.643137,0.207843,0 }
				rotate { box -0.5,0.5 }
			}
		}
	}
	sound "sound"
	{
		soundShader	"lt_tank_flame_loop"
	}
	emitter "flamecore"
	{
		duration	1,1
		count		8,8
		locked

		line
		{
			duration	1,1
			material	"gfx/effects/smoke/steam_source"
			generatedNormal

			start
			{
				tint { line 1,1,1,0.623529,0.870588,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { point 5 }
				length { box 0,100,0,0,150,0 }
			}
		}
	}
	emitter "blue_fire"
	{
		duration	1,1
		count		50,50

		sprite
		{
			duration	0.8,1.2
			blend	add
			persist
			material	"gfx/effects/fire/fire2b"
			gravity		-0.02,0

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 150,-10,-10,250,10,10 }
				size { box 2,2,3,3 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope concavefade }
				tint { envelope concavefade }
				fade { envelope concavefade }
				rotate { envelope linear }
			}

			end
			{
				size { box 35,35,50,50 }
				tint { point 0.996078,0.74902,0.00392157 }
				rotate { box -0.388889,0.388889 relative }
			}
		}
	}
	emitter "main4"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	1,1
			persist
			material	"gfx/effects/smoke/cloud_alpha"
			gravity		-0.05,-0.025

			start
			{
				position { point 30,0,0 }
				velocity { box 100,-20,-20,150,20,20 }
				size { point 5,5 }
				tint { line 0.4,0.54902,0.839216,1,1,1 }
				fade { point 0.5 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "main3"
	{
		duration	1,1
		count		8,8

		sprite
		{
			duration	1,1
			blend	add
			persist
			material	"gfx/effects/fire/fire2b"

			start
			{
				position { point 30,0,0 }
				velocity { box 400,-20,-20,500,20,20 }
				friction { point -2000,0,0 }
				size { point 5,5 }
				tint { point 0.996078,0.584314,0.403922 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 200,200 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "fire2"
	{
		duration	1,1
		count		10,10

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/fire/fire1a"
			gravity		-0.02,0

			start
			{
				position { line 0,-1,-1,0,1,1 }
				velocity { box 200,-10,-10,200,10,10 }
				friction { point -200,0,0 }
				size { box 5,5,10,10 }
				fade { point 0 }
				offset { point 5,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 80,80,100,100 }
				fade { line 0.5,0.25 }
			}
		}
	}
	emitter "fire3"
	{
		duration	1,1
		count		7,7

		sprite
		{
			duration	2,2
			blend	add
			persist
			material	"gfx/effects/fire/fire2a_blue"

			start
			{
				velocity { box 150,-5,-5,200,5,5 }
				friction { box -150,0,0,-200,0,0 }
				size { box 5,5,10,10 }
				tint { line 0.501961,0.501961,1,1,1,1 }
				fade { point 0 }
				offset { point 5,0,0 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { box 100,100,150,150 }
				fade { line 0.5,0.75 }
				rotate { box -0.5,0.5 }
			}
		}
	}
	emitter "heathaze"
	{
		duration	1,1
		count		5,5

		sprite
		{
			duration	2,2
			blend	add
			material	"gfx/effects/energy_sparks/warp_mask"

			start
			{
				velocity { point 300,0,0 }
				size { point 10,10 }
			}

			motion
			{
				size { envelope concavefade }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 150,150 }
				tint { point 0.501961,0.501961,1 }
			}
		}
	}
}
