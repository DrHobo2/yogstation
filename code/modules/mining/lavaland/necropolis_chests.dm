//The chests dropped by mob spawner tendrils. Also contains associated loot.

/obj/structure/closet/crate/necropolis
	name = "necropolis chest"
	desc = "It's watching you closely."
	icon_state = "necrocrate"

/obj/structure/closet/crate/necropolis/tendril
	desc = "It's watching you suspiciously."

/obj/structure/closet/crate/necropolis/tendril/New()
	..()
	var/loot = rand(1,23)
	switch(loot)
		if(1)
			new /obj/item/device/shared_storage/red(src)
		if(2)
			new /obj/item/clothing/suit/space/hardsuit/cult(src)
		if(3)
			new /obj/item/device/necromantic_stone/lesser(src)
		if(4)
			new /obj/item/weapon/katana/cursed(src)
		if(5)
			new /obj/item/clothing/glasses/godeye(src)
		if(6)
			new /obj/item/weapon/wingpotion(src)
		if(7)
			new /obj/item/weapon/pickaxe/drill/jackhammer(src)
		if(8)
			new /obj/item/weapon/melee/cultblade/dagger(src)
			new /obj/item/weapon/restraints/legcuffs/bola/cult(src)
			new /obj/item/weapon/bedsheet/cult(src)
			new /obj/item/clothing/suit/magusred(src)
			new /obj/item/clothing/head/magus(src)
		if(9)
			new /obj/item/weapon/rune_scimmy(src)
		if(10)
			new /obj/item/ship_in_a_bottle(src)
		if(11)
			new /obj/item/clothing/suit/space/hardsuit/ert/paranormal/beserker(src)
		if(12)
			new /obj/item/weapon/nullrod/scythe/talking(src)
			new /obj/item/weapon/reagent_containers/food/drinks/bottle/holywater/godblood(src)
		if(13)
			new /obj/item/weapon/reagent_containers/glass/bottle/self_fill(src)
		if(14)
			new /obj/item/weapon/guardiancreator(src)
		if(15)
			new /obj/item/device/warp_cube/red(src)
		if(16)
			new /obj/item/device/wisp_lantern(src)
		if(17)
			new /obj/item/device/immortality_talisman(src)
		if(18)
			new /obj/item/weapon/gun/magic/hook(src)
		if(19)
			new /obj/item/voodoo(src)
		if(20)
			new /obj/item/weapon/melee/energy/sword/pirate(src)
			new /obj/item/clothing/suit/space/pirate(src)
			new /obj/item/clothing/head/helmet/space/pirate(src)
		if(21)
			new /obj/item/weapon/reagent_containers/food/drinks/bottle/holywater/hell(src)
			new /obj/item/clothing/suit/space/hardsuit/ert/paranormal/inquisitor(src)
		if(22)
			new /obj/item/weapon/spellbook/oneuse/summonitem(src)
		if(23)
			new /obj/item/organ/heart/cursed/wizard(src)


//Spooky special loot

/obj/item/device/wisp_lantern
	name = "spooky lantern"
	desc = "This lantern gives off no light, but is home to a friendly wisp."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "lantern-blue"
	var/obj/effect/wisp/wisp

/obj/item/device/wisp_lantern/attack_self(mob/user)
	if(!wisp)
		user << "<span class='warning'>The wisp has gone missing!</span>"
		return
	if(wisp.loc == src)
		user << "<span class='notice'>You release the wisp. It begins to \
			bob around your head.</span>"
		user.sight |= SEE_MOBS
		icon_state = "lantern"
		wisp.orbit(user, 20)
		feedback_add_details("wisp_lantern","F") // freed

	else
		user << "<span class='notice'>You return the wisp to the lantern.\
			</span>"

		if(wisp.orbiting)
			var/atom/A = wisp.orbiting
			if(istype(A, /mob/living))
				var/mob/living/M = A
				M.sight &= ~SEE_MOBS
				M << "<span class='notice'>Your vision returns to \
					normal.</span>"

		wisp.stop_orbit()
		wisp.loc = src
		icon_state = "lantern-blue"
		feedback_add_details("wisp_lantern","R") // returned

