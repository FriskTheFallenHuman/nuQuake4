effect effects/monsters/light_tank/miniball_fly
{
	size	37

	spawner "line"
	{
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/blaster_fly_redflipped"

			start
			{
				size { point 4.5 }
				offset { point 12,0,0 }
				length { point -20,0,0 }
			}

			motion
			{
				size { envelope "random" }
				length { envelope "random" }
			}

			end
			{
				size { point 2.5 }
				length { point -15,0,0 }
			}
		}
	}
	spawner "line2"
	{
		detail		0.5
		count		1,1
		locked
		constant

		line
		{
			duration	5,5
			material	"gfx/effects/weapons/blaster_fly_red"

			start
			{
				size { point 3 }
				length { point 10,0,0 }
			}
		}
	}
	spawner "side_streaks"
	{
		detail		0.5
		count		7,7
		locked
		constant

		line
		{
			duration	0.1,0.1
			blend	add
			material	"gfx/effects/weapons/blaster_fly_redflipped"
			generatedOriginNormal

			start
			{
				position { cylinder -0.12,-0.05,-0.05,-0.12,0.05,0.05 surface }
				size { box 2.5,4 }
				tint { point 0.466667,0.466667,0.466667 }
				fade { point 0.8 }
				offset { point 12,0,0 }
				length { box 15,0,0,20,0,0 }
			}

			motion
			{
				fade { envelope "random" }
			}

			end
			{
				fade { point 0.2 }
			}
		}
	}
	spawner "flash"
	{
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/energy_sparks/energy1_red"

			start
			{
				size { point 8,8 }
				offset { point 8,0,0 }
				rotate { box 0,0.5 }
			}

			motion
			{
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.5,1 }
			}
		}
	}
	spawner "flash2"
	{
		detail		0.5
		count		1,1
		locked
		constant

		sprite
		{
			duration	1,1
			material	"gfx/effects/weapons/flash"

			start
			{
				size { point 4,4 }
				offset { point 8,0,0 }
				rotate { box 0,0.5 }
			}

			motion
			{
				rotate { envelope "linear" }
			}

			end
			{
				rotate { box 0.5,1 }
			}
		}
	}
	emitter "trail"
	{
		duration	1,1
		count		40,40

		sprite
		{
			duration	2,2
			persist
			material	"gfx/effects/smoke/cloud_alpha"

			start
			{
				position { line 0,-2,-2,0,2,2 }
				size { line 4,4,6,6 }
				tint { line 0.584314,0.54902,0.482353,0.376471,0.376471,0.337255 }
				fade { point 0.3 }
				offset { point 3,0,0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope "concavefade" }
				tint { envelope "concavefade" }
				fade { envelope "linear" }
				rotate { envelope "linear" }
			}

			end
			{
				size { line 12,12,14,14 }
				rotate { box -0.222222,0.222222 relative }
			}
		}
	}
	sound "unnamed6"
	{
		soundShader	"player_rocketlauncher_fly"
	}
	sound "unnamed7"
	{
		soundShader	"effects_rocket_loop"
		volume	0.5,0.5
		freqshift	1.8,1.8
	}
}


