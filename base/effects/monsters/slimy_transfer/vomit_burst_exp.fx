effect effects/monsters/slimy_transfer/vomit_burst_exp
{
	size	327

	spawner "spray"
	{
		count		15,25

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/monsters/slimy_transfer/puke_drip_add"
			gravity		0.75,0.75
			trailType	burn
			trailTime	0.3,0.3
			trailCount	2,2

			start
			{
				velocity { box 80,-200,-200,250,200,200 }
				size { point 2 }
				tint { line 0.713726,0.67451,0.576471,0.776471,0.831373,0.713726 }
				fade { line 0.25,1 }
				length { point 5,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}

			impact
			{
				remove	1
			}
		}
	}
	decal "burn"
	{

		decal
		{
			duration	0.002,0.002
			material	"gfx/effects/fluids_drips/acid_burn3"

			start
			{
				size { point 60,60 }
				rotate { box -1,1 }
			}
		}
	}
	emitter "smoke"
	{
		duration	7,7
		count		5,5

		sprite
		{
			duration	0.5,1.8
			material	"gfx/effects/smoke/cloud_alpha3"
			gravity		-0.02,-0.02

			start
			{
				velocity { point 12,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 6,6,10,10 }
				tint { point 0.537255,0.619608,0.0941177 }
				fade { point 0 }
				offset { box -4,-4,-4,4,4,4 }
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
				size { line 45,45,55,55 }
				fade { point 0.35 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	emitter "bubbles2"
	{
		duration	7,7
		count		10,10

		oriented
		{
			duration	1,1
			material	"gfx/effects/fluids_drips/bubble_additive"

			start
			{
				position { sphere 1,-15,-15,1,15,15 }
				size { point 0,0 }
				tint { line 0.501961,0.501961,0,0.654902,0.74902,0.109804 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
			}

			end
			{
				size { point 2,2 }
			}
		}
	}
	spawner "mflash1"
	{
		count		10,10
		locked

		line
		{
			duration	0.5,1
			blend	add
			material	"gfx/effects/fluids_drips/stroy_spit"
			gravity		0.2,0.2

			start
			{
				position { cylinder 0.45,-0.5,-0.5,0.45,0.5,0.5 }
				velocity { box 45,-20,-20,45,20,20 }
				size { point 10 }
				tint { point 0.654902,0.74902,0.109804 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { point 22 }
				length { box 100,0,0,250,0,0 }
			}
		}
	}
	spawner "spray2"
	{
		count		10,15

		line
		{
			duration	1,1
			blend	add
			generatedLine
			material	"gfx/effects/monsters/slimy_transfer/puke_drip_add"
			gravity		0.75,0.75
			trailType	burn
			trailTime	0.2,0.2
			trailCount	3,3

			start
			{
				velocity { box 80,-200,-200,250,200,200 }
				size { point 2 }
				tint { line 0.501961,0.501961,0,0.654902,0.74902,0.109804 }
				fade { line 0.25,1 }
				length { point 5,0,0 }
			}

			motion
			{
				fade { envelope "linear" }
			}

			impact
			{
				remove	1
			}
		}
	}
	spawner "smoke2"
	{
		count		10,10

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/smoke/cloud_alpha3"

			start
			{
				velocity { box 20,-280,-280,50,280,280 }
				size { line 6,6,10,10 }
				tint { point 0.47451,0.486275,0.247059 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "cosine" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 80,80,100,100 }
				fade { point 0.5 }
				rotate { box -0.111111,0.111111 relative }
			}
		}
	}
	spawner "unnamed12"
	{
		count		10,25

		sprite
		{
			duration	1,1
			material	"gfx/effects/gore_spray/bloodhit4"
			gravity		0.25,0.5

			start
			{
				velocity { box 100,-150,-150,150,150,150 }
				size { point 20,20 }
				tint { point 0.654902,0.74902,0.109804 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { box 80,80,100,100 }
			}
		}
	}
}