/obj/item/device/wisp_lantern/New()
	..()
	wisp = new(src)

/obj/item/device/wisp_lantern/Destroy()
	if(wisp)
		if(wisp.loc == src)
			qdel(wisp)
		else
			wisp.visible_message("<span class='notice'>[wisp] has a sad \
				feeling for a moment, then it passes.</span>")
	..()

//Wisp Lantern
/obj/effect/wisp
	name = "friendly wisp"
	desc = "Happy to light your way."
	icon = 'icons/obj/lighting.dmi'
	icon_state = "orb"
	luminosity = 9
	layer = ABOVE_ALL_MOB_LAYER
	burn_state = LAVA_PROOF

/obj/item/device/warp_cube
	name = "blue cube"
	desc = "A mysterious blue cube."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "blue_cube"
	var/obj/item/device/warp_cube/linked


//Red/Blue Cubes

/obj/item/device/warp_cube/attack_self(mob/user)
	if(!linked)
		user << "[src] fizzles uselessly."
	if(linked.z == CENTCOMM)
		user << "[linked] is somewhere you can't go."

	PoolOrNew(/obj/effect/particle_effect/smoke, user.loc)
	user.forceMove(get_turf(linked))
	feedback_add_details("warp_cube","[src.type]")
	PoolOrNew(/obj/effect/particle_effect/smoke, user.loc)

/obj/item/device/warp_cube/red
	name = "red cube"
	desc = "A mysterious red cube."
	icon_state = "red_cube"

/obj/item/device/warp_cube/red/New()
	..()
	if(!linked)
		var/obj/item/device/warp_cube/blue = new(src.loc)
		linked = blue
		blue.linked = src

//Meat Hook
/obj/item/weapon/gun/magic/hook
	name = "meat hook"
	desc = "Mid or feed."
	ammo_type = /obj/item/ammo_casing/magic/hook
	icon_state = "hook"
	item_state = "chain"
	fire_sound = 'sound/weapons/meathook_fire.ogg'
	max_charges = 1
	flags = NOBLUDGEON
	force = 18

/obj/item/ammo_casing/magic/hook
	name = "hook"
	desc = "a hook."
	projectile_type = /obj/item/projectile/hook
	caliber = "hook"
	icon_state = "hook"

/obj/item/projectile/hook
	name = "hook"
	icon_state = "hook"
	icon = 'icons/obj/lavaland/artefacts.dmi'
	pass_flags = PASSTABLE
	damage = 25
	armour_penetration = 100
	damage_type = BRUTE
	hitsound = 'sound/effects/get_over_here.ogg'
	weaken = 3
	var/chain

/obj/item/ammo_casing/magic/hook/ready_proj(atom/target, mob/living/user, quiet, zone_override = "")
	..()
	var/obj/item/projectile/hook/P = BB
	spawn(1)
		P.chain = P.Beam(user,icon_state="chain",icon = 'icons/obj/lavaland/artefacts.dmi',time=1000, maxdistance = 30,alphafade=0)

/obj/item/projectile/hook/on_hit(atom/target)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.visible_message("<span class='danger'>[L] is snagged by [firer]'s hook!</span>")
		L.forceMove(get_turf(firer))
		qdel(chain)

//Immortality Talisman
/obj/item/device/immortality_talisman
	name = "Immortality Talisman"
	desc = "A dread talisman that can render you completely invulnerable."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "talisman"
	var/cooldown = 0

/obj/item/device/immortality_talisman/Destroy(force)
	if(force)
		. = ..()
	else
		return QDEL_HINT_LETMELIVE

/obj/item/device/immortality_talisman/attack_self(mob/user)
	if(cooldown < world.time)
		feedback_add_details("immortality_talisman","U") // usage
		cooldown = world.time + 600
		user.visible_message("<span class='danger'>[user] vanishes from reality, leaving a a hole in their place!</span>")
		var/obj/effect/immortality_talisman/Z = new(get_turf(src.loc))
		Z.name = "hole in reality"
		Z.desc = "It's shaped an awful lot like [user.name]."
		Z.dir = user.dir
		user.forceMove(Z)
		user.notransform = 1
		user.status_flags |= GODMODE
		spawn(100)
			user.status_flags -= GODMODE
			user.notransform = 0
			user.forceMove(get_turf(Z))
			user.visible_message("<span class='danger'>[user] pops back into reality!</span>")
			Z.can_destroy = TRUE
			qdel(Z)

