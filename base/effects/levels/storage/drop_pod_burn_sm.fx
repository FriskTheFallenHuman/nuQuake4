effect effects/levels/storage/drop_pod_burn_sm
{
	size	369

	emitter "smoke3"
	{
		duration	1,1
		count		18,18

		sprite
		{
			duration	1.5,2
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line -50,0,0,-200,0,0 }
				velocity { box 100,0,0,200,0,0 }
				size { point 25,25 }
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
				size { line 50,50,60,60 }
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
				velocity { box 50,-10,-10,400,10,10 }
				size { point 25,25 }
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
				size { point 75,75 }
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
			duration	0.6,0.8
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 0,-10,-10,0,10,10 }
				velocity { box 0,0,0,200,0,0 }
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
				size { point 50,50 }
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
			duration	1,1
			blend	add
			material	"gfx/effects/fire/fire2a"
			entityDef	"debris_walker_upperleg"

			start
			{
				position { line 150,-10,-10,150,10,10 }
				velocity { box 0,0,0,200,0,0 }
				size { point 10,10 }
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
				size { line 30,30,60,60 }
				fade { point 1 }
				rotate { box -0.555556,0.555556 }
			}
		}
	}
}
