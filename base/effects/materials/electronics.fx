effect effects/materials/electronics
{
	size	761

	spawner "sparks_physics"
	{
		count		2,5

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/blue_spark"
			gravity		1,1.5

			start
			{
				position { point 1,0,0 }
				velocity { box 300,-200,-200,500,200,200 }
				size { box 2,2,1,1 }
			}

			motion
			{
				size { envelope random }
				tint { envelope linear }
			}

			end
			{
				size { box 6,6,4,4 }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	light "light"
	{
		locked

		light
		{
			duration	0.12,0.12
			shadows
			material	"lights/defaultPointLight"

			start
			{
				position { point 10,0,0 }
				size { point 50,50,50 }
				tint { point 0,0,0 }
			}

			motion
			{
				tint { envelope pop_fade }
			}

			end
			{
				tint { point 0.478431,0.235294,0.984314 }
			}
		}
	}
	spawner "spike"
	{
		count		3,3

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { point 0.5,0,0 }
				size { point 18,18 }
				fade { line 0.2,1 }
			}

			motion
			{
				size { envelope pop_fade }
				tint { envelope linear }
				fade { envelope fastfadein_fadeout }
				rotate { envelope linear }
			}

			end
			{
				size { point 20,20 }
			}
		}
	}
	spawner "center"
	{
		count		3,3
		locked

		oriented
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 1,0,0 }
				fade { line 0.2,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastfadein_fadeout }
				rotate { envelope linear }
			}

			end
			{
				size { point 3,3 }
			}
		}
	}
	spawner "electricty"
	{
		count		1,1

		electricity
		{
			duration	0.12,0.25
			fork	4
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_multicolor"

			start
			{
				position { cylinder 0.05,-0.05,-0.05,0.05,0.05,0.05 }
				size { box 4,1 }
				tint { point 0,0,0 }
				length { box 1,-1,-1,2,1,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope popoverextreme_hold_fade }
				length { envelope popoverextreme_hold_grow }
			}

			end
			{
				size { point 0.25 }
				tint { point 1,1,1 }
				length { box 25,-25,-25,25,25,25 }
			}
		}
	}
	sound "sounds"
	{
		soundShader	"effects_sparks02"
	}
	spawner "electricty2"
	{
		count		1,1

		electricity
		{
			duration	0.12,0.25
			fork	4
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_multicolor"

			start
			{
				position { cylinder 0.05,-0.05,-0.05,0.05,0.05,0.05 }
				size { box 4,1 }
				tint { point 0,0,0 }
				length { box 1,-1,-1,0.5,1,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope popoverextreme_hold_fade }
				length { envelope popoverextreme_hold_grow }
			}

			end
			{
				size { point 11 }
				tint { point 1,1,1 }
				length { box 3,-10,-10,3,10,10 }
			}
		}
	}
	spawner "sparks_physics_delay1"
	{
		start		1,1
		count		2,5

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/blue_spark"
			gravity		1,1.5

			start
			{
				position { point 1,0,0 }
				velocity { box 300,-200,-200,500,200,200 }
				size { box 2,2,1,1 }
			}

			motion
			{
				size { envelope random }
				tint { envelope linear }
			}

			end
			{
				size { box 6,6,4,4 }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	light "light_delay1"
	{
		start		1,1
		locked

		light
		{
			duration	0.12,0.12
			shadows
			material	"lights/defaultPointLight"

			start
			{
				position { point 10,0,0 }
				size { point 50,50,50 }
				tint { point 0,0,0 }
			}

			motion
			{
				tint { envelope pop_fade }
			}

			end
			{
				tint { point 0.478431,0.235294,0.984314 }
			}
		}
	}
	spawner "spike_delay1"
	{
		start		1,1
		count		3,3

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { point 0.5,0,0 }
				size { point 18,18 }
				fade { line 0.2,1 }
			}

			motion
			{
				size { envelope pop_fade }
				tint { envelope linear }
				fade { envelope fastfadein_fadeout }
				rotate { envelope linear }
			}

			end
			{
				size { point 20,20 }
			}
		}
	}
	spawner "center_delay1"
	{
		start		1,1
		count		3,3
		locked

		oriented
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 1,0,0 }
				fade { line 0.2,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastfadein_fadeout }
				rotate { envelope linear }
			}

			end
			{
				size { point 3,3 }
			}
		}
	}
	spawner "electricty_delay1"
	{
		start		1,1
		count		1,1

		electricity
		{
			duration	0.12,0.25
			fork	4
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_multicolor"

			start
			{
				position { cylinder 0.05,-0.05,-0.05,0.05,0.05,0.05 }
				size { box 4,1 }
				tint { point 0,0,0 }
				length { box 1,-1,-1,2,1,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope popoverextreme_hold_fade }
				length { envelope popoverextreme_hold_grow }
			}

			end
			{
				size { point 0.25 }
				tint { point 1,1,1 }
				length { box 25,-25,-25,25,25,25 }
			}
		}
	}
	sound "sounds_delay1"
	{
		start		1,1
		soundShader	"effects_sparks02"
	}
	spawner "electricty2_delay1"
	{
		start		1,1
		count		1,1

		electricity
		{
			duration	0.12,0.25
			fork	4
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_multicolor"

			start
			{
				position { cylinder 0.05,-0.05,-0.05,0.05,0.05,0.05 }
				size { box 4,1 }
				tint { point 0,0,0 }
				length { box 1,-1,-1,0.5,1,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope popoverextreme_hold_fade }
				length { envelope popoverextreme_hold_grow }
			}

			end
			{
				size { point 11 }
				tint { point 1,1,1 }
				length { box 3,-10,-10,3,10,10 }
			}
		}
	}
	spawner "sparks_physics_delay2"
	{
		start		3,3
		count		2,5

		sprite
		{
			duration	1,3
			blend	add
			material	"gfx/effects/weapons/blue_spark"
			gravity		1,1.5

			start
			{
				position { point 1,0,0 }
				velocity { box 300,-200,-200,500,200,200 }
				size { box 2,2,1,1 }
			}

			motion
			{
				size { envelope random }
				tint { envelope linear }
			}

			end
			{
				size { box 6,6,4,4 }
			}

			impact
			{
				bounce	0.4
			}
		}
	}
	light "light_delay2"
	{
		start		3,3
		locked

		light
		{
			duration	0.12,0.12
			shadows
			material	"lights/defaultPointLight"

			start
			{
				position { point 10,0,0 }
				size { point 50,50,50 }
				tint { point 0,0,0 }
			}

			motion
			{
				tint { envelope pop_fade }
			}

			end
			{
				tint { point 0.478431,0.235294,0.984314 }
			}
		}
	}
	spawner "spike_delay2"
	{
		start		3,3
		count		3,3

		oriented
		{
			duration	0.2,0.2
			blend	add
			material	"gfx/effects/particles_shapes/spike"

			start
			{
				position { point 0.5,0,0 }
				size { point 18,18 }
				fade { line 0.2,1 }
			}

			motion
			{
				size { envelope pop_fade }
				tint { envelope linear }
				fade { envelope fastfadein_fadeout }
				rotate { envelope linear }
			}

			end
			{
				size { point 20,20 }
			}
		}
	}
	spawner "center_delay2"
	{
		start		3,3
		count		3,3
		locked

		oriented
		{
			duration	0.12,0.12
			blend	add
			material	"gfx/effects/weapons/flash"

			start
			{
				position { point 1,0,0 }
				fade { line 0.2,1 }
			}

			motion
			{
				size { envelope linear }
				fade { envelope fastfadein_fadeout }
				rotate { envelope linear }
			}

			end
			{
				size { point 3,3 }
			}
		}
	}
	spawner "electricty_delay2"
	{
		start		3,3
		count		1,1

		electricity
		{
			duration	0.12,0.25
			fork	4
			jitterRate	0
			jitterSize	3,7,7
			material	"gfx/effects/electricity/electric_multicolor"

			start
			{
				position { cylinder 0.05,-0.05,-0.05,0.05,0.05,0.05 }
				size { box 4,1 }
				tint { point 0,0,0 }
				length { box 1,-1,-1,2,1,1 }
			}

			motion
			{
				size { envelope linear }
				tint { envelope popoverextreme_hold_fade }
				length { envelope popoverextreme_hold_grow }
			}

			end
			{
				size { point 0.25 }
				tint { point 1,1,1 }
				length { box 15,-15,-15,15,15,15 }
			}
		}
	}
	sound "sounds_delay2"
	{
		start		3,3
		soundShader	"effects_sparks02"
	}
}


