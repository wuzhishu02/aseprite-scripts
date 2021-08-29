local parse = function(dlg)
    -- flatten layerd structure
    --   obj: layerd structure
    --   idList: current and ancestor id list
    --   panretDirection: true when vertical, false when horizontal
    local internalId = 0
    function flatten(obj, idList, parentDirection)
        local arr = {}

        if type(obj) ~= "table" then
            return {}
        end

        -- create new id list
        local newIdList = {}
        table.move(idList, 1, #idList, 1, newIdList)
        if type(obj.id) == "string" then
            table.insert(newIdList, 1, obj.id)
        end

        if obj[1] then
            -- obj is array
            local direction = parentDirection
            if obj.direction == "vertical" then
                direction = true
            elseif obj.direction == "horizontal" then
                direction = false
            end

            local isFirst = true
            for _, item in ipairs(obj) do
                if direction then
                    -- insert "newrow" before element except the first one
                    if isFirst then
                        isFirst = false
                    else
                        table.insert(arr, {
                            type = "newrow"
                        })
                    end
                end

                for _, o in ipairs(flatten(item, newIdList, direction)) do
                    table.insert(arr, o)
                end
            end
        else
            obj.id = "" .. internalId
            obj.idList = table.concat(newIdList, ", ")
            -- obj.idList = newIdList
            table.insert(arr, obj)
            internalId = internalId + 1
        end

        return arr
    end

    local title = dlg.title
    local onclose = dlg.onclose
    local items = flatten(dlg, {}, true)

    -- print("title: " .. title)
    -- print("items: ")
    -- for _, item in ipairs(items) do
    --     print("  {")
    --     for key, value in pairs(item) do
    --         print("    " .. key  .. ": " .. tostring(value))
    --     end
    --     print("  },")
    -- end

    -- bounds

    local dialog = nil
    if title then
        if onclose then
            dialog = Dialog {
                title = title,
                onclose = onclose
            }
        else
            dialog = Dialog(title)
        end
    else
        dialog = Dialog()
    end

    for _, item in ipairs(items) do
        if item.type == "newrow" then
            dialog:newrow()
        elseif item.type == "button" then
            dialog:button {
                id = item.id,
                label = item.label,
                text = item.text,
                selected = item.selected,
                focus = item.focus,
                onclick = item.onclick
            }
        elseif item.type == "check-box" or item.type == "check" then
            dialog:check {
                id = item.id,
                label = item.label,
                text = item.text,
                selected = item.selected,
                onclick = item.onclick
            }
        elseif item.type == "color" then
            dialog:color {
                id = item.id,
                label = item.label,
                color = item.color
            }
        elseif item.type == "combo-box" or item.type == "drop-down" or item.type == "combobox" then
            dialog:combobox {
                id = item.id,
                label = item.label,
                option = item.option,
                options = item.options,
                onchange = item.onchange
            }
        elseif item.type == "text" or item.type == "entry" then
            dialog:entry {
                id = item.id,
                label = item.label,
                text = item.text,
                focus = item.focus
            }
        elseif item.type == "label" then
            dialog:label {
                id = item.id,
                label = item.label,
                text = item.text
            }
        elseif item.type == "number" then
            dialog:number {
                id = item.id,
                label = item.label,
                text = item.text,
                decimals = item.decimals
            }
        elseif item.type == "radio" then
            dialog:radio {
                id = item.id,
                label = item.label,
                text = item.text,
                selected = item.selected,
                onclick = item.onclick
            }
        elseif item.type == "separator" then
            dialog:separator {
                id = item.id,
                label = item.label,
                text = item.text
            }
        elseif item.type == "shades" then
            dialog:shades {
                id = item.id,
                label = item.label,
                mode = item.mode,
                colors = item.colors,
                onclick = item.onclick
            }
        elseif item.type == "slider" then
            dialog:slider {
                id = item.id,
                label = item.label,
                min = item.min,
                max = item.max,
                value = item.value,
                onchange = item.onchange
            }
        elseif item.type == "file" then
            dialog:file {
                id = item.id,
                label = item.label,
                title = item.title,
                open = item.open,
                save = item.save,
                filename = item.filename,
                filetypes = item.filetypes,
                onchange = item.onchange
            }
        end
    end

    return dialog
end

parse {
    title = "test",
    {
        type = "separator",
        text = "colors"
    },
    {
        direction = "horizontal",
        id = "colors",
        {
            type = "color",
            id = "color-1",
            label = "Color 1",
            color = Color { r = 0xFF, g = 0xFF, b = 0xFF }
        },
        {
            type = "shades",
            id = "color-2",
            label = "Color 2",
            mode = "sort",
            colors = {
                Color { r = 0xFF, g = 0xFF, b = 0xFF },
                Color { r = 0x7F, g = 0x7F, b = 0x7F },
                Color { r = 0x00, g = 0x00, b = 0x00 }
            }
        }
    },
    {
        type = "separator",
        text = "selection"
    },
    {
        id = "checks",
        {
            type = "check-box",
            id = "check-1",
            label = "check",
            text = "Check?",
            selected = true
        },
        {
            type = "combo-box",
            id = "combo-1",
            label = "combo",
            option = "apple",
            options = { "apple", "banana", "orange" }
        },
        {
            direction = "horizontal",
            id = "radio1",
            {
                type = "radio",
                id = "radio-1-a",
                label = "Group 1",
                text = "A",
                selected = true
            },
            {
                type = "radio",
                id = "radio-1-b",
                text = "B"
            }
        },
        {
            id = "radio2",
            {
                type = "radio",
                id = "radio-2-a",
                label = "Group 2",
                text = "A",
                selected = true
            },
            {
                type = "radio",
                id = "radio-2-b",
                text = "B"
            }
        }
    },
    {
        type = "separator",
        text = "misc"
    },
    {
        direction = "vertical",
        id = "misc",
        {
            type = "label",
            id = "label",
            label = "hello",
            text = "world"
        },
        {
            type = "text",
            id = "text",
            label = "text",
            text = "any text"
        },
        {
            id = "number",
            type = "number",
            label = "number",
            decimals = 10
        },
        {
            type = "button",
            id = "button",
            label = "button",
            text = "PUSH"
        },
        {
            type = "slider",
            id = "slider",
            label = "slider",
            min = 0,
            max = 10,
            value = 0
        },
        {
            type = "file",
            id = "file",
            label = "file",
            title = "Open",
            open = true,
            save  = false,
            filetypes = { "ase", "aseprite" }
        }
    },
    {
        type = "separator"
    },
    {
        direction = "horizontal",
        {
            type = "button",
            id = "ok",
            text = "&OK"
        },
        {
            type = "button",
            id = "calcel",
            text = "&Cancel"
        }
    }
}:show()