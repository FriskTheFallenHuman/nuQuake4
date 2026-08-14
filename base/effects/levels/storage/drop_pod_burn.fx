effect effects/levels/storage/drop_pod_burn
{
	size	1525

	emitter "smoke3"
	{
		duration	1,1
		count		18,18

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line -50,0,0,-200,0,0 }
				velocity { box 1350,0,0,1500,0,0 }
				size { point 50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
				offset { point -25,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope fastinslowout }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,150,150 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	emitter "smoke6"
	{
		duration	1,1
		count		18,18

		sprite
		{
			duration	1.5,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			entityDef	"debris_walker_upperleg"

			start
			{
				velocity { box 900,-10,-10,1200,10,10 }
				size { point 50,50 }
				tint { line 0.286275,0.27451,0.239216,0.309804,0.258824,0.2 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope fastinslowout }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 150,150 }
				fade { point 1 }
				rotate { box -0.222222,0.222222 }
			}
		}
	}
	emitter "fire up3"
	{
		duration	1,1
		count		40,40

		sprite
		{
			duration	0.8,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-10,-10,0,10,10 }
				velocity { box 600,0,0,1500,0,0 }
				size { point 0,0 }
				tint { line 1,1,1,0.752941,0.752941,0.752941 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope fastinslowout }
				tint { envelope linear }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { point 150,150 }
				fade { point 1 }
				rotate { box -0.277778,0.277778 }
			}
		}
	}
	emitter "fire up4"
	{
		duration	1,1
		count		40,40

		sprite
		{
			duration	1,1.5
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-10,-10,0,10,10 }
				velocity { box 500,0,0,600,0,0 }
				size { point 0,0 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope fastinslowout }
				fade { envelope fastinslowout }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,80,80 }
				fade { point 1 }
				rotate { box -0.555556,0.555556 }
			}
		}
	}
	spawner "flash2"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 50,0,0 }
				size { point 300,300 }
				tint { point 0.752941,0.752941,0.752941 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope random }
				rotate { envelope linear }
			}

			end
			{
				size { point 200,200 }
				rotate { point 1 relative }
			}
		}
	}
}

