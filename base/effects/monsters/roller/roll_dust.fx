effect effects/monsters/roller/roll_dust
{
	size	474

	emitter "dust_back"
	{
		duration	1,1
		count		30,30
		locked
		attenuateEmitter

		sprite
		{
			duration	2,3
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			generatedNormal

			start
			{
				position { cylinder 0,-10,-10,0,10,10 surface }
				velocity { box 20,-50,-50,20,50,50 }
				size { point 75,75 }
				tint { line 0.290196,0.207843,0.207843,0.352941,0.309804,0.294118 }
				fade { point 0 }
				rotate { box -0.5,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 100,100,120,120 }
				fade { line 0.1,0.5 }
				rotate { box -1,-0.5 relative }
			}
		}
	}
	emitter "chunks"
	{
		duration	1,1
		count		80,80
		locked
		attenuateEmitter

		sprite
		{
			duration	1,2
			persist
			material	"gfx/effects/particles_shapes/concrete_chunks"
			gravity		1,1
			generatedOriginNormal

			start
			{
				position { cylinder 1,-1,-1,1,1,1 surface }
				velocity { box 200,0,0,500,0,0 }
				angle { box 0,0,0,1,1,1 }
				size { line 1,1,5,5 }
				tint { line 0.447059,0.466667,0.333333,0.372549,0.352941,0.239216 }
				fade { point 0 }
				offset { box 0,-20,-20,0,20,20 }
				rotate { box 0,0.5 }
			}

			motion
			{
				fade { envelope pop_hold_fadefast }
				angle { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				fade { point 0.4 }
				angle { box -0.333333,-0.333333,-0.333333,0.333333,0.333333,0.333333 relative }
				rotate { box 0.5,1 relative }
			}
		}
	}
	emitter "unnamed3"
	{
		duration	1,1
		count		50,50
		locked
		attenuateEmitter

		line
		{
			duration	0.25,0.25
			persist
			material	"gfx/effects/smoke/smoke_alpha_depth"
			generatedNormal

			start
			{
				position { cylinder 0,-0.1,-0.1,0,0.1,0.1 }
				velocity { box 150,0,0,200,0,0 }
				size { box 1,2 }
				tint { line 0.917647,0.882353,0.843137,0.807843,0.721569,0.623529 }
				fade { point 0.25 }
				length { box 30,0,0,40,0,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope linear }
				length { envelope linear }
			}

			end
			{
				size { box 4,8 }
				length { point 100,0,0 }
			}
		}
	}
	emitter "dust_trail"
	{
		duration	1,1
		count		30,30
		attenuateEmitter

		sprite
		{
			duration	2,3
			persist
			material	"gfx/effects/smoke/cloud_alpha2"
			generatedNormal

			start
			{
				position { cylinder 0,-10,-10,0,10,10 surface }
				size { box 75,75,100,100 }
				tint { line 0.290196,0.207843,0.207843,0.352941,0.309804,0.294118 }
				fade { point 0 }
				rotate { box -0.5,0 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope pop_hold_fadefast }
				rotate { envelope linear }
			}

			end
			{
				size { line 50,50,20,20 }
				fade { line 0.1,0.5 }
				rotate { box -1,-0.5 relative }
			}
		}
	}
}

