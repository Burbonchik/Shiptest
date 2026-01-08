/obj/machinery/computer/fusion/core_control
	name = "\improper R-UST Mk. 8 core control"

// Переопределяем ui_interact для своего интерфейса
/obj/machinery/computer/fusion/core_control/ui_interact(mob/user, datum/tgui/ui = null)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FusionCoreControl", name)
		ui.open()

// Специфичные данные для управления ядрами
/obj/machinery/computer/fusion/core_control/ui_data(mob/user)
	var/list/data = list()
	var/list/cores = list()
	
	// Ищем все ядра с таким же тегом
	var/core_count = 0
	for(var/obj/machinery/power/fusion_core/C in GLOB.machines)
		if(C.id_tag == id_tag)
			core_count++
			
			var/list/core_data = list()
			core_data["id"] = "#[core_count]"
			core_data["ref"] = "\ref[C]"
			core_data["active"] = !isnull(C.owned_field)
			core_data["field_strength"] = C.field_strength
			core_data["size"] = C.owned_field ? C.owned_field.size : 0
			core_data["instability"] = C.owned_field ? C.owned_field.percent_unstable * 100 : 0
			core_data["temperature"] = C.owned_field ? C.owned_field.plasma_temperature + 295 : 0
			core_data["power_usage"] = C.active_power_usage
			core_data["power_available"] = C.avail()
			
			// Топливо передаем как список
			var/list/fuel_list = list()
			if(C.owned_field && LAZYLEN(C.owned_field.reactants))
				for(var/reactant in C.owned_field.reactants)
					var/list/fuel_entry = list(
						"name" = reactant,
						"amount" = C.owned_field.reactants[reactant]
					)
					fuel_list += list(fuel_entry)
			
			core_data["fuel"] = fuel_list
			cores += list(core_data)
	
	data["cores"] = cores
	data["id_tag"] = id_tag
	data["connected_cores"] = core_count
	return data

// Специфичные действия для управления ядрами
/obj/machinery/computer/fusion/core_control/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return TRUE
	
	. = FALSE
	
	switch(action)
		// Включить/Выключить ядро
		if("toggle_active")
			var/obj/machinery/power/fusion_core/C = locate(params["machine"])
			if(!istype(C))
				return
			
			// Проверяем тег
			if(C.id_tag != id_tag)
				to_chat(usr, "<span class='warning'>Ядро имеет другой тег!</span>")
				return
			
			if(!C.check_core_status())
				return
			
			if(!C.Startup()) // Если Startup() вернул FALSE, ядро уже активно
				if(alert(usr, "Аварийное отключение вызовет повреждения. Продолжить?", "Отключение", "Да", "Нет") == "Нет")
					return
				C.Shutdown()
			
			. = TRUE
			ui.update()
		
		// Изменить мощность
		if("set_strength")
			var/obj/machinery/power/fusion_core/C = locate(params["machine"])
			var/val = text2num(params["value"])
			
			if(!istype(C) || isnull(val))
				return
			
			if(C.id_tag != id_tag)
				to_chat(usr, "<span class='warning'>Ядро имеет другой тег!</span>")
				return
			
			if(!C.check_core_status())
				return
			
			if(val == 0) // Ручной ввод
				var/new_val = input(usr, "Введите новую плотность мощности (Вт/м³)", "Контроль синтеза", C.field_strength) as num|null
				if(!isnull(new_val))
					C.set_strength(new_val)
			else
				C.set_strength(C.field_strength + val)
			
			. = TRUE
			ui.update()
	
	return