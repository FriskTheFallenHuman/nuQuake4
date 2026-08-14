effect effects/levels/convoy/shaft_sparks
{
	size	307

	spawner "electricty_tendricles"
	{
		count		1,1
		locked

		electricity
		{
			duration	1,1
			fork	3
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue"
			generatedOriginNormal

			start
			{
				position { point 0.05,0,0 }
				size { box 0.5,1 }
				tint { point 0,0,0 }
				fade { line 0.25,0.35 }
				length { box 350,-25,0,250,25,0 useEndOrigin }
			}

			motion
			{
				size { envelope linear_flicker }
				tint { envelope hold_drop }
				fade { envelope linear_flicker }
				length { envelope pop_flicker_fade }
			}

			end
			{
				size { box 0.12,0.25 }
				tint { point 1,1,1 }
				length { box 125,-12,0,100,12,0 useEndOrigin }
			}
		}
	}
	sound "sounds1"
	{
		soundShader	"effects_sparks03_quiet"
	}
	sound "sounds2"
	{
		soundShader	"effects_sparks02_quiet"
	}
	emitter "center2"
	{
		duration	1,1
		count		3,3
		locked

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				velocity { point 2,0,0 }
				size { line 50,50,40,40 }
				tint { point 0.239216,0.592157,0.980392 }
				fade { point 0 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope pop_flicker_fade }
				tint { envelope pop_flicker_fade }
				fade { envelope pop_flicker_fade }
			}

			end
			{
				size { line 6,6,5,5 }
				tint { point 1,1,1 }
				fade { line 1,0.5 }
			}
		}
	}
	emitter "center3"
	{
		duration	1,1
		count		5,5
		locked

		sprite
		{
			duration	0.5,0.5
			material	"gfx/effects/weapons/muzzleflash2"

			start
			{
				position { line 0,0,0,5,0,0 }
				size { line 50,50,45,45 }
				tint { point 0.501961,0,0.501961 }
				fade { line 0.06,0.12 }
				rotate { box 0,1 }
			}

			motion
			{
				size { envelope pop_flicker_fade }
				tint { envelope pop_flicker_fade }
				fade { envelope pop_flicker_fade }
			}

			end
			{
				size { line 12,12,15,15 }
				tint { point 1,1,1 }
			}
		}
	}
	spawner "electricty_MAIN"
	{
		count		1,1
		locked

		electricity
		{
			duration	1,1
			fork	0
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric"
			generatedOriginNormal

			start
			{
				position { point 0.05,0,0 }
				size { box 4,6 }
				tint { point 0,0,0 }
				fade { point 0 }
				length { point 300,0,0 }
			}

			motion
			{
				size { envelope linear_flicker }
				tint { envelope hold_drop }
				fade { envelope pop_hold_fade }
			}

			end
			{
				tint { point 1,1,1 }
				fade { point 1 }
			}
		}
	}
	emitter "electricty_tendricles2"
	{
		duration	1.5,1.5
		count		1,3
		locked

		electricity
		{
			duration	0.25,0.25
			fork	2
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_blue"
			generatedOriginNormal

			start
			{
				position { point 0.05,0,0 }
				size { box 2,1 }
				tint { point 0,0,0 }
				fade { line 0.25,0.35 }
				length { box 25,-25,-25,25,25,25 useEndOrigin }
			}

			motion
			{
				size { envelope linear_flicker }
				tint { envelope hold_drop }
				fade { envelope linear_flicker }
				length { envelope pop_flicker_fade }
			}

			end
			{
				size { box 5,7 }
				tint { point 1,1,1 }
				length { box 6,0,0,12,0,0 useEndOrigin }
			}
		}
	}
}