/obj/effect/immortality_talisman
	icon_state = "blank"
	icon = 'icons/effects/effects.dmi'
	burn_state = LAVA_PROOF
	var/can_destroy = FALSE

/obj/effect/immortality_talisman/attackby()
	return

/obj/effect/immortality_talisman/ex_act()
	return

/obj/effect/immortality_talisman/singularity_pull()
	return 0

/obj/effect/immortality_talisman/Destroy(force)
	if(!can_destroy && !force)
		return QDEL_HINT_LETMELIVE
	else
		. = ..()


//Shared Bag

//Internal

/obj/item/weapon/storage/backpack/shared
	name = "paradox bag"
	desc = "Somehow, it's in two places at once."
	max_combined_w_class = 60
	max_w_class = 3


//External

/obj/item/device/shared_storage
	name = "paradox bag"
	desc = "Somehow, it's in two places at once."
	icon = 'icons/obj/storage.dmi'
	icon_state = "cultpack"
	slot_flags = SLOT_BACK
	var/obj/item/weapon/storage/backpack/shared/bag


/obj/item/device/shared_storage/red
	name = "paradox bag"
	desc = "Somehow, it's in two places at once."

/obj/item/device/shared_storage/red/New()
	..()
	if(!bag)
		var/obj/item/weapon/storage/backpack/shared/S = new(src)
		var/obj/item/device/shared_storage/blue = new(src.loc)

		src.bag = S
		blue.bag = S


/obj/item/device/shared_storage/attackby(obj/item/W, mob/user, params)
	if(bag)
		bag.loc = user
		bag.attackby(W, user, params)


/obj/item/device/shared_storage/attack_hand(mob/living/carbon/user)
	if(!iscarbon(user))
		return
	if(loc == user && user.back && user.back == src)
		if(bag)
			bag.loc = user
			bag.attack_hand(user)
	else
		..()


/obj/item/device/shared_storage/MouseDrop(atom/over_object)
	if(iscarbon(usr) || isdrone(usr))
		var/mob/M = usr

		if(!over_object)
			return

		if (istype(usr.loc,/obj/mecha))
			return

		if(!M.restrained() && !M.stat)
			playsound(loc, "rustle", 50, 1, -5)


			if(istype(over_object, /obj/screen/inventory/hand))
				var/obj/screen/inventory/hand/H = over_object
				if(!M.unEquip(src))
					return
				switch(H.slot_id)
					if(slot_r_hand)
						M.put_in_r_hand(src)
					if(slot_l_hand)
						M.put_in_l_hand(src)

			add_fingerprint(usr)


//Boat

/obj/vehicle/lavaboat
	name = "lava boat"
	desc = "A boat used for traversing lava."
	icon_state = "goliath_boat"
	icon = 'icons/obj/lavaland/dragonboat.dmi'
	keytype = /obj/item/weapon/oar
	burn_state = LAVA_PROOF

/obj/vehicle/lavaboat/relaymove(mob/user, direction)
	var/turf/next = get_step(src, direction)
	var/turf/current = get_turf(src)

	if(istype(next, /turf/open/floor/plating/lava) || istype(current, /turf/open/floor/plating/lava)) //We can move from land to lava, or lava to land, but not from land to land
		..()
	else
		user << "Boats don't go on land!"
		return 0

/obj/item/weapon/oar
	name = "oar"
	icon = 'icons/obj/vehicles.dmi'
	icon_state = "oar"
	item_state = "rods"
	desc = "Not to be confused with the kind Research hassles you for."
	force = 12
	w_class = 3
	burn_state = LAVA_PROOF

/datum/crafting_recipe/oar
	name = "goliath bone oar"
	result = /obj/item/weapon/oar
	reqs = list(/obj/item/stack/sheet/bone = 2)
	time = 15
	category = CAT_PRIMAL

