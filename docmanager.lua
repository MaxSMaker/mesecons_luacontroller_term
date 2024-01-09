mesecons_luacontroller_term.lc_docs = {}

--Other mods can place their own examples in here.
--The table key will be used as the name.
mesecons_luacontroller_term.lc_docs.examples = {}

minetest.register_on_mods_loaded(function()
	--Build a list of example names so that the order will stay the same when the formspecs are redrawn
	mesecons_luacontroller_term.lc_docs.example_order = {}
	for k in pairs(mesecons_luacontroller_term.lc_docs.examples) do
		table.insert(mesecons_luacontroller_term.lc_docs.example_order,k)
	end
	table.sort(mesecons_luacontroller_term.lc_docs.example_order)
end)

function mesecons_luacontroller_term.lc_docs.generate_example_formspec(sel_index)
	sel_index = math.max(sel_index,1)
	sel_index = math.min(sel_index,#mesecons_luacontroller_term.lc_docs.example_order)
	local selected_text = mesecons_luacontroller_term.lc_docs.examples[mesecons_luacontroller_term.lc_docs.example_order[sel_index]]
	local fs = "textlist[0.25,0.6;3,9.05;example_list;"
	for _,i in ipairs(mesecons_luacontroller_term.lc_docs.example_order) do
		fs = fs..minetest.formspec_escape(i)..","
	end
	fs = string.sub(fs,1,-2)..";"..sel_index..";false]"
	.."textarea[3.25,0.6;11.5,8.05;;;"..minetest.formspec_escape(selected_text).."]"
	return fs
end

local included_examples = {
	["R/S Latch"] = "rslatch.lua",
	["Clock"] = "clock.lua",
	["LCD Counter"] = "counter.lua",
}

for k,v in pairs(included_examples) do
	local f = io.open(minetest.get_modpath("mesecons_luacontroller_term")..DIR_DELIM.."examples"..DIR_DELIM..v,"r")
	mesecons_luacontroller_term.lc_docs.examples[k] = f:read("*all")
	f:close()
end

--Other mods can provide their own help pages too, but the order of these must be specified and is not automatically sorted.
--In this table, the key is a number representing the position in the list, and the value is the description.
mesecons_luacontroller_term.lc_docs.help_order = {}
--In this table, the key is the description and the value in the content.
mesecons_luacontroller_term.lc_docs.help_pages = {}

function mesecons_luacontroller_term.lc_docs.generate_help_formspec(sel_index)
	sel_index = math.max(sel_index,1)
	sel_index = math.min(sel_index,#mesecons_luacontroller_term.lc_docs.help_order)
	local selected_text = mesecons_luacontroller_term.lc_docs.help_pages[mesecons_luacontroller_term.lc_docs.help_order[sel_index]]
	local fs = "textlist[0.25,0.6;3,9.05;help_list;"
	for _,i in ipairs(mesecons_luacontroller_term.lc_docs.help_order) do
		fs = fs..minetest.formspec_escape(i)..","
	end
	fs = string.sub(fs,1,-2)..";"..sel_index..";false]"
	.."textarea[3.25,0.6;11.5,9.05;;;"..minetest.formspec_escape(selected_text).."]"
	return fs
end

local included_help_order = {
	"Introduction",
	"Events",
	"Lua Functions",
	"Mesecons I/O",
	"Terminal I/O",
	"Digilines I/O",
	"Interrupts",
}

local included_help_content = {
	["Introduction"] = "introduction.txt",
	["Events"] = "events.txt",
	["Lua Functions"] = "luafunctions.txt",
	["Mesecons I/O"] = "mesecons.txt",
	["Terminal I/O"] = "terminal.txt",
	["Digilines I/O"] = "digilines.txt",
	["Interrupts"] = "interrupts.txt",
}

for _,v in ipairs(included_help_order) do
	local filename = included_help_content[v]
	local f = io.open(minetest.get_modpath("mesecons_luacontroller_term")..DIR_DELIM.."help"..DIR_DELIM..filename,"r")
	table.insert(mesecons_luacontroller_term.lc_docs.help_order,v)
	mesecons_luacontroller_term.lc_docs.help_pages[v] = f:read("*all")
	f:close()
end
