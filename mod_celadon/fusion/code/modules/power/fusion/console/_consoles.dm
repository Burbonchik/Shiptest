/obj/machinery/computer/fusion
	icon_keyboard = "power_key"
	icon_screen = "rust_screen"
	light_color = COLOR_ORANGE
	idle_power_usage = 250
	active_power_usage = 500
	var/initial_id_tag // Для маппинга
	var/id_tag = "fusion_default" // Тег для группировки с ядрами
	var/datum/tgui/ui

/obj/machinery/computer/fusion/Initialize()
	if(initial_id_tag)
		id_tag = initial_id_tag
	. = ..()

/obj/machinery/computer/fusion/interface_interact(mob/user)
	ui_interact(user)
	return TRUE

/obj/machinery/computer/fusion/use_tool(obj/item/tool, mob/living/user, list/click_params)
	if(isMultitool(tool))
		var/new_id = input(user, "Введите тег для этой консоли:", "Настройка сети", id_tag) as text|null
		if(!new_id || !user.Adjacent(src))
			return TRUE

		new_id = sanitize(new_id, 20)
		if(!new_id)
			to_chat(user, "<span class='warning'>Неверный тег!</span>")
			return TRUE

		id_tag = new_id
		to_chat(user, "<span class='notice'>Тег консоли установлен: '[id_tag]'.</span>")

		// Обновляем интерфейс если открыт
		if(ui)
			ui.update()
		return TRUE
	return ..()

/obj/machinery/computer/fusion/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/multitool))
		var/obj/item/multitool/multi = O
		multi.buffer = src
		to_chat(user, span_notice("[src] stored in [O]."))
		return TRUE

	return ..()

// Базовый TGUI интерфейс для общих консолей fusion
/obj/machinery/computer/fusion/ui_interact(mob/user, datum/tgui/ui = null)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FusionConsole", name)
		ui.open()

// Базовые данные для консолей
/obj/machinery/computer/fusion/ui_data(mob/user)
	var/list/data = list()
	data["id_tag"] = id_tag
	data["console_name"] = name
	return data

// Базовый обработчик действий
/obj/machinery/computer/fusion/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return TRUE

	. = FALSE

	switch(action)
		if("change_id_tag")
			var/new_id = input(usr, "Введите новый тег:", "Изменение тега", id_tag) as text|null
			if(!isnull(new_id))
				new_id = sanitize(new_id, 20)
				if(new_id)
					id_tag = new_id
					. = TRUE
					ui.send_update()
	return
