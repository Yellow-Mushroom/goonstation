// actually this is the real view width / height + 4 because byond keeps rendering one tile further in each direction I think
// it defines how far the parallax anchors are spread
#define PARALLAX_VIEW_WIDTH (WIDE_TILE_WIDTH + 4)
#define PARALLAX_VIEW_HEIGHT (SQUARE_TILE_WIDTH + 4)

var/datum/controller/parallax_controller/parallax_controller = new

/datum/controller/parallax_controller
	var/list/obj/effect/parallax/parallax_objects = list(
		new /obj/effect/parallax(null, 1, 3, PLANE_PARALLAX_PLANET),
		new /obj/effect/parallax(null, 2, 4, PLANE_PARALLAX_PLANET - 1),
		new /obj/effect/parallax(null, 3, 5, PLANE_PARALLAX_PLANET - 2),
		new /obj/effect/parallax(null, 4, 7, PLANE_PARALLAX_PLANET - 3)
	)

	proc/get_planet_parallax()
		RETURN_TYPE(/obj/effect/parallax)
		return length(parallax_objects) ? parallax_objects[1] : null

	proc/initialize(add_random_bg_objects=FALSE)
		for(var/obj/effect/parallax/par in src.parallax_objects)
			if(par.plane == PLANE_PARALLAX_PLANET)
				if(add_random_bg_objects)
					for(var/obj_type in typesof(/obj/effects/background_objects)) // TODO remove this and just keep already placed planets
						var/obj/O = new obj_type()
						O.pixel_x = rand(round(((world.maxx - 1) / par.scale + (PARALLAX_VIEW_WIDTH - 4)) * world.icon_size)) * par.scale
						O.pixel_y = rand(round(((world.maxy - 1) / par.scale + (PARALLAX_VIEW_HEIGHT - 4)) * world.icon_size)) * par.scale
						O.pixel_x -= 32 * 3 // center the icon TODO use icon operations to get Width / Height properly
						O.pixel_y -= 32 * 3
						par.vis_contents += O
			else
				var/icon/stars = icon('icons/effects/1x1.dmi', "empty") // just an empty pixel, we'll scale it up later
				var/maxx = round(((world.maxx - 1) / par.scale + (PARALLAX_VIEW_WIDTH - 4)) * world.icon_size)
				var/maxy = round(((world.maxy - 1) / par.scale + (PARALLAX_VIEW_HEIGHT - 4)) * world.icon_size)
				stars.Crop(1, 1, maxx, maxy)
				par.pixel_x = maxx * ((par.scale - 1) /2) // centering
				par.pixel_y = maxy * ((par.scale - 1) /2)
				for(var/j in 1 to 1500)
					var/x = rand(maxx)
					var/y = rand(maxy)
					var/color = rgb(rand(200, 255), rand(200, 255), rand(200, 255))
					if(prob(70)) // 1 px star
						stars.DrawBox(color, x, y)
					else if(prob(70)) // 2x2 px square star
						stars.DrawBox(color, x, y, x + 1, y + 1)
					else // tiny cross star
						stars.DrawBox(color, x - 1, y, x + 1, y)
						stars.DrawBox(color, x, y - 1, x, y + 1)
				par.icon = stars

			par.color = rgb(255 - par.id * 30, 255 - par.id * 30, 255 - par.id * 30) // makes the planes further in the back darker

			for(var/x = 1; x <= world.maxx + PARALLAX_VIEW_WIDTH; x += PARALLAX_VIEW_WIDTH)
				for(var/y = 1; y <= world.maxy + PARALLAX_VIEW_HEIGHT; y += PARALLAX_VIEW_HEIGHT)
					var/turf/T = locate(min(world.maxx, x), min(world.maxy, y), 1)
					var/obj/effect/anchor = new
					anchor.mouse_opacity = FALSE
					anchor.vis_contents += par
					anchor.pixel_x = -(T.x - 1) * 32 // aligns the "anchor objects"
					anchor.pixel_y = -(T.y - 1) * 32
					T.vis_contents += anchor


/obj/effect/parallax
	mouse_opacity = FALSE
	var/scale
	var/id

	New(loc, id, scale, plane)
		// don't use 6, 18 for scale; those numbers ~~are cursed~~ cause scaling artifacts
		..()
		src.id = id
		src.plane = plane
		src.scale = scale
		src.transform = matrix(src.scale, MATRIX_SCALE)

	proc/make_parallax_plane()
		var/obj/screen/plane_parent/pl = new/obj/screen/plane_parent(src.plane, PIXEL_SCALE, BLEND_DEFAULT, null, FALSE, "parallax plane [src.id]", FALSE)
		pl.transform = matrix(1/src.scale, 0, -((PARALLAX_VIEW_WIDTH - 4 - 1/src.scale)/2)*32, 0, 1/src.scale, -((PARALLAX_VIEW_HEIGHT - 4 - 1/src.scale)/2)*32)
		return pl


#ifdef PARALLAX_ENABLED
/obj/effects/background_objects/New(loc)
	..()
	if(!isnull(loc))
		var/obj/effect/parallax/parallax = parallax_controller.get_planet_parallax()
		parallax.vis_contents += src
		src.pixel_x = (src.x / parallax.scale + (PARALLAX_VIEW_WIDTH - 4)) * world.icon_size * parallax.scale
		src.pixel_y = (src.y / parallax.scale + (PARALLAX_VIEW_HEIGHT - 4)) * world.icon_size * parallax.scale
		src.set_loc(null)
#endif

#undef PARALLAX_VIEW_WIDTH
#undef PARALLAX_VIEW_HEIGHT