/datum/crafting_recipe/boat
	name = "goliath hide boat"
	result = /obj/vehicle/lavaboat
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide = 3)
	time = 50
	category = CAT_PRIMAL

//Dragon Boat


/obj/item/ship_in_a_bottle
	name = "ship in a bottle"
	desc = "A tiny ship inside a bottle."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "ship_bottle"

/obj/item/ship_in_a_bottle/attack_self(mob/user)
	user << "You're not sure how they get the ships in these things, but you're pretty sure you know how to get it out."
	playsound(user.loc, 'sound/effects/Glassbr1.ogg', 100, 1)
	new /obj/vehicle/lavaboat/dragon(get_turf(src))
	qdel(src)

/obj/vehicle/lavaboat/dragon
	name = "mysterious boat"
	desc = "This boat moves where you will it, without the need for an oar."
	keytype = null
	icon_state = "dragon_boat"
	generic_pixel_y = 2
	generic_pixel_x = 1
	vehicle_move_delay = 1

//Potion of Flight

/obj/item/weapon/wingpotion
	name = "strange elixir"
	desc = "A flask with an almost-holy aura emitting from it. The label on the bottle says 'erqo'hyy tvi'rf lbh jv'atf'"
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "potionflask"
	w_class = 2
	var/used = FALSE

/obj/item/weapon/wingpotion/attack_self(mob/living/M)
	if(used)
		M << "<span class='notice'>The flask is empty, what a shame.</span>"
	else
		if(iscarbon(M))
			var/mob/living/carbon/C = M
			CHECK_DNA_AND_SPECIES(C)
			if(C.wear_mask)
				C << "<span class='notice'>It's pretty hard to drink something with a mask on!</span>"
			else
				if(!ishumanbasic(C)) //implying xenoshumans are holy
					C << "<span class='notice'>You down the elixir, noting nothing else but a terrible aftertaste.</span>"
				else
					C << "<span class='userdanger'>You down the elixir, a terrible pain travels down your back as wings burst out!</span>"
					C.set_species(/datum/species/angel)
					playsound(loc, 'sound/items/poster_ripped.ogg', 50, 1, -1)
					C.adjustBruteLoss(20)
					C.emote("scream")
				playsound(loc, 'sound/items/drink.ogg', 50, 1, -1)
				src.used = TRUE


///Bosses




//Dragon

/obj/structure/closet/crate/necropolis/dragon
	name = "dragon chest"

/obj/structure/closet/crate/necropolis/dragon/New()
	new /obj/item/weapon/dragons_blood(src)

/obj/item/weapon/melee/ghost_sword
	name = "spectral blade"
	desc = "A rusted and dulled blade. It doesn't look like it'd do much damage. It glows weakly."
	icon_state = "spectral"
	item_state = "spectral"
	flags = CONDUCT
	sharpness = IS_SHARP
	w_class = 4
	force = 1
	throwforce = 1
	hitsound = 'sound/effects/ghost2.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "torn", "ripped", "diced", "rended")
	var/summon_cooldown = 0
	var/list/mob/dead/observer/spirits

/obj/item/weapon/melee/ghost_sword/New()
	..()
	spirits = list()
	START_PROCESSING(SSobj, src)
	poi_list |= src

/obj/item/weapon/melee/ghost_sword/Destroy()
	for(var/mob/dead/observer/G in spirits)
		G.invisibility = initial(G.invisibility)
	spirits.Cut()
	STOP_PROCESSING(SSobj, src)
	poi_list -= src
	. = ..()

/obj/item/weapon/melee/ghost_sword/attack_self(mob/user)
	if(summon_cooldown > world.time)
		user << "You just recently called out for aid. You don't want to annoy the spirits."
		return
	user << "You call out for aid, attempting to summon spirits to your side."

	notify_ghosts("[user] is raising their [src], calling for your help!",
		enter_link="<a href=?src=\ref[src];orbit=1>(Click to help)</a>",
		source = user, action=NOTIFY_ORBIT)

	summon_cooldown = world.time + 600

