effect effects/monsters/turret/f_flash
{
	size	154

	emitter "segment00"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { point 20,-5,15 }
				size { point 50,50 }
				tint { point 0.509804,0.254902,0 }
				rotate { point 0.05 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	spawner "segment01"
	{
		count		1,1

		sprite
		{
			duration	0.3,0.3
			material	"gfx/effects/weapons/flash"
			generatedOriginNormal

			start
			{
				position { point 20,-5,10 }
				size { point 10,10 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				fade { envelope linear }
			}

			end
			{
				size { point 50,50 }
			}
		}
	}
	sound "segment02"
	{
		soundShader	"turret_network_fire"
	}
	emitter "segment03"
	{
		duration	1,1
		count		1,1

		sprite
		{
			duration	0.25,0.25
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { point 20,-5,15 }
				size { point 50,50 }
				tint { point 0.509804,0.254902,0 }
				rotate { point -0.05 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope linear }
				rotate { envelope linear }
			}

			end
			{
				size { point 100,100 }
			}
		}
	}
	sound "unnamed4"
	{
		soundShader	"turret_generic_fire"
	}
}



