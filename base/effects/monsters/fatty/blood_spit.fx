effect effects/monsters/fatty/blood_spit
{
	size	251

	spawner "burst"
	{
		count		5,5
		locked

		sprite
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/fluids_drips/blood_spit2"

			start
			{
				velocity { box 30,-100,-100,30,100,100 }
				size { box 10,10,20,20 }
				rotate { box 0,0.194444 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { box 30,30,100,100 }
				rotate { box -0.5,0.5 relative }
			}
		}
	}
	spawner "mflash1"
	{
		count		10,10
		locked

		line
		{
			duration	0.75,0.75
			blend	add
			material	"gfx/effects/fluids_drips/blood_spit"
			generatedOriginNormal

			start
			{
				position { cylinder 0.45,-0.5,-0.5,0.45,0.5,0.5 }
				size { box 10,20 }
				tint { line 1,1,1,0.501961,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 30,50 }
				length { box 100,0,0,200,0,0 }
			}
		}
	}
	spawner "mflash2"
	{
		count		10,10
		locked

		line
		{
			duration	0.75,0.75
			material	"gfx/effects/fluids_drips/blood_spit_alpha"
			generatedOriginNormal

			start
			{
				position { cylinder 0.45,-0.5,-0.5,0.45,0.5,0.5 }
				size { box 1,5 }
				tint { line 1,1,1,0.501961,0,0 }
				length { point 10,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 15,50 }
				length { box 100,0,0,200,0,0 }
			}
		}
	}
	spawner "blood3"
	{
		count		6,6
		locked

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit1"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 20,0,0,100,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.803922,0.262745,0.105882,0.384314,0.121569,0.0509804 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 40,40,60,60 }
				fade { point 1 }
			}
		}
	}
	spawner "blood4"
	{
		count		2,2
		locked

		sprite
		{
			duration	0.6,0.8
			material	"gfx/effects/gore_spray/bloodhit2"
			gravity		0.05,0.05

			start
			{
				position { line 0,0,0,10,0,0 linearSpacing }
				velocity { box 10,0,0,50,0,0 }
				size { line 1,3,2,4 }
				tint { line 0.796079,0.294118,0.294118,0.509804,0.164706,0.0666667 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastinslowout }
			}

			end
			{
				size { line 10,10,20,20 }
				fade { point 1 }
			}
		}
	}
	spawner "mflash3"
	{
		count		2,2
		locked

		line
		{
			duration	0.75,0.75
			blend	add
			material	"gfx/effects/fluids_drips/stroy_spit"
			generatedOriginNormal

			start
			{
				position { cylinder 0.45,-0.5,-0.5,0.45,0.5,0.5 }
				size { box 10,20 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 30,50 }
				length { box 100,0,0,200,0,0 }
			}
		}
	}
	spawner "mflash4"
	{
		count		2,2
		locked

		line
		{
			duration	0.75,0.75
			material	"gfx/effects/fluids_drips/stroy_spit_alpha"
			generatedOriginNormal

			start
			{
				position { cylinder 0.45,-0.5,-0.5,0.45,0.5,0.5 }
				size { box 1,5 }
				length { point 10,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 15,50 }
				length { box 100,0,0,200,0,0 }
			}
		}
	}
}
