effect effects/smoke/skybox_pillar1
{
	size	151

	emitter "Pillar2"
	{
		duration	10,10
		count		0.3,0.3

		sprite
		{
			duration	35,35
			material	"gfx/effects/smoke/cloud_alpha3"
			generatedOriginNormal

			start
			{
				position { cylinder 0.08,0.01,0.01,0.08,-0.01,-0.01 }
				velocity { point 5,0,0 }
				size { box 8,8,10,10 }
				tint { line 0.133333,0.129412,0.101961,0.176471,0.117647,0.0745098 }
				offset { box 0,-0.5,-0.5,0,0.5,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope exp_x2 }
				offset { envelope linear }
				angle { envelope sintable }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				tint { point 0.101961,0.0941177,0.0823529 }
				offset { box 0,-2,-2,0,2,2 }
				angle { box 0,0,1,0,0,0.833333 }
				rotate { box -2,2 relative }
			}
		}
	}
	emitter "Pillar"
	{
		duration	10,10
		count		0.3,0.3

		sprite
		{
			duration	35,35
			material	"gfx/effects/smoke/cloud_alpha2"
			generatedOriginNormal

			start
			{
				position { cylinder 0.08,0.01,0.01,0.08,-0.01,-0.01 }
				velocity { point 5,0,0 }
				size { box 8,8,10,10 }
				tint { line 0.309804,0.235294,0.168627,0.576471,0.388235,0.25098 }
				offset { box 0,-0.5,-0.5,0,0.5,0.5 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope exp_x2 }
				offset { envelope linear }
				angle { envelope sintable }
				rotate { envelope linear }
			}

			end
			{
				size { point 50,50 }
				tint { point 0.12549,0.113725,0.0823529 }
				offset { box 0,-2,-2,0,2,2 }
				angle { box 0,0,1,0,0,0.833333 }
				rotate { box -2,2 relative }
			}
		}
	}
}