/obj/item/weapon/melee/ghost_sword/Topic(href, href_list)
	if(href_list["orbit"])
		var/mob/dead/observer/ghost = usr
		if(istype(ghost))
			ghost.ManualFollow(src)

/obj/item/weapon/melee/ghost_sword/process()
	ghost_check()

/obj/item/weapon/melee/ghost_sword/proc/ghost_check()
	var/ghost_counter = 0
	var/turf/T = get_turf(src)
	var/list/contents = T.GetAllContents()
	var/mob/dead/observer/current_spirits = list()
	for(var/mob/dead/observer/G in dead_mob_list)
		if(G.orbiting in contents)
			ghost_counter++
			G.invisibility = 0
			current_spirits |= G

	for(var/mob/dead/observer/G in spirits - current_spirits)
		G.invisibility = initial(G.invisibility)

	spirits = current_spirits

	return ghost_counter

/obj/item/weapon/melee/ghost_sword/attack(mob/living/target, mob/living/carbon/human/user)
	force = 0
	var/ghost_counter = ghost_check()

	force = Clamp((ghost_counter * 4), 0, 75)
	user.visible_message("<span class='danger'>[user] strikes with the force of [ghost_counter] vengeful spirits!</span>")
	..()

/obj/item/weapon/melee/ghost_sword/hit_reaction(mob/living/carbon/human/owner, attack_text, final_block_chance, damage, attack_type)
	var/ghost_counter = ghost_check()
	final_block_chance += Clamp((ghost_counter * 5), 0, 75)
	owner.visible_message("<span class='danger'>[owner] is protected by a ring of [ghost_counter] ghosts!</span>")
	return ..()

//Blood

/obj/item/weapon/dragons_blood
	name = "bottle of dragons blood"
	desc = "You're not actually going to drink this, are you?"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"

/obj/item/weapon/dragons_blood/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return

	var/mob/living/carbon/human/H = user
	user << "<span class='danger'>You feel like you could walk straight through lava now.</span>"
	H.weather_immunities |= "lava"

	playsound(user.loc,'sound/items/drink.ogg', rand(10,50), 1)
	qdel(src)

/datum/disease/transformation/dragon
	name = "dragon transformation"
	cure_text = "nothing"
	cures = list("adminordrazine")
	agent = "dragon's blood"
	desc = "What do dragons have to do with Space Station 13?"
	stage_prob = 20
	severity = BIOHAZARD
	visibility_flags = 0
	stage1	= list("Your bones ache.")
	stage2	= list("Your skin feels scaley.")
	stage3	= list("<span class='danger'>You have an overwhelming urge to terrorize some peasants.</span>", "<span class='danger'>Your teeth feel sharper.</span>")
	stage4	= list("<span class='danger'>Your blood burns.</span>")
	stage5	= list("<span class='danger'>You're a fucking dragon. However, any previous allegiances you held still apply. It'd be incredibly rude to eat your still human friends for no reason.</span>")
	new_form = /mob/living/simple_animal/hostile/megafauna/dragon/lesser


//Lava Staff

/obj/item/weapon/lava_staff
	name = "staff of lava"
	desc = "The ability to fill the emergency shuttle with lava. What more could you want out of life?"
	icon_state = "staffofstorms"
	item_state = "staffofstorms"
	icon = 'icons/obj/guns/magic.dmi'
	slot_flags = SLOT_BACK
	item_state = "staffofstorms"
	w_class = 4
	force = 25
	damtype = BURN
	burn_state = LAVA_PROOF
	hitsound = 'sound/weapons/sear.ogg'
	var/turf_type = /turf/open/floor/plating/lava/smooth
	var/cooldown = 200
	var/timer = 0
	var/banned_turfs

/obj/item/weapon/lava_staff/New()
	. = ..()
	banned_turfs = typecacheof(list(/turf/open/space/transit, /turf/closed))

