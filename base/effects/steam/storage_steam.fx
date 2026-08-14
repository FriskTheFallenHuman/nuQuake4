effect effects/steam/storage_steam
{
	size	588

	spawner "steam5"
	{
		count		14,14

		sprite
		{
			duration	1.5,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			gravity		0.125,0.125

			start
			{
				position { line 0,-180,125,0,180,125 cone }
				velocity { box 30,-10,-10,200,10,10 }
				size { box 5,5,10,10 }
				tint { line 1,1,1,0.521569,0.541176,0.654902 }
				fade { line 0.35,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,250,250 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "steam6"
	{
		duration	0.25,0.25
		count		20,20

		sprite
		{
			duration	1.5,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0.125,0.125

			start
			{
				position { line 0,-180,125,0,180,125 cone }
				velocity { box 100,-10,-10,250,10,10 }
				size { box 30,30,40,40 }
				tint { line 1,1,1,0.713726,0.729412,0.796079 }
				fade { line 0.35,0.75 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,70,70 }
				rotate { point 0 relative }
			}
		}
	}
	emitter "unnamed4"
	{
		duration	1,1
		count		20,20

		line
		{
			duration	0.25,0.25
			material	"gfx/effects/smoke/cloud_alpha2"

			start
			{
				position { line 0,-170,125,0,170,125 }
				size { box 1,3 }
				fade { line 0.35,0.5 }
				length { point 10,0,0 }
			}

			motion
			{
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				length { box 180,0,0,250,0,0 }
			}
		}
	}
	spawner "steam7"
	{
		count		25,25

		sprite
		{
			duration	0.25,1.5
			persist
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		0.125,0.125

			start
			{
				position { line 0,-170,125,0,170,125 cone }
				velocity { box 0,0,0,150,0,0 }
				size { box 30,30,40,40 }
				tint { line 1,1,1,0.537255,0.564706,0.67451 }
				fade { point 0.5 }
				offset { point 90,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { line 200,200,250,250 }
				rotate { point 0 relative }
			}
		}
	}
}


