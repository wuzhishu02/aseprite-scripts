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
    label = string,
    text = string,
    decimals = integer
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