/obj/item/weapon/lava_staff/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	..()
	if(timer > world.time)
		return

	if(is_type_in_typecache(target, banned_turfs))
		return

	if(target in view(user.client.view, get_turf(user)))
		var/turf/T = get_turf(target)
		message_admins("[key_name_admin(user)] fired the lava staff at (<A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[T.x];Y=[T.y];Z=[T.z]'>[get_area(target)] ([T.x], [T.y], [T.z])</a>).")
		log_game("[key_name(user)] fired the lava staff at [get_area(target)] ([T.x], [T.y], [T.z]).")

		var/turf/open/O = target
		user.visible_message("<span class='danger'>[user] turns \the [O] into lava!</span>")
		O.ChangeTurf(turf_type)
		playsound(get_turf(src),'sound/magic/Fireball.ogg', 200, 1)
		timer = world.time + cooldown

//Runite Scimitar

/obj/item/weapon/rune_scimmy
	name = "rune scimitar"
	desc = "A curved sword smelted from an unknown metal. Looking at it gives you the otherworldly urge to pawn it off for '30k,' whatever that means."
	icon = 'icons/obj/lavaland/artefacts.dmi'
	icon_state = "rune_scimmy"
	force = 25
	damtype = BRUTE
	sharpness = IS_SHARP
	hitsound = 'sound/weapons/rs_slash.ogg'
	attack_verb = list("slashed","pk'd","atk'd")

///Bubblegum

/obj/item/mayhem
	name = "mayhem in a bottle"
	desc = "A magically infused bottle of blood, the scent of which will drive anyone nearby into a murderous frenzy."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"

/obj/item/mayhem/attack_self(mob/user)
	for(var/mob/living/carbon/human/H in range(7,user))
		spawn()
			var/obj/effect/mine/pickup/bloodbath/B = new(H)
			B.mineEffect(H)
	user << "<span class='notice'>You shatter the bottle!</span>"
	playsound(user.loc, 'sound/effects/Glassbr1.ogg', 100, 1)
	qdel(src)

/obj/structure/closet/crate/necropolis/bubblegum
	name = "bubblegum chest"

/obj/structure/closet/crate/necropolis/bubblegum/New()
	..()
	var/loot = rand(1,3)
	switch(loot)
		if(1)
			new /obj/item/weapon/antag_spawner/slaughter_demon(src)
		if(2)
			new /obj/item/bloodvial/bloodcrawl(src)
		if(3)
			new /obj/item/bloodvial/saw(src)

/obj/item/blood_contract
	name = "blood contract"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	color = "#FF0000"
	desc = "Mark your target for death. "
	var/used = FALSE

/obj/item/blood_contract/attack_self(mob/user)
	if(used)
		return
	used = TRUE
	var/choice = input(user,"Who do you want dead?","Pick Reinforcement") as null|anything in player_list

	if(!(isliving(choice)))
		user << "[choice] is already dead!"
		used = FALSE
	else

		var/mob/living/L = choice

		message_admins("<span class='adminnotice'>[L] has been marked for death!</span>")

		var/datum/objective/survive/survive = new
		survive.owner = L.mind
		L.mind.objectives += survive
		L << "<span class='userdanger'>You've been marked for death! Don't let the demons get you!</span>"
		L.color = "#FF0000"
		spawn()
			var/obj/effect/mine/pickup/bloodbath/B = new(L)
			B.mineEffect(L)

		for(var/mob/living/carbon/human/H in player_list)
			if(H == L)
				continue
			H << "<span class='userdanger'>You have an overwhelming desire to kill [L]. They have been marked red! Go kill them!</span>"
			H.equip_to_slot_or_del(new /obj/item/weapon/kitchen/knife/butcher(H), slot_l_hand)

	qdel(src)

/obj/item/bloodvial//parent typing for identical looking loot
	name = "vial of blood" //aestetically identical to the demon spawner
	desc = "A magically infused bottle of blood, distilled from countless murder victims. Used in unholy rituals to attract horrifying creatures."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"
	var/waiting = FALSE


/obj/item/bloodvial/bloodcrawl

