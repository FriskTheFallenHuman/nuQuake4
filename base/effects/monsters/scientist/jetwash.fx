effect effects/monsters/scientist/jetwash
{
	size	62

	emitter "static"
	{
		duration	2,2
		count		10,10
		locked
		attenuateEmitter
		attenuation	500,1000

		sprite
		{
			duration	0.5,1
			material	"gfx/effects/smoke/cloud_alpha"
			generatedOriginNormal

			start
			{
				position { cylinder 0,-2,-2,10,2,2 surface }
				angle { box 0,0,-1,0,0,1 }
				size { point 0,0 attenuate }
				tint { line 1,1,0.501961,0,1,0 }
				fade { point 0.125 attenuate }
				offset { box 0,-10,-10,0,10,10 }
				rotate { box -1,1 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "sintable" offset 0.25 }
				offset { envelope "linear" }
				angle { envelope "linear" }
			}

			end
			{
				size { box 20,20,30,30 attenuate }
				fade { point 0 attenuate }
				angle { box 0,0,-1,0,0,1 relative }
			}
		}
	}
	emitter "single_streak"
	{
		detail		0.5
		duration	2,2
		count		2,4
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 3 }
				tint { line 1,1,1,0.501961,1,0 }
				fade { line 0.75,1 }
				offset { point 0,5,-4 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 3,5 }
				length { box 20,-3,-3,30,3,3 }
			}
		}
	}
	emitter "single_streak2"
	{
		detail		0.5
		duration	2,2
		count		2,4
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 3 }
				tint { line 1,1,1,0.501961,1,0 }
				fade { line 0.75,1 }
				offset { point 0,-3,-4 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 3,5 }
				length { box 20,-3,-3,30,3,3 }
			}
		}
	}
	emitter "single_streak3"
	{
		detail		0.5
		duration	2,2
		count		2,4
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 3 }
				tint { line 1,1,1,0.501961,1,0 }
				fade { line 0.75,1 }
				offset { point 0,-3,5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 3,5 }
				length { box 20,-3,-3,30,3,3 }
			}
		}
	}
	emitter "single_streak4"
	{
		detail		0.5
		duration	2,2
		count		2,4
		locked

		line
		{
			duration	0.5,0.5
			blend	add
			material	"gfx/effects/weapons/flash_half3"

			start
			{
				position { point -2,0,0 }
				size { point 3 }
				tint { line 1,1,1,0.501961,1,0 }
				fade { line 0.75,1 }
				offset { point 0,5,5 }
			}

			motion
			{
				size { envelope "linear" }
				fade { envelope "linear" }
				length { envelope "linear" }
			}

			end
			{
				size { box 3,5 }
				length { box 20,-3,-3,30,3,3 }
			}
		}
	}
	emitter "fast"
	{
		duration	2,2
		count		5,5
		locked
		attenuateEmitter
		attenuation	500,1000

		sprite
		{
			duration	1.5,1.5
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 5,0,0,10,0,0 }
				size { line 3,3,10,10 attenuate }
				tint { line 1,1,1,0,1,1 }
				fade { line 0.5,1 attenuate }
				offset { point 0,5,5 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0 attenuate }
			}
		}
	}
	emitter "fast2"
	{
		duration	2,2
		count		5,5
		locked
		attenuateEmitter
		attenuation	500,1000

		sprite
		{
			duration	1.5,1.5
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 5,0,0,10,0,0 }
				size { line 3,3,10,10 attenuate }
				tint { line 1,1,1,0,1,1 }
				fade { line 0.5,1 attenuate }
				offset { point 0,-3,5 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0 attenuate }
			}
		}
	}
	emitter "fast3"
	{
		duration	2,2
		count		5,5
		locked
		attenuateEmitter
		attenuation	500,1000

		sprite
		{
			duration	1.5,1.5
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 5,0,0,10,0,0 }
				size { line 3,3,10,10 attenuate }
				tint { line 1,1,1,0,1,1 }
				fade { line 0.5,1 attenuate }
				offset { point 0,-3,-4 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0 attenuate }
			}
		}
	}
	emitter "fast4"
	{
		duration	2,2
		count		5,5
		locked
		attenuateEmitter
		attenuation	500,1000

		sprite
		{
			duration	1.5,1.5
			blend	add
			material	"gfx/effects/fire/fire_plume_additive"

			start
			{
				position { cylinder 0,-0.5,-0.5,0,0.5,0.5 }
				velocity { box 5,0,0,10,0,0 }
				size { line 3,3,10,10 attenuate }
				tint { line 1,1,1,0,1,1 }
				fade { line 0.5,1 attenuate }
				offset { point 0,5,-4 }
				rotate { box -1,1 }
			}

			motion
			{
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				fade { point 0 attenuate }
			}
		}
	}
}

