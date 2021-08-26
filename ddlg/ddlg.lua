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
            obj.idList = table.concat(newIdList, ", ")
            -- obj.idList = newIdList
            table.insert(arr, obj)
        end

        return arr
    end

    local title = dlg.title
    local onclose = dlg.onclose
    local items = flatten(dlg, {}, true)

    print("title: " .. title)
    print("items: ")
    for _, item in ipairs(items) do
        print("  {")
        for key, value in pairs(item) do
            print("    " .. key  .. ": " .. tostring(value))
        end
        print("  },")
    end
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
            color = { r = 0xFF, g = 0xFF, b = 0xFF }
        },
        {
            type = "shades",
            id = "color-2",
            label = "Color 2",
            mode = "pick",
            colors = {
                { r = 0xFF, g = 0xFF, b = 0xFF },
                { r = 0x7F, g = 0x7F, b = 0x7F },
                { r = 0x00, g = 0x00, b = 0x00 }
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
                text = "B",
                selected = true
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
                text = "B",
                selected = true
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
            label = "&OK"
        },
        {
            type = "button",
            id = "calcel",
            label = "&Cancel"
        }
    }
}