/obj/item/bloodvial/bloodcrawl/attack_self(mob/living/carbon/user)
	if(waiting)
		return
	if(user.z != ZLEVEL_STATION) //so you can't see if it's demon spawner on lavaland
		user << "<span class='notice'>You should probably wait until you reach the station.</span>"
		return
	user << "<span class='notice'>You start working up the nerve to shatter the bottle...</span>"
	waiting = TRUE
	sleep(50)
	waiting = FALSE
	if(user.bloodcrawl == BLOODCRAWL || user.bloodcrawl == BLOODCRAWL_EAT)
		user <<"<span class='warning'>You break [src], but nothing happens.../span>"
		qdel(src)
		return
	user <<"<span class='warning'>You break [src], feeling immense power overcome you.../span>"
	user.bloodcrawl = BLOODCRAWL
	playsound(user.loc, 'sound/effects/Glassbr1.ogg', 100, 1)
	qdel(src)

/obj/item/bloodvial/saw

/obj/item/bloodvial/saw/attack_self(mob/living/carbon/user)
	if(user.z != ZLEVEL_STATION) //so you can't see if it's demon spawner on lavaland
		user << "<span class='notice'>You should probably wait until you reach the station.</span>"
		return
	playsound(user.loc, 'sound/effects/Glassbr1.ogg', 100, 1)
	user.unEquip(src)
	var/obj/item/weapon/chainsaw_bubblegum/C = new
	user.put_in_active_hand(C)
	qdel(src)


/obj/item/weapon/chainsaw_bubblegum
	name = "demonic chainsaw"
	desc = "You almost regret picking this up."
	force = 28
	icon_state = "chainsaw_on"
	item_state = "mounted_chainsaw"
	w_class = 5
	flags = NODROP | ABSTRACT
	sharpness = IS_SHARP
	attack_verb = list("sawed", "torn", "cut", "chopped", "diced","eviscerated")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	armour_penetration = 30
	color = "#FF0000"
	block_chance = 30
	var/recalled = FALSE

/obj/item/weapon/chainsaw_bubblegum/equipped(mob/living/user)
	..()
	for(var/obj/effect/proc_holder/spell/targeted/summonsaw/spell in user.mind.spell_list)
		user.mind.RemoveSpell(spell)//removes summon spell if they got it before
	user.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/summonsaw(src))

/obj/item/weapon/chainsaw_bubblegum/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is feeding \himself to \the [src.name]! It looks like \he's trying to join Bubblegum!</span>")
	visible_message("<span class='warning'><b>[src] devours [user]!</b></span>")
	playsound(user.loc, 'sound/magic/Demon_consume.ogg', 100, 1)
	qdel(user)

/obj/item/weapon/chainsaw_bubblegum/afterattack(mob/living/target, mob/living/user)
	..()
	if(ishuman(target))
		if(target.stat != DEAD)
			user.adjustBruteLoss(-(force / 2))
			user << "<span class='notice'>[src] absorbs the strength of [target] and rejuvenates you!</span>"

/obj/effect/proc_holder/spell/targeted/summonsaw
	name = "Summon Chainsaw"
	desc = "Summon Bubblegum's Chainsaw."
	action_icon_state = "bloodcrawl"
	charge_max = 10
	clothes_req = 0
	range = -1
	level_max = 0
	include_user = 1


/obj/effect/proc_holder/spell/targeted/summonsaw/cast(mob/living/carbon/human/user)
	if(locate(/obj/item/weapon/chainsaw_bubblegum) in user)
		var/obj/item/weapon/chainsaw_bubblegum/S = locate(/obj/item/weapon/chainsaw_bubblegum)
		if(S.recalled == FALSE)
			S.flags &= ~NODROP
			user.unEquip(S)
			S.loc = user
			user.visible_message("<span class='warning'><b>[S] assimilates itself into [usr]'s body!</b></span>")
			playsound(get_turf(src), 'sound/magic/enter_blood.ogg', 100, 1, -1)
			S.recalled = TRUE
		else
			S.flags |= NODROP
			user.put_in_active_hand(S)
			user.visible_message("<span class='warning'><b>[user]'s arm is suddenly engulfed in blood, which molds itself into [S]!</b></span>")
			playsound(get_turf(user), 'sound/magic/exit_blood.ogg', 100, 1, -1)
			playsound(get_turf(user),'sound/effects/splat.ogg', 100, 1, -1)
			S.recalled = FALSE
	else
		user.mind.RemoveSpell(src)

