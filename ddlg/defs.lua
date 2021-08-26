-- button
{
    type = "button",
    id = string,
    label = string,
    text = string,
    selected = boolean
    focus = boolean,
    onclick = function
}

-- check box
{
    type = "(check-box)|(check)",
    id = string,
    label = string,
    text = string,
    selected = boolean,
    onclick = function
}

-- color
{
    type = "color",
    id = string,
    label = string,
    color = color
}

--  combo box
{
    type = "(combo-box)|(drop-down)|(combobox)",
    id = string,
    label = string,
    option = string,
    options = string,
    onchange = function
}

-- text entry
{
    type = "(text)|(entry)",
    id = string,
    label = string,
    text = string,
}

-- label
{
    type = "label",
    id = string,
    label = string
    text = string
}

-- number entry
{
    type = "number",
    label = string,
    text = string,
    decimals = integer
}

-- radio button
{
    type = "radio",
    id = string,
    label = string,
    text = string,
    selected = boolean
    onclick = function
}

-- separator
{
    type = "separator",
    id = string,
    label = string,
    text = string
}

-- shades
{
    type = "shades",
    id = string,
    label = string,
    mode = "pick" | "sort",
    colors = { color1, color2, color3, ... },
    onclick = function
}

-- slider
{
    type = "slider",
    id = string,
    label = string,
    min = integer,
    max = integer,
    value = integer,
    onchange = function
}

-- file
{
    type = "file",
    id = string,
    label = string,
    title = string,
    open = boolean,
    save = boolean,
    filename = string | { string1, string2, string3 ... },
    filetypes = { string1, string2, string3 ... },
    onchange = function
}