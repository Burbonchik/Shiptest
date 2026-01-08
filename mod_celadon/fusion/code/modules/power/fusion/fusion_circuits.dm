/obj/item/stock_parts/circuitboard/fusion/computer/core_control
	name = "Fusion Core Controller (Computer Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/computer/fusion/core_control

/obj/item/circuitboard/computer/fusion_fuel_control
	name = "Fusion Fuel Controller (Computer Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/computer/fusion/fuel_control

/obj/item/circuitboard/computer/gyrotron_control
	name = "Gyrotron Controller (Computer Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/computer/fusion/gyrotron

/obj/item/circuitboard/kinetic_harvester
	name = "Kinetic Harvester (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/kinetic_harvester
	req_components = list(
		/obj/item/stock_parts/manipulator/pico = 2,
		/obj/item/stock_parts/matter_bin/super = 1,
		/obj/item/stack/cable_coil = 5
		)

/obj/item/circuitboard/fusion_fuel_compressor
	name = "Fusion Fuel Compressor (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/fusion_fuel_compressor
	req_components = list(
		/obj/item/stock_parts/manipulator/pico = 2,
		/obj/item/stock_parts/matter_bin/super = 2,
		/obj/item/stack/cable_coil = 5
		)

/obj/item/stock_parts/circuitboard/fusion_core
	name = "Fusion Core (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/power/fusion_core
	req_components = list(
		/obj/item/stock_parts/manipulator/pico = 2,
		/obj/item/stock_parts/micro_laser/ultra = 1,
		/obj/item/stock_parts/subspace/crystal = 1,
		/obj/item/stack/cable_coil = 5
		)

/obj/item/stock_parts/circuitboard/fusion_injector
	name = "Fusion Fuel Injector (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/fusion_fuel_injector
	req_components = list(
		/obj/item/stock_parts/manipulator/pico = 2,
		/obj/item/stock_parts/scanning_module/phasic = 1,
		/obj/item/stock_parts/matter_bin/super = 1,
		/obj/item/stack/cable_coil = 5
		)

/obj/item/stock_parts/circuitboard/gyrotron
	name = "Gyrotron (Machine Board)"
	icon_state = "engineering"
	build_path = /obj/machinery/power/emitter/gyrotron
	req_components = list(
		/obj/item/stack/cable_coil = 20,
		/obj/item/stock_parts/micro_laser/ultra = 2
		)

/datum/design/circuit/fusion
	name = "fusion core control console"
	id = "fusion_core_control"
	build_path = /obj/item/stock_parts/circuitboard/fusion/core_control
	sort_string = "LAAAD"
	req_tech = list(TECH_POWER = 3, TECH_ENGINEERING = 3, TECH_MATERIAL = 3)

/datum/design/circuit/fusion/fuel_compressor
	name = "fusion fuel compressor"
	id = "fusion_fuel_compressor"
	build_path = /obj/item/stock_parts/circuitboard/fusion_fuel_compressor
	sort_string = "LAAAE"

/datum/design/circuit/fusion/fuel_control
	name = "fusion fuel control console"
	id = "fusion_fuel_control"
	build_path = /obj/item/stock_parts/circuitboard/fusion_fuel_control
	sort_string = "LAAAF"

/datum/design/circuit/fusion/gyrotron_control
	name = "gyrotron control console"
	id = "gyrotron_control"
	build_path = /obj/item/stock_parts/circuitboard/gyrotron_control
	sort_string = "LAAAG"

/datum/design/circuit/fusion/core
	name = "fusion core"
	id = "fusion_core"
	build_path = /obj/item/stock_parts/circuitboard/fusion_core
	sort_string = "LAAAH"

/datum/design/circuit/fusion/injector
	name = "fusion fuel injector"
	id = "fusion_injector"
	build_path = /obj/item/stock_parts/circuitboard/fusion_injector
	sort_string = "LAAAI"

/datum/design/circuit/fusion/kinetic_harvester
	name = "fusion toroid kinetic harvester"
	id = "fusion_kinetic_harvester"
	build_path = /obj/item/stock_parts/circuitboard/kinetic_harvester
	sort_string = "LAAAJ"
	req_tech = list(TECH_DATA = 4, TECH_ENGINEERING = 4, TECH_MATERIAL = 4)

/datum/design/circuit/fusion/gyrotron
	name = "gyrotron"
	id = "gyrotron"
	build_path = /obj/item/stock_parts/circuitboard/gyrotron
	sort_string = "LAAAK"
